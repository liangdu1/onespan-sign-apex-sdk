/**
 * Class Name: OneSpanExamplesTest.cls*
 * Class to test the OneSpanExamples class
 */

@isTest
public class OneSpanExamplesTest
{
    /**
     * Method to test the createPackageExample method
     */
    public static testMethod void testCreatePackageExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            String docId = 'abc987654321';
            OneSpanAPIObjects.Package_x packageSettings = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.createPackageExample();
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            String docId = 'abc987654321';
            OneSpanAPIObjects.Package_x packageSettings = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            Map<String,Blob> documentMap = OneSpanTestDataUtility.createDocumentMap();
            OneSpanTestDataUtility.createDocumentObject();
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanExamples.createPackageWithDocumentsExample('packName', false, 'description', Datetime.now(), 'emailMessage');
        
        Test.stopTest();
    }

    /**
     * Method to test the getPackageExample method
     */
    public static testMethod void testGetPackageExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();

            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.Package_x packageSettings = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Set JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Response object 
            OneSpanAPIObjects.Package_x response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.getPackageExample(packageId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Get JSON response
            String mockResponse = '';
            
            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.Package_x packageSettings = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 500));
            
            // Creates class that does callout
            try
            {
                OneSpanExamples.updatePackageExample(packageSettings, packageId);
            } 
            catch( Exception e)
            {
                System.assertEquals('OneSpanRESTAPIHelper.OneSpanRestAPIHelperException', e.getTypeName());
            }

        Test.stopTest();
    }

    /**
     * Method to test the createDocumentsExample method
     */
    public static testMethod void testCreateDocumentsExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            OneSpanAPIObjects.Document document = OneSpanTestDataUtility.createDocument('docId', 'Document Name', 123);
            OneSpanTestDataUtility.createDocumentObject();
            
            // Get JSON response
            String mockResponse = JSON.serialize(document);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.createDocumentsExample(packageId, 'Document Name', 'Description');
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            List<OneSpanAPIObjects.AttachmentRequirement> attachmentRequirementsList = new List<OneSpanAPIObjects.AttachmentRequirement>();
            OneSpanAPIObjects.AttachmentRequirement ar = new OneSpanAPIObjects.AttachmentRequirement();
            ar.Name = 'AttchReq';
            attachmentRequirementsList.add(ar);
            String packageId = '123456';
            String roleId = 'abc987';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            signer.attachmentRequirements = attachmentRequirementsList;
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            OneSpanExamples.setAttachmentRequirementsExample(packageId, roleId, 'arName', false, 'description');
            
        Test.stopTest();
    }

    /**
     * Method to test the getAuditExample method
     */
    public static testMethod void testGetAuditExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock('',200,Blob.valueOf('ThisIsMyBlob')));
            // Creates class that does callout
            String response = OneSpanExamples.getAuditExample('123456');
    
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            OneSpanExamples.downloadAllAttachmentFilesForSignerInPackageExample(packageId, roleId);
        
        Test.stopTest();
    }

    /**
     * Method to test the updateSignerExample method
     */
    public static testMethod void testUpdateSignerExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            String firstname = 'Tester';
            String lastname = 'Test';
            String email = 't.tester@test.com';
            String optionalMessage = 'Your role was reassigned';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            signer.reassign = true;
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanExamples.updateSignerExample(packageId, roleId, firstname, lastname, email, optionalMessage);
        
        Test.stopTest();
    }

    /**
     * Method to test the safeSetAuthExample method
     */
    public static testMethod void testSafeSetAuthExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        // Set parameters for call
        List<OneSpanAPIObjects.AuthChallenge> challenges = new List<OneSpanAPIObjects.AuthChallenge>();
        OneSpanAPIObjects.AuthChallenge authChallenge = OneSpanTestDataUtility.createAuthChallenge();
        challenges.add(authChallenge);
        
        OneSpanAPIObjects.Signer s = new OneSpanAPIObjects.Signer();
        s.firstName = 'Tester';
        s.lastName = 'Test';
        
        List<OneSpanAPIObjects.Signer> signersList = new List<OneSpanAPIObjects.Signer>();
        signersList.add(s);
        
        OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType', signersList);
        
        // Get JSON response
        String mockResponse = JSON.serialize(signer);
        
        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            OneSpanExamples.safeSetAuthExample('123456789', '123456789', 'question', 'answer', true);
        
        Test.stopTest();
    }

    /**
     * Method to test the setSigningOrderExample method
     */
    public static testMethod void testSetSigningOrderExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();

            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            OneSpanExamples.setSigningOrderExample(packageId, roleId, 2);
        
        Test.stopTest();
    }

    /**
     * Method to test the getSigningStatusExample method
     */
    public static testMethod void testGetSigningStatusExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            
            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.Package_x packageSettings = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Response object 
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.getSigningStatusExample(packageId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = 'a3b023bf-db56-4c53-b36e-bd9acd0579f4';
            String signerId = '654321';
            String roleId = '2jsTTXD2dZMZ';
            String url =  'https://sandbox.e-signlive.com/auth?target=https%3A%2F%2Fsandbox.e-signlive.com%2Fpackages%2Fa3b023bf-db56-4c53-b36e-bd9acd0579f4%2Fsign&loginToken=Mi4xMDAwGpGY3JJPS55ZnNSeHBmekNxc1RzdnNJRVlBSDkZBR1RhcmxKS09aZ3M4aFZXVlpvdExrdz09';
            OneSpanAPIObjects.SigningUrl su = new OneSpanAPIObjects.SigningUrl(roleId, url, packageId);
            
            // Set response object
            String mockResponse = JSON.serialize(su);
            
            // Response object 
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.getSigningUrlExample(packageId, signerId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            OneSpanAPIObjects.Package_x packageSettings = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object 
            Blob response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse,200,Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            response = OneSpanExamples.downloadDocumentExample(packageId, docId);
            
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.PackageStatus status = OneSpanAPIObjects.PackageStatus.DRAFT;
            
            // Get JSON response
            String mockResponse = '';
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            OneSpanExamples.setStatusExample(packageId, status);
            
        Test.stopTest();
    }

    /**
     * Method to test the addSignatureExample method
     */
    public static testMethod void testAddSignatureExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            String approvalId = 'abc123456';
            String approvalName = 'NAME';
            String role = 'RKbhyswr2FYO';
            OneSpanAPIObjects.Approval approval = OneSpanTestDataUtility.createApproval(approvalId, approvalName, role);
            
            // Get JSON response
            String mockResponse = JSON.serialize(approval);
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanExamples.addSignatureExample( packageId, role, docId, 100, 100, 100, 100, 'fieldType', 'text', 10);
        
        Test.stopTest();
    }

    /**
     * Method to test the addRoleExample method
     */
    public static testMethod void testAddRoleExample()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.addRoleExample(packageId, 'Test', 'Role', 'test.role@test.com');
        
        Test.stopTest();
        
        // Verify result
        OneSpanAPIObjects.Role result = (OneSpanAPIObjects.Role) JSON.deserialize(response, OneSpanAPIObjects.Role.class);
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.deletePackageExample(packageId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
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
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.updateDocumentExample(packageId, docId, docName, description);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc123';
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.deleteDocumentExample(packageId, docId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    } 

    public static testMethod void testDeleteRoleExample()
    {
           // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc123';
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.deleteRoleExample(packageId, roleId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void getApprovalExample()
    {
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            String approvalId = 'abc123456';
            String approvalName = 'NAME';
            String role = 'RKbhyswr2FYO';
            OneSpanAPIObjects.Approval approval = OneSpanTestDataUtility.createApproval(approvalId, approvalName, role);
            // Get JSON response
            String mockResponse = JSON.serialize(approval);
            
            // Response object
            OneSpanAPIObjects.Approval response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.getApprovalExample(packageId, docId, approvalId);
        
        Test.stopTest();
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testUpdateApprovalExample()
    {
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc987654321';
            String approvalId = 'abc123456';
            String approvalName = 'NAME';
            String role = 'RKbhyswr2FYO';
            OneSpanAPIObjects.Approval approval = OneSpanTestDataUtility.createApproval(approvalId, approvalName, role);
            // Get JSON response
            String mockResponse = JSON.serialize(approval);
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.updateApprovalExample(packageId, docId, approvalId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
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
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.deleteApprovalExample(packageId, documentId, approvalId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            OneSpanAPIObjects.Role response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            response = OneSpanExamples.getRoleExample(packageId, roleId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            String packageId = '123456';
            String roleId = 'abc987';
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            response = OneSpanExamples.updateRoleExample(packageId, roleId, 'FirstName', 'LastName', 'email@test.com', true);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response);
    }
}
