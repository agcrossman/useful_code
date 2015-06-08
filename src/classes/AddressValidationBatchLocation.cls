/**
* Author:       Ben Edwards (Tquila)
* Date:         29/05/2015
* Description:  Batch class to execute bulk address validation on Locations
*
* ******************* Change Log *******************
* Modified by       Change Date     Change
* Ben Edwards       29/05/2015      Initial creation.
**/
global class AddressValidationBatchLocation implements Database.Batchable<sObject>, Database.AllowsCallouts {

	global AddressValidationBatchLocation() {}
	
	// Query execution for batch. Query for all locations that not don't a validated address
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(
			' Select 	Id								' + 
			'			, Address_Status__c				' + 
			'			, Address_Validated__c			' + 
			' 			, Address_Line_1__c				' + 
			' 			, Address_Line_2__c				' + 
			' 			, Address_Line_3__c				' + 
			' 			, City__c						' + 
			' 			, State__c						' + 
			' 			, Postal_Code__c				' + 
			' 			, Country__c					' + 
			' From 		Location__c 					' + 
			' Where		Address_Status__c = \'Not Yet Validated\'' + 
			' 	And 	Address_Line_1__c != null'
		);
	}

	// Execute method for the batch. Make callout to validation servce
   	global void execute(Database.BatchableContext BC, List<sObject> scope) {

   		// Send address to service for validaiton
   		List<AddressValidationService.AddressWrapper> validatedAddresses = AddressValidationService.validateAddress(scope, addressProperties);

   		// The list of Locations to update
   		List<Location__c> recordsForUpdate = new List<Location__c>();

   		// Process results
   		for (AddressValidationService.AddressWrapper address :validatedAddresses) {

   			// Cast sObject to Location__c and add to update list
   			recordsForUpdate.add((Location__c) address.record);

   		}

   		// Update records
   		update recordsForUpdate;

	}
	
	
	// Finish method when the batch has completed running
	global void finish(Database.BatchableContext BC) {
		
	}

	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         29/05/2015
	* Description:  The address properties for the object
	* 				Set the address API names to validate against
	**/
	private AddressValidationService.AddressProperties addressProperties {

		get {

			if (addressProperties == null) {

				// Set the address properties for the location object
		   		addressProperties = new AddressValidationService.AddressProperties();
		   		addressProperties.addressLine1One 		= 'Address_Line_1__c';
		   		addressProperties.addressLine2One 		= 'Address_Line_2__c';
		   		addressProperties.addressLine3One 		= 'Address_Line_3__c';
				addressProperties.cityOne 				= 'City__c';
				addressProperties.stateOne 				= 'State__c';
				addressProperties.postalcodeOne 		= 'Postal_Code__c';
				addressProperties.countryOne 			= 'Country__c';
				addressProperties.includes2ndAddress 	= false;

				addressProperties.addressStatus 		= 'Address_Status__c';
				addressProperties.addressDate 			= 'Address_Validated__c';
				addressProperties.addressError 			= 'Address_Error__c';
				addressProperties.matchStatus 			= 'Validated';
				addressProperties.noMatchStatus 		= 'Could Not Validate';

			}

			return addressProperties;
		}
		set;

	}
	
}