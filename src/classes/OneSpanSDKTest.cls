/**
 * Class Name: OneSpanSDKTestls
 *
 * Test class for the OneSpanSDK class
 */

@isTest
public class OneSpanSDKTest
{
    /**
     * Test method for safeSetAuth method
     */
    private static testMethod void testSafeSetAuth()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        // Set parameters for call
        List<OneSpanAPIObjects.AuthChallenge> challenges = new List<OneSpanAPIObjects.AuthChallenge>();
        OneSpanAPIObjects.AuthChallenge authChallenge = OneSpanTestDataUtility.createAuthChallenge();
        challenges.add(authChallenge);
        OneSpanAPIObjects.Signer s = new OneSpanAPIObjects.Signer();
        s.firstName = 'Test';
        s.lastName = 'Tester';
        List<OneSpanAPIObjects.Signer> signersList = new List<OneSpanAPIObjects.Signer>();
        signersList.add(s);
        OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType',signersList);
        
        // Get JSON response
        String mockResponse = JSON.serialize(signer);
        
        Test.startTest();
        
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            OneSpanSDK sdk = new OneSpanSDK();
            String responseStatus = sdk.safeSetAuth('123456789', '123456789', OneSpanAPIObjects.AuthScheme.PROVIDER, challenges);
        
