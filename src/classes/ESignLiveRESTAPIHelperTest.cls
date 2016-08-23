/**
 * Class Name: ESignLiveRESTAPIHelperTest.cls
 *
 * Test class for the ESignLiveRESTAPIHelper class
 */

@isTest
public class ESignLiveRESTAPIHelperTest 
{
    /**
     * Test method for setSessionId method
     */
    private static testMethod void testGetSessionId() 
    {
        String result = '';
        
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            String value = 'YTdkZjNlYTUtMWIzZi00YWVhLWIyZTctZGU3Yzk1MzQzY2Yz';
            ESignLiveAPIObjects.Authentication auth = new ESignLiveAPIObjects.Authentication(value);
            
            // Set JSON response
            String mockResponse = JSON.serialize(auth);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            
            // This causes a fake response to be sent
            // from the class that implements HttpCalloutMock.
            result = helper.getSessionId();
        
        Test.stopTest();
        
        // Verify response received contains fake values
        String expectedValue = 'YTdkZjNlYTUtMWIzZi00YWVhLWIyZTctZGU3Yzk1MzQzY2Yz';
        System.assertEquals(result, expectedValue);
    }

    /**
     * Test method for updatePackage method
     */
    private static testMethod void testUpdatePackageException() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();

            // Get JSON response
            String mockResponse = '';
            
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId,'packName','packConsent');
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 500));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            try
            {
                helper.updatePackage(packageSettings, packageId);
            } 
            catch( Exception e)
            {
                System.assertEquals('ESignLiveRESTAPIHelper.ESignLiveRestAPIHelperException', e.getTypeName());
            }
        
        Test.stopTest();
    }

    /**
     * Test method for getSigningUrl method
     */
    private static testMethod void testGetSigningUrl() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();

            // Set parameters for call
            String packageId = 'a3b023bf-db56-4c53-b36e-bd9acd0579f4';
            String signerId = '654321';
            String roleId = '2jsTTXD2dZMZ';
            String url =  'https://sandbox.e-signlive.com/auth?target=https%3A%2F%2Fsandbox.e-signlive.com%2Fpackages%2Fa3b023bf-db56-4c53-b36e-bd9acd0579f4%2Fsign&loginToken=Mi4xMDAwGpGY3JJPS55ZnNSeHBmekNxc1RzdnNJRVlBSDkZBR1RhcmxKS09aZ3M4aFZXVlpvdExrdz09';
            ESignLiveAPIObjects.SigningUrl su = new ESignLiveAPIObjects.SigningUrl(roleId, url, packageId);
            
            // Set response object
            String mockResponse = JSON.serialize(su);
            
            // Response object 
            ESignLiveAPIObjects.SigningUrl response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getSigningUrl(packageId, signerId);
        
        Test.stopTest();
        
        // Verify response received contains fake values
        System.assertEquals('2jsTTXD2dZMZ', response.roleId);
        System.assertEquals('https://sandbox.e-signlive.com/auth?target=https%3A%2F%2Fsandbox.e-signlive.com%2Fpackages%2Fa3b023bf-db56-4c53-b36e-bd9acd0579f4%2Fsign&loginToken=Mi4xMDAwGpGY3JJPS55ZnNSeHBmekNxc1RzdnNJRVlBSDkZBR1RhcmxKS09aZ3M4aFZXVlpvdExrdz09', response.url);
        System.assertEquals('a3b023bf-db56-4c53-b36e-bd9acd0579f4', response.packageId);
    }

    /**
     * Test method for deletePackage method
     */
    private static testMethod void testDeletePackageException() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();

            // Set parameters for call
            String packageId = '123456';
            
            // Set JSON response
            String mockResponse = '';
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse,500));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            try
            {
                helper.deletePackage(packageId);
            }
            catch( Exception e)
            {
                 System.assertEquals('ESignLiveRESTAPIHelper.ESignLiveRestAPIHelperException', e.getTypeName());
            }
    
        Test.stopTest();
    }

    /**
     * Test method for createPackageFromTemplate method
     */
    private static testMethod void testCreatePackageFromTemplate() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Set JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Response object 
            ESignLiveAPIObjects.Package_x response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.createPackageFromTemplate(packageSettings, packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('packName', response.name);
    }

    /**
     * Test method for getPackageSigningStatus method
     */
    private static testMethod void testGetPackageSigningStatus() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Response object 
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getPackageSigningStatus(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('OPTED_OUT', response );
    }

    /**
     * Test method for getSignedDocument method
     */
    private static testMethod void testGetSignedDocument() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object 
            Blob response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse,200,Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getSignedDocument(packageId, docId);
            
        Test.stopTest();
        
        System.assertEquals(Blob.valueOf('ThisIsMyBlob').toString(), response.toString() );
    }

    /**
     * Test method for createApproval method
     */
    private static testMethod void testCreateApproval() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            String approvalId = 'abc123456';
            String approvalName = 'NAME';
            String role = 'RKbhyswr2FYO';
            ESignLiveAPIObjects.Approval approval = ESignLiveTestDataUtility.createApproval(approvalId, approvalName, role);
            
            // Get JSON response
            String mockResponse = JSON.serialize(approval);
            
            // Response object
            ESignLiveAPIObjects.Approval response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.createApproval(packageId, docId, approval);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('RKbhyswr2FYO', response.role);
        System.assertEquals(100, response.fields.get(0).top );
        System.assertEquals(1, response.fields.get(0).left);
    }

    /**
     * Test method for getAuditTrail method
     */
    private static testMethod void testGetAuditTrail() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getAuditTrail(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('VGhpc0lzTXlCbG9i', response);
    }

    /**
     * Test method for getSignerAttachments method
     */
    private static testMethod void testGetSignerAttachments() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getSignerAttachments(packageId, roleId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('VGhpc0lzTXlCbG9i', response);
    }

    /**
     * Test method for createRole method
     */
    private static testMethod void testCreateRole() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.createRole(packageId, signer);
        
        Test.stopTest();
        
        // Verify result
        ESignLiveAPIObjects.Role result = (ESignLiveAPIObjects.Role) JSON.deserialize(response, ESignLiveAPIObjects.Role.class);
        System.assertEquals('roleId', result.Id);
        System.assertEquals('roleName', result.Name);
        System.assertEquals('roleType', result.Type);
    }

    /**
     * Test method for reassignRole method
     */
    private static testMethod void testReassignRole() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.reassignRole(packageId, roleId, signer);
        
        Test.stopTest();
        
        // Verify result
        ESignLiveAPIObjects.Role result = (ESignLiveAPIObjects.Role) JSON.deserialize(response, ESignLiveAPIObjects.Role.class);
        System.assertEquals('roleId', result.Id);
        System.assertEquals('roleName', result.Name);
        System.assertEquals('roleType', result.Type);
    }

    /**
     * Test method for getRole method
     */
    private static testMethod void testGetRole() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            ESignLiveAPIObjects.Role response = null; 
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getRole(packageId, roleId);
        
        Test.stopTest();
        
        System.assertEquals('roleId', response.Id);
        System.assertEquals('roleName', response.Name);
        System.assertEquals('roleType', response.Type);
    }

    /**
     * Test method for updateRole method
     */
    private static testMethod void testUpdateRole() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            String packageId = '123456';
            String roleId = 'abc987';
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.updateRole(packageId, roleId, signer);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Test method for createPackageWithBinaries method
     */
    private static testMethod void testCreatePackageWithBinaries() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            String docId = 'abc987654321';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.createPackageWithBinaries(myBlob);
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(packageId, response);
    }

    /**
     * Test method for createDocumentsWithBinaries method
     */
    private static testMethod void testCreateDocumentsWithBinaries()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            ESignLiveAPIObjects.Document document = ESignLiveTestDataUtility.createDocument('docId', 'Document Name', 123);
            
            // Get JSON response
            String mockResponse = JSON.serialize(document);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.createDocumentsWithBinaries(packageId, myBlob);
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(mockResponse, response);
    }

    /**
     * Test method for createPackage method
     */
    private static testMethod void testCreatePackage() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = 'ab9873';
            ESignLiveAPIObjects.Package_x pkg = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = JSON.serialize(pkg);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.createPackage(pkg);
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(packageId, response);
    }

    /**
     * Test method for updatePackageStatus method
     */
    private static testMethod void testUpdatePackageStatus() 
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.PackageStatus status = ESignLiveAPIObjects.PackageStatus.DRAFT;
            
            // Get JSON response
            String mockResponse = '';
            
            //Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.updatePackageStatus(packageId, status);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Test method for getPackage
     */
    public static testMethod void testGetPackage()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Set JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Response object 
            ESignLiveAPIObjects.Package_x response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getPackage(packageId);
        
        Test.stopTest();
        
        //Verify result
        System.assertEquals('packName', response.name);
    }

        /**
     * Method to delete a package
     */
    public static testMethod void testDeletePackage()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Code to test
             ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.deletePackage(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testUpdateDocument()
    {
         // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc123';
            String docName = 'New docName';
            String description = 'New description';
            ESignLiveAPIObjects.Document doc = new ESignLiveAPIObjects.Document();
            doc.Name = 'New Document Name';
            doc.description = 'New description';
          
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Code to test
             ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.updateDocument(packageId, docId, doc);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testDeleteDocument()
    {
         // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc123';
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Code to test
             ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.deleteDocument(packageId, docId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    } 

    public static testMethod void testDeleteRole()
    {
           // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc123';
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Code to test
             ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.deleteRole(packageId, roleId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testGetApproval()
    {
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            String approvalId = 'abc123456';
            String approvalName = 'NAME';
            String role = 'RKbhyswr2FYO';
            ESignLiveAPIObjects.Approval approval = ESignLiveTestDataUtility.createApproval(approvalId, approvalName, role);
            // Get JSON response
            String mockResponse = JSON.serialize(approval);
            
            // Response object
            ESignLiveAPIObjects.Approval response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
             ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.getApproval(packageId, docId, approvalId);
        
        Test.stopTest();
        
        // Verify result
         System.assertEquals(role, response.role);
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testUpdateApproval()
    {
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            String approvalId = 'abc123456';
            String approvalName = 'NAME';
            String role = 'RKbhyswr2FYO';
            ESignLiveAPIObjects.Approval approval = ESignLiveTestDataUtility.createApproval(approvalId, approvalName, role);
            // Get JSON response
            String mockResponse = JSON.serialize(approval);
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
             ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.updateApproval(packageId, docId, approvalId, approval);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void deleteApprovalExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String documentId = 'abc123';
            String approvalId = 'appId1234';
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            ESignLiveRESTAPIHelper helper = new ESignLiveRESTAPIHelper();
            response = helper.deleteApproval(packageId, documentId, approvalId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }
}
