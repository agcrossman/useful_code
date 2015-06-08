/**
* Author:       Ben Edwards (Tquila)
* Date:         03/06/2015
* Description:  Test class for the AddressValidationBatchLocation class
*
* ******************* Change Log *******************
* Modified by       Change Date     Change
* Ben Edwards       03/06/2015      Initial creation.
**/
@isTest
public class AddressValidationBatchLocationTest {
	
	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         03/06/2015
	* Description:  Test the location address callout
	**/
	static testMethod void testAddressValidationLocation() {

		// Create Account
		Account testAccount = TestData.createAccount();

		// Create Location and set address
		Location__c testLocation = TestData.newLocation(testAccount.Id);

		// Set a sample address. Address is irrelevant as Mock class will return static result
		testLocation.Address_Line_1__c = 'Test address';
		testLocation.Address_Status__c = 'Not Yet Validated';
		insert testLocation;

		// Create fake PostcodeAnywhere key
		TestData.insertPostcodeAnywhereKey();

		// Set Mock class for fake callout response
		Test.setMock(WebServiceMock.class, new AddressValidationMock());

		// Execute the batch
		Database.executeBatch(new AddressValidationBatchLocation());
	}


}