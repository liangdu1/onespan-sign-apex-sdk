/**
 * Class Name: ESignLiveExamples.cls
 *
 * Class containing examples for using the SDK
 */

public with sharing class ESignLiveExamples 
{
    public ESignLiveExamples(){}

    /**
     * Example method for creating a package without any documents
     */
    public static String createPackageExample()
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Set up the example package 
        ESignLiveAPIObjects.Package_x pkg = new ESignLiveAPIObjects.Package_x();
        pkg.name = 'Test Package Name';
        pkg.autocomplete = true;
        pkg.description = 'Sample Description';
        pkg.due = System.now().addDays(7);
        pkg.emailMessage = 'Sample email message';

        // Call the SDK method and get the packageId which is returned from the SDK method
        String packageId = sdk.createPackage(pkg);      

        // Print the packageId to console
        System.debug('=> Response from createPackageExample: ' + packageId);

        return packageId;
    }

    /**
     * Example method for creating a package with a document
     */
    public static void createPackageWithDocumentsExample(String packageName, Boolean autocomplete, String packageDescription, DateTime packageDue, String emailMessage)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Set up the example package and Document data
        ESignLiveAPIObjects.Package_x pkg = new ESignLiveAPIObjects.Package_x();
        Map<String,Blob> blobMap = new Map<String,Blob>();

        Blob b1 = Blob.valueOf('testDocumentOne');
        BLob b2 = Blob.valueOf('test');

        blobMap.put('testDocumentOne', b1);
        blobMap.put('testDocumentTwo', b2);

        pkg.name = packageName;
        pkg.autocomplete = autocomplete;
        pkg.description = packageDescription;

        ESignLiveAPIObjects.ExtractAnchor ea = new ESignLiveAPIObjects.ExtractAnchor();
        ea.text = 'testDocumentOne';
        ea.index = 0;
        ea.width = 150;
        ea.height = 40;
        ea.anchorPoint = ESignLiveAPIObjects.AnchorPoint.TOPRIGHT;
        ea.characterIndex = 12;
        ea.leftOffset = -20;
        ea.topOffset = -60;

        ESignLiveAPIObjects.Field f1 = new ESignLiveAPIObjects.Field();
        f1.type = 'SIGNATURE';
        f1.page = 0;
        f1.extract = false; 
        f1.left = 0;
        f1.subtype = 'FULLNAME';
        f1.top = 0;
        f1.extractAnchor = ea;


        ESignLiveAPIObjects.ExtractAnchor ea1 = new ESignLiveAPIObjects.ExtractAnchor();
        ea1.text = 'testDocumentOne';
        ea1.index = 0;
        ea1.width = 150;
        ea1.height = 40;
        ea1.anchorPoint = ESignLiveAPIObjects.AnchorPoint.BOTTOMRIGHT;
        ea1.characterIndex = 12;
        ea1.leftOffset = -40;
        ea1.topOffset = 0;

        ESignLiveAPIObjects.Field f2 = new ESignLiveAPIObjects.Field();
        f2.type = 'INPUT';
        f2.page = 0;
        f2.extract = false; 
        f2.left = 0;
        f2.subtype = 'LABEL';
		f2.binding = '{approval.signed}';
        f2.top = 0;
        f2.extractAnchor = ea1;

        // Create request
        List<ESignLiveAPIObjects.AuthChallenge> challenges = new List<ESignLiveAPIObjects.AuthChallenge>();
        
        ESignLiveAPIObjects.Delivery delivery = new ESignLiveAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;

        ESignLiveAPIObjects.Auth auth = new ESignLiveAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = ESignLiveAPIObjects.AuthScheme.NONE;

        ESignLiveAPIObjects.Signer signer = new ESignLiveAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = 'firstName';
        signer.lastName = 'lastName';
        signer.email = 'fnln@test.com';
        signer.name = 'firstNamelastName';

        List<ESignLiveAPIObjects.Signer> signers = new List<ESignLiveAPIObjects.Signer>();
        signers.add(signer);

        ESignLiveAPIObjects.Role role = new ESignLiveAPIObjects.Role();
        role.signers = signers;
        role.reassign = true;
        role.name = 'firstNamelastName';
        role.id = 'firstNamelastName';
        role.type = 'SIGNER';

        ESignLiveAPIObjects.Approval approval1 = new ESignLiveAPIObjects.Approval();
        approval1.role = 'firstNamelastName';
        approval1.fields = new List<ESignLiveAPIObjects.Field> {f1,f2};

        ESignLiveAPIObjects.Document doc1 = new ESignLiveAPIObjects.Document();
        doc1.name = 'testDocumentOne';
        doc1.approvals = new List<ESignLiveAPIObjects.Approval> {approval1};

        ESignLiveAPIObjects.Document doc2 = new ESignLiveAPIObjects.Document();
        doc2.name = 'testDocumentTwo';

        pkg.documents = new List<ESignLiveAPIObjects.Document> {doc1,doc2};
        pkg.roles = new List<ESignLiveAPIObjects.Role> {role};

        // Call the SDK method and get the packageId which is returned from the SDK method
        String response = sdk.createPackage(pkg,blobMap);       

        // Print the packageId to console
        System.debug('=> Response from createPackageWithDocumentsExample: ' + response);
    }

    /**
     * Example method for getting a package
     */
    public static ESignLiveAPIObjects.Package_x getPackageExample(String packageId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        ESignLiveAPIObjects.Package_x pkg = sdk.getPackage(packageId);
        System.debug('=> Response Package from getPackageExample: ' + pkg);
        
        return pkg;
    }

    /**
     * Example method for updating a package
     */
    public static void updatePackageExample(ESignLiveAPIObjects.Package_x pkg, String packageId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        sdk.updatePackage(pkg,packageId);
    }

    /**
     * Example method for creating a document
     */
    public static String createDocumentsExample(String packageId, String docName, String docDescription)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Set up the Document data
        Map<String,Blob> blobMap = new Map<String,Blob>();

        Blob b1 = Blob.valueOf('testDocumentOne');
        Blob b2 = Blob.valueof('testDocumentTwo');
        
        blobMap.put('testDocumentOne', b1);
        blobMap.put('testDocumentTwo', b2);

        ESignLiveAPIObjects.Document doc = new ESignLiveAPIObjects.Document();
        doc.Name = docName;
        doc.description = docDescription;

        ESignLiveAPIObjects.ExtractAnchor ea = new ESignLiveAPIObjects.ExtractAnchor();
        ea.text = 'testDocumentOne';
        ea.index = 0;
        ea.width = 150;
        ea.height = 40;
        ea.anchorPoint = ESignLiveAPIObjects.AnchorPoint.TOPRIGHT;
        ea.characterIndex = 12;
        ea.leftOffset = -20;
        ea.topOffset = -60;

        ESignLiveAPIObjects.Field f1 = new ESignLiveAPIObjects.Field();
        f1.type = 'SIGNATURE';
        f1.page = 0;
        f1.extract = false; 
        f1.left = 0;
        f1.subtype = 'FULLNAME';
        f1.top = 0;
        f1.extractAnchor = ea;


        ESignLiveAPIObjects.ExtractAnchor ea1 = new ESignLiveAPIObjects.ExtractAnchor();
        ea1.text = 'testDocumentOne';
        ea1.index = 0;
        ea1.width = 150;
        ea1.height = 40;
        ea1.anchorPoint = ESignLiveAPIObjects.AnchorPoint.BOTTOMRIGHT;
        ea1.characterIndex = 12;
        ea1.leftOffset = -40;
        ea1.topOffset = 0;

        ESignLiveAPIObjects.Field f2 = new ESignLiveAPIObjects.Field();
        f2.type = 'INPUT';
        f2.page = 0;
        f2.extract = false; 
        f2.left = 0;
        f2.subtype = 'LABEL';
        f2.binding = '{approval.signed}';
        f2.top = 0;
        f2.extractAnchor = ea1;

        // Create request
        List<ESignLiveAPIObjects.AuthChallenge> challenges = new List<ESignLiveAPIObjects.AuthChallenge>();
        
        ESignLiveAPIObjects.Delivery delivery = new ESignLiveAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;

        ESignLiveAPIObjects.Auth auth = new ESignLiveAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = ESignLiveAPIObjects.AuthScheme.NONE;

        ESignLiveAPIObjects.Signer signer = new ESignLiveAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = 'firstName';
        signer.lastName = 'lastName';
        signer.email = 'fnln@test.com';
        signer.name = 'firstNamelastName';

        List<ESignLiveAPIObjects.Signer> signers = new List<ESignLiveAPIObjects.Signer>();
        signers.add(signer);

        ESignLiveAPIObjects.Role role = new ESignLiveAPIObjects.Role();
        role.signers = signers;
        role.reassign = true;
        role.name = 'firstNamelastName';
        role.id = 'firstNamelastName';
        role.type = 'SIGNER';

        ESignLiveAPIObjects.Approval approval1 = new ESignLiveAPIObjects.Approval();
        approval1.role = 'firstNamelastName';
        approval1.fields = new List<ESignLiveAPIObjects.Field> {f1,f2};

        ESignLiveAPIObjects.Document doc1 = new ESignLiveAPIObjects.Document();
        doc.name = 'testDocumentOne';
        doc.approvals = new List<ESignLiveAPIObjects.Approval> {approval1};
        // Call the SDK method and get the packageId which is returned from the SDK method
        String response = sdk.createDocuments(packageId, doc, blobMap);       

        // Print the packageId to console
        System.debug('=> Response from createDocumentsExample: ' + response);

        return response;
    }


    /**
     * Example method for setting the attachment requirement feature
     */
    public static void setAttachmentRequirementsExample(String packageId, String roleId, String arName, Boolean arRequired, String arDescription)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Set up the example attachment requirements
        List<ESignLiveAPIObjects.AttachmentRequirement> arList = new List<ESignLiveAPIObjects.AttachmentRequirement>();

        ESignLiveAPIObjects.AttachmentRequirement ar1 = new ESignLiveAPIObjects.AttachmentRequirement();
        ar1.name = arName;
        ar1.required = arRequired;
        ar1.description = arDescription;
        arList.add(ar1);

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.setAttachmentRequirements(arList, packageId, roleId);       

        // Print the response to console
        System.debug('=> Response from setAttachmentRequirementsExample: ' + response);
    }

    /**
     * Example method for getting the audit results
     */
    public static String getAuditExample(String packageId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the Base64 encoded String
        String response = sdk.getAudit(packageId);      

        // Print the Base64 encoded String to console.  If we need to view the PDF document, do the Base64 decoding on the output string and then save the file with .pdf extension.
        System.debug('=> Response from getAuditExample: ' + response);

        return response;
    }

    /**
     * Example method for downloading all attachment files in a package
     */ 
    public static void downloadAllAttachmentFilesForSignerInPackageExample(String packageId,String roleId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and and get the Base64 encoded String
        String response = sdk.downloadAllAttachmentFilesForSignerInPackage(packageId,roleId);

        // Print the Base64 encoded String to console.  If we need to view the documents, do the Base64 decoding on the output string and then save the file with .zip extension.
        System.debug('=> Response from downloadAllAttachmentFilesForSignerInPackageExample: ' + response);
    }

    /**
     * Method for updating a signer
     */
    public static void updateSignerExample(String packageId, String roleId, String firstname, String lastname, String email, String optionalMessageToTheAssignee)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the new Role information as the response 
        String response = sdk.updateSigner(packageId, roleId, firstname, lastname, email, optionalMessageToTheAssignee);

        // Print the response to console
        System.debug('=> Response from updateSignerExample: ' + response);
    }

    /**
     * Example method to set the authentication challenge
     */
    public static void safeSetAuthExample(String packageId, String roleId, String question, String answer, Boolean maskInput)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        
        List<ESignLiveAPIObjects.AuthChallenge> challenges = new List<ESignLiveAPIObjects.AuthChallenge>();
        ESignLiveAPIObjects.AuthChallenge challenge = new ESignLiveAPIObjects.AuthChallenge();

        challenge.question = question;
        challenge.answer = answer;
        challenge.maskInput = maskInput;

        challenges.add(challenge);

        // Call the SDK method and get the response status code and status string
        String response = sdk.safeSetAuth(packageId, roleId, ESignLiveAPIObjects.AuthScheme.CHALLENGE, challenges);

        // Print the response to console
        System.debug('=> Response from safeSetAuthExample: ' + response);
    }

    /**
     * Example method to set the signing order
     */
    public static void setSigningOrderExample(String packageId, String roleId, Integer index)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.setSigningOrder(packageId, roleId, index);

        // Print the response to console
        System.debug('=> Response from safeSetAuthExample: ' + response);
    }

    /**
     * Example method to get the signing status
     */
    public static String getSigningStatusExample(String packageId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        String response = sdk.getSigningStatus(packageId);

        // Print the Package Status to console
        System.debug('=> Response from getSigningStatusExample: ' + response);

        return response;
    }

    /**
     * Example method to get the signing Url
     */
    public static String getSigningUrlExample(String packageId, String signerId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        String response = sdk.getSigningUrl(packageId, signerId);

        // Print the Signing URL to the console
        System.debug('=> Response from getSigningUrlExample: ' + response);

        return response;
    }

    /**
     * Example method for downloading a document
     */
    public static Blob downloadDocumentExample(String packageId, String documentId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        Blob documentBlob = sdk.downloadDocument(packageId,documentId);

        // Print the Base64 Encoded document string to console
        System.debug('=> Response from downloadDocumentExample: ' + EncodingUtil.base64Encode(documentBlob));

        return documentBlob;
    }

    /**
     * Example method to set the package status
     */
    public static void setStatusExample(String packageId, ESignLiveAPIObjects.PackageStatus status)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        String response = sdk.setStatus(packageId,status);

        // Print the HTTP Reponse status code and status string to console
        System.debug('=> Response from setStatusExample: ' + response);
    }

    /**
     * Example method for adding a signature
     */
    public static String addSignatureExample(String packageId, String roleId, String documentId, Decimal left, Decimal top, Decimal width, Decimal height,
                                           String fieldType, String fieldSubType, Integer page)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        
        ESignLiveAPIObjects.Field field1 = new ESignLiveAPIObjects.Field();
        field1.left = left;
        field1.top = top;
        field1.width = width;
        field1.height = height;
        field1.type = fieldType;
        field1.subtype = fieldSubType;
        field1.value = null;
        field1.page = page;


        List<ESignLiveAPIObjects.Field> fieldList = new List<ESignLiveAPIObjects.Field>();
        fieldList.add(field1);

        ESignLiveAPIObjects.Approval approval = new ESignLiveAPIObjects.Approval();
        approval.role = roleId;
        approval.fields = fieldList;

        String response = sdk.addSignature(packageId,documentId,approval);

        // Print the Approval object JSON String to console
        System.debug('=> Response from addSignatureExample: ' + response);

        return response;
    }

    /**
     * Example method for adding a role
     */
    public static String addRoleExample(String packageId, String firstname, String lastname, String email)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        
        // Call the SDK method and get the Role object JSON String as response
        String response = sdk.addRole(firstname, lastname, email, packageId);

        // Print the response to console
        System.debug('=> Response from addRoleExample: ' + response);

        return response;
    }

    /**
     * Example method for deleting a Package
     */
    public static String deletePackageExample(String packageId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response =  sdk.deletePackage(packageId);

        // Print the response to console
        System.debug('=> Response from deletePackageExample: ' + response);
        
        return response;
    }

    /**
     * Example method to update a Document
     */
    public static String updateDocumentExample(String packageId, String documentId, String docName, String description)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Example that will update the document name and description
        ESignLiveAPIObjects.Document doc = new ESignLiveAPIObjects.Document();
        doc.Name = 'New Document Name';
        doc.description = 'New description';

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.updateDocument(packageId, documentId, doc);

        // Print the response to console
        System.debug('=> Response from updateDocumentExample: ' + response);
        
        return response;
    }

    /**
     * Example method to delete a Document
     */
    public static String deleteDocumentExample(String packageId, String documentId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response =  sdk.deleteDocument(packageId, documentId);

        // Print the response to console
        System.debug('=> Response from deleteDocumentExample: ' + response);
        
        return response;
    } 

    /**
     * Example method to delete a role
     */
    public static String deleteRoleExample(String packageId, String roleId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response  = sdk.deleteDocument(packageId, roleId);

        // Print the response to console
        System.debug('=> Response from deleteRoleExample: ' + response);
        
        return response;
    }

    /**
     * Example method to get an approval
     */
    public static ESignLiveAPIObjects.Approval getApprovalExample(String packageId, String documentId, String approvalId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the Approval object as response
        ESignLiveAPIObjects.Approval response = sdk.getApproval(packageId, documentId, approvalId);

        // Print the Approval object to console
        System.debug('=> Response from getApprovalExample: ' + response);
        
        return response;
    }

    /**
     * Example method to update an approval
     */
    public static String updateApprovalExample(String packageId, String documentId, String approvalId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        
        ESignLiveAPIObjects.Approval approval = new ESignLiveAPIObjects.Approval();
        approval.name = 'New name';
        approval.role = 'New role';
        approval.fields = new List<ESignLiveAPIObjects.Field>();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.updateApproval(packageId, documentId, approvalId, approval);

        // Print the response to console
        System.debug('=> Response from updateApprovalExample: ' + response);
        
        return response;
    }

    /**
     * Example method to delete an approval
     */
    public static String deleteApprovalExample(String packageId, String documentId, String approvalId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.deleteApproval(packageId, documentId, approvalId);

        // Print the response to console
        System.debug('=> Response from deleteApprovalExample: ' + response);
        
        return response;
    }

    /**
     * Example method to get a role
     */
    public static ESignLiveAPIObjects.Role getRoleExample(String packageId, String roleId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the Role object as the response
        ESignLiveAPIObjects.Role response = sdk.getRole(packageId, roleId);

        // Print the response to console
        System.debug('=> Response from updateApprovalExample: ' + response);
        
        return response;
    }

    /**
     * Example method to update a role
     */
    public static String updateRoleExample(String packageId, String roleId, String firstname, String lastname, String email, Boolean reassign)
    {
         // Create request
        List<ESignLiveAPIObjects.AuthChallenge> challenges = new List<ESignLiveAPIObjects.AuthChallenge>();
        
        ESignLiveAPIObjects.Delivery delivery = new ESignLiveAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;

        ESignLiveAPIObjects.Auth auth = new ESignLiveAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = ESignLiveAPIObjects.AuthScheme.NONE;

        ESignLiveAPIObjects.Signer signer = new ESignLiveAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = firstName;
        signer.lastName = lastName;
        signer.email = email;
        signer.name = firstName + lastName;

        List<ESignLiveAPIObjects.Signer> signers = new List<ESignLiveAPIObjects.Signer>();
        signers.add(signer);

        ESignLiveAPIObjects.Role role = new ESignLiveAPIObjects.Role();
        role.signers = signers;
        role.reassign = reassign;
  
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.updateRole(packageId, roleId, role );

        // Print the response to console
        System.debug('=> Response from updateRoleExample: ' + response);
        
        return response;
    }

    /**
     * Example method for adding a field
     */
    public static void addFieldExample(String packageId, String documentId, String approvalId, Decimal left, Decimal top, Decimal width, Decimal height,
                                           String fieldType, String fieldSubType, Integer page,String binding)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        
        ESignLiveAPIObjects.Field field1 = new ESignLiveAPIObjects.Field();
        field1.left = left;
        field1.top = top;
        field1.width = width;
        field1.height = height;
        field1.type = fieldType;
        field1.subtype = fieldSubType;
        field1.value = null;
        field1.page = page;
        field1.binding = binding;

        String response = sdk.addField(packageId,documentId,approvalId,field1);

        // Print the field object JSON string to console
        System.debug('=> Response from addFieldExample: ' + response);
    }

    /**
     * Example method to get a field
     */
    public static ESignLiveAPIObjects.Field getFieldExample(String packageId, String documentId, String approvalId, String fieldId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the Field object as the response
        ESignLiveAPIObjects.Field response = sdk.getField(packageId, documentId, approvalId, fieldId);

        // Print the field object to console
        System.debug('=> Response from getFieldExample: ' + response);
        
        return response;
    }

    /**
     * Example method to update a field
     */
    public static String updateFieldExample(String packageId, String documentId, String approvalId, String fieldId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();
        
        // Example that will update the document name and role
        ESignLiveAPIObjects.Field field1 = new ESignLiveAPIObjects.Field();
        field1.left = 300;
        field1.top = 500;
        field1.width = 100;
        field1.height = 30;
        field1.type = 'SIGNATURE';
        field1.subtype = 'FULLNAME';
        field1.value = null;
        field1.page = 0;

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.updateField(packageId, documentId, approvalId, fieldId, field1);

        // Print the response to console
        System.debug('=> Response from updateFieldExample: ' + response);
        
        return response;
    }

    /**
     * Example method to delete a Field
     */
    public static String deleteFieldExample(String packageId, String documentId, String approvalId, String fieldId)
    {
        ESignLiveSDK sdk = new ESignLiveSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.deleteField(packageId, documentId, approvalId, fieldId);

        // Print the response to console
        System.debug('=> Response from deleteFieldExample: ' + response);
        
        return response;
    }


}
