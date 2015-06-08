/**
* Author:       Ben Edwards (Tquila)
* Date:         29/05/2015
* Description:  Class to handle callouts to the Address Validation service
*
* ******************* Change Log *******************
* Modified by       Change Date     Change
* Ben Edwards       29/05/2015      Initial creation.
**/
global class AddressValidationService {
	

	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         29/05/2015
	* Description:  Universal method to accept a list of records and validate their addresses
	* 				Documentation for the service can be found at http://www.postcodeanywhere.co.uk/Support/WebService/CleansePlus/Batch/Cleanse/1/
	**/
	public static List<AddressWrapper> validateAddress(List<sObject> records, AddressProperties addressProperties) {

		// Create a list of formatted address to validate
		List<AddressWrapper> addressesToValidate = createAddressList(records, addressProperties);

		// Postcode Anywhere key. Used for callout to PostcodeAnywhere service
		String postCodeAnywhereKey;

		try {

			// Query for postcode key
			// This assumes the Salesforce app is installed and key setup in Salesforce.
			// This could be controlled here or via a Custom Setting if app isn't installed.
			postCodeAnywhereKey = [SELECT pca__Key__c FROM pca__PostcodeAnywhereSettings__c][0].pca__Key__c;
		}
		catch (Exception ex) {

			system.debug('### Could not find PostcodeAnywhere key:' + ex);
		}

		// If key was found
		if (postCodeAnywhereKey != null) {

			// Array of addresses for the callout. PostcodeAnywhere supports 1000 addresses at a time, but will probably
			// Run batch at a lower amount (200)
			AddressValidationWSDL.ArrayForAddresses addresses = new AddressValidationWSDL.ArrayForAddresses();

			// Build the list of addresses
			addresses.Addresses = new List<String>();

			// Iterate over records to validate
			for (AddressWrapper add :addressesToValidate) {

				// Add the final address string to the list of address
				addresses.Addresses.add(add.addressToValidate);
			}

			// Execute callout
			AddressValidationWSDL.PostcodeAnywhere_Soap callout = new AddressValidationWSDL.PostcodeAnywhere_Soap();
			AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_ArrayOfResults results = callout.CleansePlus_Batch_Cleanse_v1_00(
				postCodeAnywhereKey, 		// Key
				addresses, 					// ArrayForAddresses
				'VanityPropertyOrStreet', 	// MatchLevel
				3, 							// Number of lines to split address into
				true, 						// SeparateOutCompanyAndDepartment
				true 						// SeparateOutTownCountyPostcode
			);
				
			// Process results. Assumes that the sequence that addresses were submitted are the same as result returned
			for (Integer i = 0; i < results.CleansePlus_Batch_Cleanse_v1_00_Results.size(); i++) {

				// The result from the validation service
				AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Results result = results.CleansePlus_Batch_Cleanse_v1_00_Results[i];

				// The original address record to process
				AddressWrapper address = addressesToValidate[i];

   				// If no match was found
   				if (result.Outcome == 'NoMatch') {

   					// Update with no match status
   					address.record.put(addressProperties.addressStatus, addressProperties.noMatchStatus);

   				}
   				// Otherwise, match was found. Update address
   				else {

   					// Update with match status
   					address.record.put(addressProperties.addressStatus, addressProperties.matchStatus);

   					// Update with validation date
   					address.record.put(addressProperties.addressDate, system.today());

   					// If for te first address
   					if (address.firstAddress) {

   						// If the address is split into multiple lines
   						if (String.isNotBlank(addressProperties.addressLine2One)) {

   							// Add in first two address lines
   							address.record.put(addressProperties.addressLine1One, result.Line1);
   							address.record.put(addressProperties.addressLine2One, result.Line2);

   							// Add in the remaining lines into single field
   							address.record.put(
   								addressProperties.addressLine3One, 
   								concatAddressLines(
   									new List<String>{result.Line3, result.Line4, result.Line5}
   								)
   							);

   						}

   						// Else put everything into the first line
   						else {

   							// Add all address lines to address line 1
   							address.record.put(
   								addressProperties.addressLine1One, 
   								concatAddressLines(
   									new List<String>{result.Line1, result.Line2, result.Line3, result.Line4, result.Line5}
   								)
   							);
   						}

   						// Set remaining fields - city, state, postcode and country
	 					address.record.put(addressProperties.cityOne, result.PostTown);
	 					address.record.put(addressProperties.stateOne, result.County);
	 					address.record.put(addressProperties.postalcodeOne, result.Postcode);

	 					// Country currently not supported. Only supports UK
	 					//address.record.put(addressProperties.countryOne, result.Country);

	 				}
	 				// Otherwise, it's for the 2nd address
	 				else {

	 					// If the address is split into multiple lines
   						if (String.isNotBlank(addressProperties.addressLine2Two)) {

   							// Add in first two address lines
   							address.record.put(addressProperties.addressLine1Two, result.Line1);
   							address.record.put(addressProperties.addressLine2Two, result.Line2);

   							// Add in the remaining lines into single field
   							address.record.put(
   								addressProperties.addressLine3Two, 
   								concatAddressLines(
   									new List<String>{result.Line3, result.Line4, result.Line5}
   								)
   							);

   						}

   						// Else put everything into the first line
   						else {

   							// Add all address lines to address line 1
   							address.record.put(
   								addressProperties.addressLine1Two, 
   								concatAddressLines(
   									new List<String>{result.Line1, result.Line2, result.Line3, result.Line4, result.Line5}
   								)
   							);
   						}

   						// Set remaining fields - city, state, postcode and country
	 					address.record.put(addressProperties.cityTwo, result.PostTown);
	 					address.record.put(addressProperties.stateTwo, result.County);
	 					address.record.put(addressProperties.postalcodeTwo, result.Postcode);

	 					// Country currently not supported. Only supports UK
	 					//address.record.put(addressProperties.countryTwo, result.Country);

	 				}

   				}

			}

		}
		// If key was not found
		else {

			// Apply error to records
			for (AddressWrapper add :addressesToValidate) {

				add.record.put(addressProperties.addressError, 'Could not validate address as a PostcodeAnywhere key was not found');
			}
		}

		return addressesToValidate;
	}

	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         29/05/2015
	* Description:  Convert the address (which exists in multiple fields), into a single line address
	**/
	private static List<AddressWrapper> createAddressList(List<sObject> records, AddressProperties addressProperties) {

		// Address Wrapper list to return
		List<AddressWrapper> addressesForValidation = new List<AddressWrapper>();

		// Iterate over sObject records to build address
		for (sObject record :records) {

			AddressWrapper newAddress 		= new AddressWrapper();
			newAddress.record 				= record;
			newAddress.firstAddress 		= true;
			newAddress.addressToValidate 	= buildSingleLineAddress(record, addressProperties, newAddress.firstAddress);

			// Add addresses to list
			addressesForValidation.add(newAddress);

			// If the record contains a 2nd validate, need to split that out into it's own instance
			if (addressProperties.includes2ndAddress) {

				newAddress 						= new AddressWrapper();
				newAddress.record 				= record;
				newAddress.firstAddress 		= false;
				newAddress.addressToValidate 	= buildSingleLineAddress(record, addressProperties, newAddress.firstAddress);

				// Add 2nd address to list
				addressesForValidation.add(newAddress);
			}

		}

		// Return the list of Address Wrapper records
		return addressesForValidation;
	}

	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         29/05/2015
	* Description:  Convert the address (which exists in multiple fields), into a single line address
	**/
	private static String buildSingleLineAddress(Sobject record, AddressProperties addressProperties, Boolean firstAddress) {

		// Start address with quote character, as per documentation
		String addressString = '"';

		// Whether this is for the first or 2nd address
		if (firstAddress) {

			// If there is a 1st Address Line
			if (String.isNotBlank(addressProperties.addressLine1One) && record.get(addressProperties.addressLine1One) != null) {

				addressString += String.valueOf(record.get(addressProperties.addressLine1One));
			}

			// If there is a 2nd Address Line
			if (String.isNotBlank(addressProperties.addressLine2One) && record.get(addressProperties.addressLine2One) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.addressLine2One));
			}

			// If there is a 3rd Address Line
			if (String.isNotBlank(addressProperties.addressLine3One) && record.get(addressProperties.addressLine3One) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.addressLine3One));
			}

			// If there is a city value
			if (String.isNotBlank(addressProperties.cityOne) && record.get(addressProperties.cityOne) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.cityOne));
			}

			// If there is a state value
			if (String.isNotBlank(addressProperties.stateOne) && record.get(addressProperties.stateOne) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.stateOne));
			}

			// If there is a postalCode value
			if (String.isNotBlank(addressProperties.postalCodeOne) && record.get(addressProperties.postalCodeOne) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.postalCodeOne));
			}

			// If there is a country value
			if (String.isNotBlank(addressProperties.countryOne) && record.get(addressProperties.countryOne) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.countryOne));
			}

		}
		else {

			// If there is a 1st Address Line
			if (String.isNotBlank(addressProperties.addressLine1Two) && record.get(addressProperties.addressLine1Two) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.addressLine1Two));
			}

			// If there is a 2nd Address Line
			if (String.isNotBlank(addressProperties.addressLine2Two) && record.get(addressProperties.addressLine2Two) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.addressLine2Two));
			}

			// If there is a 3rd Address Line
			if (String.isNotBlank(addressProperties.addressLine3Two) && record.get(addressProperties.addressLine3Two) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.addressLine3Two));
			}

			// If there is a city value
			if (String.isNotBlank(addressProperties.cityTwo) && record.get(addressProperties.cityTwo) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.addressLine1Two));
			}

			// If there is a state value
			if (String.isNotBlank(addressProperties.stateTwo) && record.get(addressProperties.stateTwo) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.stateTwo));
			}

			// If there is a postalCode value
			if (String.isNotBlank(addressProperties.postalCodeTwo) && record.get(addressProperties.postalCodeTwo) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.postalCodeTwo));
			}

			// If there is a country value
			if (String.isNotBlank(addressProperties.countryTwo) && record.get(addressProperties.countryTwo) != null) {

				addressString += ', ' + String.valueOf(record.get(addressProperties.countryTwo));
			}

		}

		// Add ending quote, as per PostcodeAnywhere documention
		addressString += '"';

		return addressString;
	}

	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         29/05/2015
	* Description:  Method to concatenate multiple address lines into a single line.
	**/
	private static String concatAddressLines(List<String> addressLines) {

		String addressLine = '';

		// Iterate over list of strings
		for (Integer i = 0; i < addressLines.size(); i++) {

			// If value isn't blank
			if (String.isNotBlank(addressLines[i])) {

				// If it's the first value
				if (i == 0) {

					addressLine += addressLines[i];
				}
				else {

					addressLine += '\n' + addressLines[i];
				}

			}

		}

		return addressLine;
	}

	// Custom wrapper class to hold address values to be sent in callout
	public class AddressWrapper {

		// Variables for the addresses
		public SObject record 				{get;set;}
		public String addressToValidate 	{get;set;}
		public Boolean firstAddress 		{get;set;}
	}

	// Wrapper class to hold address properties for a sobject record
	// Used to specify what the API names are for address fields for an object.
	public class AddressProperties {

		// API names for the adress fields
		public String addressLine1One 		{get;set;}
		public String addressLine2One 		{get;set;}
		public String addressLine3One 		{get;set;}
		public String cityOne 				{get;set;}
		public String stateOne 				{get;set;}
		public String postalcodeOne 		{get;set;}
		public String countryOne 			{get;set;}

		// Whether the record / object includes a 2nd address
		public Boolean includes2ndAddress 	{
			get {
				// If the value is null
				if (includes2ndAddress == null) {

					// Default value is false
					includes2ndAddress = false;
				}
				return includes2ndAddress;
			}
			set;
		}

		// API names for the 2nd lot of address fields
		public String addressLine1Two 		{get;set;}
		public String addressLine2Two 		{get;set;}
		public String addressLine3Two 		{get;set;}
		public String cityTwo 				{get;set;}
		public String stateTwo 				{get;set;}
		public String postalcodeTwo 		{get;set;}
		public String countryTwo 			{get;set;}

		// Result fields
		public String addressStatus 		{get;set;}
		public String addressDate 			{get;set;}
		public String addressError 			{get;set;}
		public String matchStatus 			{get;set;}
		public String noMatchStatus 		{get;set;}

	}

}