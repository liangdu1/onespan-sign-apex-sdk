/**
 * Class Name: OneSpanJSONHelperTestls
 *
 * Test class for the OneSpanJSONHelper class
 */

@isTest
public class OneSpanJSONHelperTest
{    
    /**
     * Test method for prepareOutboundJSON method
     */
    private static testMethod void prepareOutboundJSONTest() 
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = 'PACKAGE_X';
            Map<String,Blob> documentMap = OneSpanTestDataUtility.createDocumentMap();
            OneSpanAPIObjects.Package_x pkg = OneSpanTestDataUtility.createPackageX(packageId,'packName','packConsent');
            String result = OneSpanValidation.comparePackageDocumentsAndMap(pkg, documentMap);
            
            // Get JSON response
            String mockResponse = JSON.serialize(pkg);
            
            // Object response    
            System.assertEquals(true, mockResponse.contains('PACKAGE_X'));  
            System.assertEquals(true, mockResponse.contains('null'));      
            mockResponse = OneSpanJSONHelper.prepareOutboundJSON(mockResponse);
            
            // Ensure after invoking the prepareOutboundJSON method all _X removed
            System.assertEquals(false, mockResponse.contains('PACKAGE_X')); 
            System.assertEquals(true, mockResponse.contains('PACKAGE')); 
            
            // Ensure after invoking the prepareOutboundJSON method all null values removed
            System.assertEquals(false, mockResponse.contains('null'));  
            String response = null;
      
        Test.stopTest();        
        
        System.assertEquals('success', result);
    }  

    /**
     * Test method for prepareInboundJSON method
     */    
    private static testMethod void prepareInboundJSONTest() 
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = 'NEW';
            OneSpanAPIObjects.Package_x pkg = OneSpanTestDataUtility.createPackageX(packageId,'packName','packConsent');
            
            // Get JSON response
            String mockResponse = JSON.serialize(pkg);
                  
            System.assertEquals(true, mockResponse.contains(packageId));  
            System.assertEquals(true, mockResponse.contains('null'));     
            mockResponse = OneSpanJSONHelper.prepareInboundJSON(mockResponse);
            
            // Values of packageId variable replaced with NEW_X because NEW is a reserved word
            System.assertEquals(true, mockResponse.contains('NEW_X'));  
            System.assertEquals(false, mockResponse.contains('null'));   

        Test.stopTest();     
    }       
}