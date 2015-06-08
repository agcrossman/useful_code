/**
* Author:       Ben Edwards (Tquila)
* Date:         03/06/2015
* Description:  Test class for the AddressValidationBatchAccount class
*
* ******************* Change Log *******************
* Modified by       Change Date     Change
* Ben Edwards       03/06/2015      Initial creation.
**/
@isTest
public class AddressValidationBatchAccountTest {
	
	/**
	* Author:       Ben Edwards (Tquila)
	* Date:         03/06/2015
	* Description:  Test the location address callout
	**/
	static testMethod void testAddressValidationAccount() {

		// Create Account
		Account testAccount = TestData.newAccount();
		testAccount.Address_Status__c = 'Not Yet Validated';
		testAccount.BillingStreet = 'Fake Address';
		testAccount.ShippingStreet = 'Fake Address';
		insert testAccount;

		// Create fake PostcodeAnywhere key
		TestData.insertPostcodeAnywhereKey();

		// Set Mock class for fake callout response
		Test.setMock(WebServiceMock.class, new AddressValidationMock());

		// Execute the batch
		Database.executeBatch(new AddressValidationBatchAccount());
	}


}