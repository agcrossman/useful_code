/**
* Author:       Ben Edwards (Tquila)
* Date:         29/05/2015
* Description:  Batch class to execute bulk address validation on Accounts
*
* ******************* Change Log *******************
* Modified by       Change Date     Change
* Ben Edwards       29/05/2015      Initial creation.
**/
global class AddressValidationBatchAccount implements Database.Batchable<sObject>, Database.AllowsCallouts {

	global AddressValidationBatchAccount() {}
	
	// Query execution for batch
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(
			' Select 	Id							' + 
			'			, Address_Status__c			' + 
			'			, Address_Validated__c		' + 
			' 			, BillingStreet				' + 
			' 			, BillingCity				' + 
			' 			, BillingState				' + 
			' 			, BillingPostalCode			' + 
			' 			, BillingCountry			' + 
			' 			, ShippingStreet			' + 
			' 			, ShippingCity				' + 
			' 			, ShippingState				' + 
			' 			, ShippingPostalCode		' + 
			' 			, ShippingCountry			' + 
			' From 		Account 					' + 
			' Where		Address_Status__c = \'Not Yet Validated\''
		);
	}

	// Execute method for the batch. Make callout to validation servce
   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
   		// Send address to service for validaiton
   		List<AddressValidationService.AddressWrapper> validatedAddresses = AddressValidationService.validateAddress(scope, addressProperties);

   		// The list of Locations to update
   		Map<Id, Account> recordsForUpdate = new Map<Id, Account>();

   		// Process results
   		for (AddressValidationService.AddressWrapper address :validatedAddresses) {

   			// Cast sObject record to Account
   			Account account = (Account) address.record;

   			// If record exists in map
   			if (recordsForUpdate.containsKey(account.Id)) {

   				// The existing account from the map
   				Account existingAccount = recordsForUpdate.get(account.Id);

   				// IF current iterative is the first address (Billing)
   				if (address.firstAddress) {

   					// Set the billing address against the existing
   					existingAccount.BillingStreet 		= account.BillingStreet;
   					existingAccount.BillingCity 		= account.BillingCity;
   					existingAccount.BillingState 		= account.BillingState;
   					existingAccount.BillingPostalCode 	= account.BillingPostalCode;
   					existingAccount.BillingCountry 		= account.BillingCountry;
   				}
   				// Else shipping address
   				else {

   					// Set the shipping address against the record
   					existingAccount.ShippingStreet 		= account.ShippingStreet;
   					existingAccount.ShippingCity 		= account.ShippingCity;
   					existingAccount.ShippingState 		= account.ShippingState;
   					existingAccount.ShippingPostalCode 	= account.ShippingPostalCode;
   					existingAccount.ShippingCountry 	= account.ShippingCountry;

   				}

   				// Add to map
   				recordsForUpdate.put(existingAccount.Id, existingAccount);
   			}
   			// If not in map
   			else {

   				// Add account to map
   				recordsForUpdate.put(account.Id, account);
   			}

   		}

   		// Update records
   		update recordsForUpdate.values();

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

		   		// 1st address
		   		addressProperties.addressLine1One 		= 'BillingStreet';
		   		addressProperties.addressLine2One 		= null;
		   		addressProperties.addressLine3One 		= null;
				addressProperties.cityOne 				= 'BillingCity';
				addressProperties.stateOne 				= 'BillingState';
				addressProperties.postalcodeOne 		= 'BillingPostalCode';
				addressProperties.countryOne 			= 'BillingCountry';

				// Include the 2nd address
				addressProperties.includes2ndAddress 	= true;

				// 2nd address
				addressProperties.addressLine1Two 		= 'ShippingStreet';
		   		addressProperties.addressLine2Two 		= null;
		   		addressProperties.addressLine3Two 		= null;
				addressProperties.cityTwo 				= 'ShippingCity';
				addressProperties.stateTwo 				= 'ShippingState';
				addressProperties.postalcodeTwo 		= 'ShippingPostalCode';
				addressProperties.countryTwo 			= 'ShippingCountry';

				// Address result
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