# postcodeanywhere-cleanseplus
Apex logic using the PostcodeAnywhere Cleanse+ service to batch validate addresses.

## Setup

This service assumes the Salesforce PostcodeAnywhere application is installed, so hence uses the API Key from the database. If the app is not installed, the API Key should be set using a Custom Setting. This is configured on the AddressValidationService class.

It also assumes some custom fields on Account and Location, namely "Address_Status__c", which controls whether an account should be validated or not.

## Examples

This repository includes examples for the Account object, and a custom object.

### Account

Uses two addresses - Shipping and Billing. The street exists in one field, so the 5 line results are concatenated into that field.

### Location

A custom object that has one address, but has the street address split over three lines.


## Running the batch

You can run the batches programatically either case by case, or using the generic BatchScheduler class
	
	# Execute account address validation
	database.executeBatch(new AddressValidationBatchAccount());

	# Execute location address validation
	database.executeBatch(new AddressValidationBatchLocation());

	# Schedule a batch to run at 1pm every day
	System.schedule('Account Address Validation - Everyday at 1pm', '0 0 13 * * ?', new BatchScheduler(new AddressValidationBatchAccount()));