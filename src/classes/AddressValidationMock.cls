/**
* Author:       Ben Edwards (Tquila)
* Date:         03/06/2015
* Description:  Mock class for the PostcodeAnywhere address validation callout
*
* ******************* Change Log *******************
* Modified by       Change Date     Change
* Ben Edwards       03/06/2015      Initial creation.
**/
@isTest
public class AddressValidationMock implements WebServiceMock {
	
	public void doInvoke(
		Object stub,
		Object request,
		Map<String, Object> response,
		String endpoint,
		String soapAction,
 		String requestName,
		String responseNS,
		String responseName,
		String responseType) 
	{

		// Instantiate a fake response element
        AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Response_element responseElement = 
        	new AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Response_element();

        // Create a new result
        AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Results result = 
        	new AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Results();
        result.Line1 	= 'New Address Line 1';
        result.Line2 	= 'New Address Line 2';
        result.Line3 	= 'New Address Line 3';
        result.Line4 	= 'New Address Line 4';
        result.Line5 	= 'New Address Line 5';
        result.PostTown = 'Address City';
        result.County 	= null;
        result.Postcode = 'Postcode';
        result.Outcome 	= 'VanityStreet';

        // Instantiate new array element for the result
        responseElement.CleansePlus_Batch_Cleanse_v1_00_Result = 
        	new AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_ArrayOfResults();

        // Instantiate new list of results and add fake result to the list
        responseElement.CleansePlus_Batch_Cleanse_v1_00_Result.CleansePlus_Batch_Cleanse_v1_00_Results = 
        	new List<AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Results>{result};


        // Return the response
		response.put('response_x', responseElement);
   }

}