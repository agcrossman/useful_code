/**
* Author:       Ben Edwards (Tquila)
* Date:         29/05/2015
* Description:  WSDL generated purely from WSDL2Apex
*               http://services.postcodeanywhere.co.uk/CleansePlus/Batch/Cleanse/v1.00/wsdlnew.ws
**/
public class AddressValidationWSDL {
    public class CleansePlus_Batch_Cleanse_v1_00_ArrayOfResults {
        public AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Results[] CleansePlus_Batch_Cleanse_v1_00_Results;
        private String[] CleansePlus_Batch_Cleanse_v1_00_Results_type_info = new String[]{'CleansePlus_Batch_Cleanse_v1_00_Results','http://services.postcodeanywhere.co.uk/',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://services.postcodeanywhere.co.uk/','true','false'};
        private String[] field_order_type_info = new String[]{'CleansePlus_Batch_Cleanse_v1_00_Results'};
    }
    public class CleansePlus_Batch_Cleanse_v1_00_Results {
        public Integer Udprn;
        public String Company;
        public String Department;
        public String Line1;
        public String Line2;
        public String Line3;
        public String Line4;
        public String Line5;
        public String PostTown;
        public String County;
        public String Postcode;
        public String Barcode;
        public String Type_x;
        public String DeliveryPointSuffix;
        public String SubBuilding;
        public String BuildingName;
        public String BuildingNumber;
        public String PrimaryStreet;
        public String SecondaryStreet;
        public String DoubleDependentLocality;
        public String DependentLocality;
        public String PoBox;
        public String PrimaryStreetName;
        public String PrimaryStreetType;
        public String SecondaryStreetName;
        public String SecondaryStreetType;
        public String Outcome;
        private String[] Udprn_type_info = new String[]{'Udprn','http://services.postcodeanywhere.co.uk/',null,'1','1','false'};
        private String[] Company_type_info = new String[]{'Company','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Department_type_info = new String[]{'Department','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Line1_type_info = new String[]{'Line1','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Line2_type_info = new String[]{'Line2','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Line3_type_info = new String[]{'Line3','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Line4_type_info = new String[]{'Line4','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Line5_type_info = new String[]{'Line5','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] PostTown_type_info = new String[]{'PostTown','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] County_type_info = new String[]{'County','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Postcode_type_info = new String[]{'Postcode','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Barcode_type_info = new String[]{'Barcode','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Type_x_type_info = new String[]{'Type','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] DeliveryPointSuffix_type_info = new String[]{'DeliveryPointSuffix','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] SubBuilding_type_info = new String[]{'SubBuilding','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] BuildingName_type_info = new String[]{'BuildingName','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] BuildingNumber_type_info = new String[]{'BuildingNumber','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] PrimaryStreet_type_info = new String[]{'PrimaryStreet','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] SecondaryStreet_type_info = new String[]{'SecondaryStreet','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] DoubleDependentLocality_type_info = new String[]{'DoubleDependentLocality','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] DependentLocality_type_info = new String[]{'DependentLocality','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] PoBox_type_info = new String[]{'PoBox','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] PrimaryStreetName_type_info = new String[]{'PrimaryStreetName','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] PrimaryStreetType_type_info = new String[]{'PrimaryStreetType','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] SecondaryStreetName_type_info = new String[]{'SecondaryStreetName','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] SecondaryStreetType_type_info = new String[]{'SecondaryStreetType','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Outcome_type_info = new String[]{'Outcome','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://services.postcodeanywhere.co.uk/','true','false'};
        private String[] field_order_type_info = new String[]{'Udprn','Company','Department','Line1','Line2','Line3','Line4','Line5','PostTown','County','Postcode','Barcode','Type_x','DeliveryPointSuffix','SubBuilding','BuildingName','BuildingNumber','PrimaryStreet','SecondaryStreet','DoubleDependentLocality','DependentLocality','PoBox','PrimaryStreetName','PrimaryStreetType','SecondaryStreetName','SecondaryStreetType','Outcome'};
    }
    public class CleansePlus_Batch_Cleanse_v1_00_element {
        public String Key;
        public AddressValidationWSDL.ArrayForAddresses Addresses;
        public String MatchLevel;
        public Integer Lines;
        public Boolean SeparateOutCompanyAndDepartment;
        public Boolean SeparateOutTownCountyPostcode;
        private String[] Key_type_info = new String[]{'Key','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Addresses_type_info = new String[]{'Addresses','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] MatchLevel_type_info = new String[]{'MatchLevel','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] Lines_type_info = new String[]{'Lines','http://services.postcodeanywhere.co.uk/',null,'1','1','false'};
        private String[] SeparateOutCompanyAndDepartment_type_info = new String[]{'SeparateOutCompanyAndDepartment','http://services.postcodeanywhere.co.uk/',null,'1','1','false'};
        private String[] SeparateOutTownCountyPostcode_type_info = new String[]{'SeparateOutTownCountyPostcode','http://services.postcodeanywhere.co.uk/',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://services.postcodeanywhere.co.uk/','true','false'};
        private String[] field_order_type_info = new String[]{'Key','Addresses','MatchLevel','Lines','SeparateOutCompanyAndDepartment','SeparateOutTownCountyPostcode'};
    }
    public class CleansePlus_Batch_Cleanse_v1_00_Response_element {
        public AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_ArrayOfResults CleansePlus_Batch_Cleanse_v1_00_Result;
        private String[] CleansePlus_Batch_Cleanse_v1_00_Result_type_info = new String[]{'CleansePlus_Batch_Cleanse_v1_00_Result','http://services.postcodeanywhere.co.uk/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://services.postcodeanywhere.co.uk/','true','false'};
        private String[] field_order_type_info = new String[]{'CleansePlus_Batch_Cleanse_v1_00_Result'};
    }
    public class ArrayForAddresses {
        public String[] Addresses;
        private String[] Addresses_type_info = new String[]{'Addresses','http://services.postcodeanywhere.co.uk/',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://services.postcodeanywhere.co.uk/','true','false'};
        private String[] field_order_type_info = new String[]{'Addresses'};
    }
    public class PostcodeAnywhere_Soap {
        public String endpoint_x = 'http://services.postcodeanywhere.co.uk/CleansePlus/Batch/Cleanse/v1.00/soapnew.ws';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://services.postcodeanywhere.co.uk/', 'AddressValidationWSDL'};
        public AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_ArrayOfResults CleansePlus_Batch_Cleanse_v1_00(String Key,AddressValidationWSDL.ArrayForAddresses Addresses,String MatchLevel,Integer Lines,Boolean SeparateOutCompanyAndDepartment,Boolean SeparateOutTownCountyPostcode) {
            AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_element request_x = new AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_element();
            request_x.Key = Key;
            request_x.Addresses = Addresses;
            request_x.MatchLevel = MatchLevel;
            request_x.Lines = Lines;
            request_x.SeparateOutCompanyAndDepartment = SeparateOutCompanyAndDepartment;
            request_x.SeparateOutTownCountyPostcode = SeparateOutTownCountyPostcode;
            AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Response_element response_x;
            Map<String, AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Response_element> response_map_x = new Map<String, AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Response_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://services.postcodeanywhere.co.uk/CleansePlus_Batch_Cleanse_v1_00',
              'http://services.postcodeanywhere.co.uk/',
              'CleansePlus_Batch_Cleanse_v1_00',
              'http://services.postcodeanywhere.co.uk/',
              'CleansePlus_Batch_Cleanse_v1_00_Response',
              'AddressValidationWSDL.CleansePlus_Batch_Cleanse_v1_00_Response_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.CleansePlus_Batch_Cleanse_v1_00_Result;
        }
    }
}