        Test.stopTest();
    }
    
    /**
     * Test method for getAudit method
     */
    private static testMethod void testGetAudit()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();

        Test.startTest();

            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock('', 200, Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            OneSpanSDK sdk = new OneSpanSDK();
            String response = sdk.getAudit('123456');
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('VGhpc0lzTXlCbG9i', response);
    }

    /**
     * Test method for updateSigner method
     */
    private static testMethod void testUpdateSigner()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            String firstname = 'FirstName';
            String lastname = 'LastName';
            String email = 'test@emailtest.com';
            String optionalMessage = 'Your role was reassigned';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            signer.reassign = true;
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            String response = null; 
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanSDK sdk = new OneSpanSDK();
            response = sdk.updateSigner(packageId, roleId, firstname, lastname, email, optionalMessage);
        
        Test.stopTest();
        
        OneSpanAPIObjects.Role roleResponse = (OneSpanAPIObjects.Role) JSON.deserialize(response, OneSpanAPIObjects.Role.class);
        System.assertEquals('roleId', roleResponse.Id);
        System.assertEquals('roleName', roleResponse.Name);
        System.assertEquals('roleType', roleResponse.Type);
    }

    /**
     * Test method for setAttachmentRequirements method
     */
    private static testMethod void testSetAttachmentRequirements()
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
            
            // Response object
            String response = null; 
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            OneSpanSDK sdk = new OneSpanSDK();
            response = sdk.setAttachmentRequirements(attachmentRequirementsList, packageId, roleId);
    
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Test method for downloadAllAttachmentFilesForSignerInPackage method
     */
    private static testMethod void testDownloadAllAttachmentFilesForSignerInPackage()
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
            OneSpanSDK sdk = new OneSpanSDK();
            response = sdk.downloadAllAttachmentFilesForSignerInPackage(packageId, roleId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('VGhpc0lzTXlCbG9i', response);
    }

    /**
     * Test method for createPackage method
     */
    private static testMethod void testCreatePackage()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.createPackage( packageSettings );
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(packageId, response);
    }

    /**
     * Test method for createPackageWithDocumentMap method
     */
    private static testMethod void testCreatePackageWithDocumentMap()
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
            
            // Get JSON response
            String mockResponse = JSON.serialize(packageSettings);
            
            // Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.createPackage(packageSettings, documentMap);
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(packageId, response);
    }

    /**
     * Test method for getPackage method
     */
    private static testMethod void testGetPackage()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.getPackage(packageId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('packName', response.name);
    }

    /**
     * Test method for updatePackage method
     */
    private static testMethod void testUpdatePackage()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            try
            {
                liveSDK.updatePackage(packageSettings, packageId);
            } 
            catch( Exception e)
            {
                System.assertEquals('OneSpanRESTAPIHelper.OneSpanRestAPIHelperException', e.getTypeName());
            }
        
        Test.stopTest();
    }
    
    /**
     * Test method for createDocuments method
     */
    private static testMethod void testCreateDocuments()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            Blob myBlob = Blob.valueof('StringToBlob');
            String packageId = 'avc123456';
            OneSpanAPIObjects.Document document= OneSpanTestDataUtility.createDocument('id','name',1);
            Map<String,Blob> documentMap = OneSpanTestDataUtility.createDocumentMap();
            
            // Get JSON response
            String mockResponse = JSON.serialize(document);
            
            // Object response
            String response = null;

            OneSpanAPIObjects.Document doc = new OneSpanAPIObjects.Document();
            doc.Name = 'Test Doc';
            doc.description = 'Test Description';
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.createDocuments( packageId, doc, documentMap);
        
        Test.stopTest();
        
        // Verify the result
        System.assertEquals(mockResponse, response);
    }
    
    /**
     * Test method for setSigningOrder method
     */
    private static testMethod void testSetSigningOrder()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        // Set test start
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String roleId = 'abc987';
            OneSpanAPIObjects.Role signer = OneSpanTestDataUtility.createRole('roleId', 'roleName', 'roleType');
            
            // Get JSON response
            String mockResponse = JSON.serialize(signer);
            
            // Response object
            String response = null; 
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse,200,'OK'));
            
            // Creates class that does callout
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.setSigningOrder(packageId, roleId, 2);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Test method for getSigningStatus method
     */
    private static testMethod void testGetSigningStatus()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.getSigningStatus(packageId);
        
        Test.stopTest();
        
        //Verify result
        System.assertEquals('OPTED_OUT', response);
    }

    /**
     * Test method for getSigningUrl method
     */
    private static testMethod void testGetSigningUrl()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.getSigningUrl(packageId, signerId);
        
        Test.stopTest();
        
        // Verify response received contains fake values
        System.assertEquals('https://sandbox.e-signlive.com/auth?target=https%3A%2F%2Fsandbox.e-signlive.com%2Fpackages%2Fa3b023bf-db56-4c53-b36e-bd9acd0579f4%2Fsign&loginToken=Mi4xMDAwGpGY3JJPS55ZnNSeHBmekNxc1RzdnNJRVlBSDkZBR1RhcmxKS09aZ3M4aFZXVlpvdExrdz09', response);
    }

    /**
     * Test method for downloadDocument method
     */
    private static testMethod void testDownloadDocument()
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
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, Blob.valueOf('ThisIsMyBlob')));
            
            // Creates class that does callout
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.downloadDocument(packageId, docId);
        
        Test.stopTest();
        
        System.assertEquals(Blob.valueOf('ThisIsMyBlob').toString(), response.toString() );
    }

    /**
     * Test method for setStatus method
     */
    private static testMethod void testSetStatus()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            OneSpanAPIObjects.PackageStatus status = OneSpanAPIObjects.PackageStatus.DRAFT;
            
            // Get JSON response
            String mockResponse = '';
            
            //Object response
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Creates class that does callout
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.setStatus(packageId, status);
        
        Test.stopTest();
        
        // Verify result;
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Test method for addSignature method
     */
    private static testMethod void testaddSignature()
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
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse));
            
            // Creates class that does callout
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.addSignature( packageId, docId, approval);
        
        Test.stopTest();
        
        // Verify result
        OneSpanAPIObjects.Approval approvalResponse = (OneSpanAPIObjects.Approval) JSON.deserialize(response, OneSpanAPIObjects.Approval.class);
        System.assertEquals('RKbhyswr2FYO', approvalResponse.role);
        System.assertEquals(100, approvalResponse.fields.get(0).top );
        System.assertEquals(1, approvalResponse.fields.get(0).left);
    }

    /**
     * Test method for addRole method
     */
    private static testMethod void testAddRole()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.addRole('FirstName', 'LastName', 'email@testemail.com', packageId);
        
        Test.stopTest();
        
        // Verify result
        OneSpanAPIObjects.Role result = (OneSpanAPIObjects.Role) JSON.deserialize(response, OneSpanAPIObjects.Role.class);
        System.assertEquals('roleId', result.Id);
        System.assertEquals('roleName', result.Name);
        System.assertEquals('roleType', result.Type);
    }

    /**
     * Test method for createRolesSigner method
     */
    private static testMethod void testCreateRolesSigner()
    {
        // Set parameters
        String firstName = 'FirstName';
        String lastname = 'LastName';
        String email = 'email@testemail.com';
        String title = 'Title';
        String company = 'Company';
        
        // Object repsonse
        List<OneSpanAPIObjects.Signer> response = null;
        
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();

        // Code to test
        OneSpanSDK liveSDK = new OneSpanSDK();
        response = liveSDK.createRolesSigner(firstName, lastName, email, title, company);
        
        // Verify result
        OneSpanAPIObjects.Signer signer = response.get(0);
        System.assertEquals(firstName, signer.firstName);
        System.assertEquals(lastname, signer.lastName);
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testDeletePackage()
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
            
            // Code to test
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.deletePackage(packageId);
        
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
        OneSpanTestDataUtility.createConnectionSetting();
        
        Test.startTest();
        
            // Set parameters for call
            String packageId = '123456';
            String docId = 'abc123';
            String docName = 'Document Name';
            String description = 'Description';
            OneSpanAPIObjects.Document doc = new OneSpanAPIObjects.Document();
            doc.Name = 'New Document Name';
            doc.description = 'New description';
          
            // Get JSON response
            String mockResponse = '';
            
            // Response object
            String response = null;
            
            // Set mock callout class
            Test.setMock(HttpCalloutMock.class, new OneSpanServiceMock(mockResponse, 200, 'OK'));
            
            // Code to test
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.updateDocument(packageId, docId, doc);
        
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
            
            // Code to test
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.deleteDocument(packageId, docId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    } 

    public static testMethod void testDeleteRole()
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
            
            // Code to test
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.deleteRole(packageId, roleId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testGetApproval()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.getApproval(packageId, docId, approvalId);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals(role, response.role);
    }

    /**
     * Method to delete a package
     */
    public static testMethod void testUpdateApproval()
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.updateApproval(packageId, docId, approvalId, approval);
        
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.deleteApproval(packageId, documentId, approvalId);
        
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.getRole(packageId, roleId);
        
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
            OneSpanSDK liveSDK = new OneSpanSDK();
            response = liveSDK.updateRole(packageId, roleId, signer);
        
        Test.stopTest();
        
        // Verify result
        System.assertEquals('200 - OK', response.substring(0,8));
    }
}
