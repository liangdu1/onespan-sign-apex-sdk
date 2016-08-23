/**
 * Class Name: ESignLiveExamplesTest.cls
 *
 * Class to test the ESignLiveExamples class
 */

@isTest
public class ESignLiveExamplesTest 
{
    /**
     * Method to test the createPackageExample method
     */
    public static testMethod void testCreatePackageExample()
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
            response = ESignLiveExamples.createPackageExample();
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(packageId, response);
    }

    /**
     * Method to test the createPackageWithDocumentsExample method
     */
    public static testMethod void testCreatePackageWithDocumentsExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            String docId = 'abc987654321';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            Map<String,Blob> documentMap = ESignLiveTestDataUtility.createDocumentMap();
            ESignLiveTestDataUtility.createDocumentObject();
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveExamples.createPackageWithDocumentsExample('packName', false, 'description', Datetime.now(), 'emailMessage');
        
        Test.stopTest();
    }

    /**
     * Method to test the getPackageExample method
     */
    public static testMethod void testGetPackageExample()
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
            response = ESignLiveExamples.getPackageExample(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('packName', response.name);
    }

    /**
     * Method to test the updatePackageExample method
     */
    public static testMethod void testUpdatePackageExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Get JSON response
            String mockResponse = '';
            
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.Package_x packageSettings = ESignLiveTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 500));
            
            // Creates class that does callout
            try
            {
                ESignLiveExamples.updatePackageExample(packageSettings, packageId);
            } 
            catch( Exception e)
            {
                System.assertEquals('ESignLiveRESTAPIHelper.ESignLiveRestAPIHelperException', e.getTypeName());
            }

        Test.stopTest();
    }

    /**
     * Method to test the createDocumentsExample method
     */
    public static testMethod void testCreateDocumentsExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            ESignLiveAPIObjects.Document document = ESignLiveTestDataUtility.createDocument('docId', 'Document Name', 123);
            ESignLiveTestDataUtility.createDocumentObject();
            
            // Get JSON response
            String mockResponse = JSON.serialize(document);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            response = ESignLiveExamples.createDocumentsExample(packageId, 'Document Name', 'Description');
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(mockResponse, response);
    }

    /**
     * Method to test the setAttachmentRequirementsExample method
     */
    public static testMethod void testSetAttachmentRequirementsExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            List<ESignLiveAPIObjects.AttachmentRequirement> attachmentRequirementsList = new List<ESignLiveAPIObjects.AttachmentRequirement>();
            ESignLiveAPIObjects.AttachmentRequirement ar = new ESignLiveAPIObjects.AttachmentRequirement();
            ar.Name = 'AttchReq';
            attachmentRequirementsList.add(ar);
            String packageId = '123456';
            String roleId = 'abc987';
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            signer.attachmentRequirements = attachmentRequirementsList;
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            ESignLiveExamples.setAttachmentRequirementsExample(packageId, roleId, 'arName', false, 'description');
            
        Test.stopTest();
    }

    /**
     * Method to test the getAuditExample method
     */
    public static testMethod void testGetAuditExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock('',200,Blob.valueOf('ThisIsMyBlob')));
            // Creates class that does callout
            String response = ESignLiveExamples.getAuditExample('123456');
    
        Test.stopTest();
        
        // Verify result
        System.assertEquals('VGhpc0lzTXlCbG9i', response);
    }

    /**
     * Method to test the downloadAllAttachmentFilesForSignerInPackageExample method
     */
    public static testMethod void testDownloadAllAttachmentFilesForSignerInPackageExample()
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
            ESignLiveExamples.downloadAllAttachmentFilesForSignerInPackageExample(packageId, roleId);
        
        Test.stopTest();
    }

    /**
     * Method to test the updateSignerExample method
     */
    public static testMethod void testUpdateSignerExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            String firstname = 'Tester';
            String lastname = 'Test';
            String email = 't.tester@test.com';
            String optionalMessage = 'Your role was reassigned';
            ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            signer.reassign = true;
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveExamples.updateSignerExample(packageId, roleId, firstname, lastname, email, optionalMessage);
        
        Test.stopTest();
    }

    /**
     * Method to test the safeSetAuthExample method
     */
    public static testMethod void testSafeSetAuthExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        // Set parameters for call
        List<ESignLiveAPIObjects.AuthChallenge> challenges = new List<ESignLiveAPIObjects.AuthChallenge>();
        ESignLiveAPIObjects.AuthChallenge authChallenge = ESignLiveTestDataUtility.createAuthChallenge();
        challenges.add(authChallenge);
        
        ESignLiveAPIObjects.Signer s = new ESignLiveAPIObjects.Signer();
        s.firstName = 'Tester';
        s.lastName = 'Test';
        
        List<ESignLiveAPIObjects.Signer> signersList = new List<ESignLiveAPIObjects.Signer>();
        signersList.add(s);
        
        ESignLiveAPIObjects.Role signer = ESignLiveTestDataUtility.createRole('roleId', 'roleName', 'roleType', signersList);
        
        // Get JSON response
        String mockResponse = JSON.serialize(signer);
        
        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            ESignLiveExamples.safeSetAuthExample('123456789', '123456789', 'question', 'answer', true);
        
        Test.stopTest();
    }

    /**
     * Method to test the setSigningOrderExample method
     */
    public static testMethod void testSetSigningOrderExample()
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
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            ESignLiveExamples.setSigningOrderExample(packageId, roleId, 2);
        
        Test.stopTest();
    }

    /**
     * Method to test the getSigningStatusExample method
     */
    public static testMethod void testGetSigningStatusExample()
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
            response = ESignLiveExamples.getSigningStatusExample(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('OPTED_OUT', response );
    }

    /**
     * Method to test the getSigningUrlExample method
     */
    public static testMethod void testGetSigningUrlExample()
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
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            response = ESignLiveExamples.getSigningUrlExample(packageId, signerId);
        
        Test.stopTest();

        // Verify response received contains fake values
        System.assertEquals('https://sandbox.e-signlive.com/auth?target=https%3A%2F%2Fsandbox.e-signlive.com%2Fpackages%2Fa3b023bf-db56-4c53-b36e-bd9acd0579f4%2Fsign&loginToken=Mi4xMDAwGpGY3JJPS55ZnNSeHBmekNxc1RzdnNJRVlBSDkZBR1RhcmxKS09aZ3M4aFZXVlpvdExrdz09', response);
    }

    /**
     * Method to test the downloadDocumentExample method
     */
    public static testMethod void testDownloadDocumentExample()
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
            response = ESignLiveExamples.downloadDocumentExample(packageId, docId);
            
        Test.stopTest();
        
        // Verify response
        System.assertEquals(Blob.valueOf('ThisIsMyBlob').toString(), response.toString() );
    }

    /**
     * Method to test the setStatusExample method
     */
    public static testMethod void testSetStatusExample()
    {
        // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            ESignLiveAPIObjects.PackageStatus status = ESignLiveAPIObjects.PackageStatus.DRAFT;
            
            // Get JSON response
            String mockResponse = '';
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            ESignLiveExamples.setStatusExample(packageId, status);
            
        Test.stopTest();
    }

    /**
     * Method to test the addSignatureExample method
     */
    public static testMethod void testAddSignatureExample()
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
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse));
            
            // Creates class that does callout
            ESignLiveExamples.addSignatureExample( packageId, role, docId, 100, 100, 100, 100, 'fieldType', 'text', 10);
        
        Test.stopTest();
    }

    /**
     * Method to test the addRoleExample method
     */
    public static testMethod void testAddRoleExample()
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
            response = ESignLiveExamples.addRoleExample(packageId, 'Test', 'Role', 'test.role@test.com');
        
        Test.stopTest();
        
        // Verify result
        ESignLiveAPIObjects.Role result = (ESignLiveAPIObjects.Role) JSON.deserialize(response, ESignLiveAPIObjects.Role.class);
        System.assertEquals('roleId', result.Id);
        System.assertEquals('roleName', result.Name);
        System.assertEquals('roleType', result.Type);
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testDeletePackageExample()
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
            
            // Creates class that does callout
            response = ESignLiveExamples.deletePackageExample(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testUpdateDocumentExample()
    {
         // Create custom setting for test
        ESignLiveTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc123';
            String docName = 'New docName';
            String description = 'New description';
          
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new ESignLiveServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = ESignLiveExamples.updateDocumentExample(packageId, docId, docName, description);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response);
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testDeleteDocumentExample()
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
            
            // Creates class that does callout
            response = ESignLiveExamples.deleteDocumentExample(packageId, docId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    } 

    public static testMethod void testDeleteRoleExample()
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
            
            // Creates class that does callout
            response = ESignLiveExamples.deleteRoleExample(packageId, roleId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void getApprovalExample()
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
            response = ESignLiveExamples.getApprovalExample(packageId, docId, approvalId);
        
        Test.stopTest();
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testUpdateApprovalExample()
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
            response = ESignLiveExamples.updateApprovalExample(packageId, docId, approvalId);
        
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
            response = ESignLiveExamples.deleteApprovalExample(packageId, documentId, approvalId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
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
            response = ESignLiveExamples.getRoleExample(packageId, roleId);
        
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
            response = ESignLiveExamples.updateRoleExample(packageId, roleId, 'FirstName', 'LastName', 'email@test.com', true);            
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response);
    }
}
