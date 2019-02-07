/**
 * Class Name: OneSpanExamples.cls*
 * Class containing examples for using the SDK
 */

public with sharing class OneSpanExamples
{
    public OneSpanExamples(){}

    /**
     * Example method for creating a package without any documents
     */
    public static String createPackageExample()
    {
        OneSpanSDK sdk = new OneSpanSDK();

        // Set up the example package 
        OneSpanAPIObjects.Package_x pkg = new OneSpanAPIObjects.Package_x();
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
        OneSpanSDK sdk = new OneSpanSDK();

        // Set up the example package and Document data
        OneSpanAPIObjects.Package_x pkg = new OneSpanAPIObjects.Package_x();
        Map<String,Blob> blobMap = new Map<String,Blob>();

        Blob b1 = Blob.valueOf('testDocumentOne');
        BLob b2 = Blob.valueOf('test');

        blobMap.put('testDocumentOne', b1);
        blobMap.put('testDocumentTwo', b2);

        pkg.name = packageName;
        pkg.autocomplete = autocomplete;
        pkg.description = packageDescription;

        OneSpanAPIObjects.ExtractAnchor ea = new OneSpanAPIObjects.ExtractAnchor();
        ea.text = 'testDocumentOne';
        ea.index = 0;
        ea.width = 150;
        ea.height = 40;
        ea.anchorPoint = OneSpanAPIObjects.AnchorPoint.TOPRIGHT;
        ea.characterIndex = 12;
        ea.leftOffset = -20;
        ea.topOffset = -60;

        OneSpanAPIObjects.Field f1 = new OneSpanAPIObjects.Field();
        f1.type = 'SIGNATURE';
        f1.page = 0;
        f1.extract = false; 
        f1.left = 0;
        f1.subtype = 'FULLNAME';
        f1.top = 0;
        f1.extractAnchor = ea;


        OneSpanAPIObjects.ExtractAnchor ea1 = new OneSpanAPIObjects.ExtractAnchor();
        ea1.text = 'testDocumentOne';
        ea1.index = 0;
        ea1.width = 150;
        ea1.height = 40;
        ea1.anchorPoint = OneSpanAPIObjects.AnchorPoint.BOTTOMRIGHT;
        ea1.characterIndex = 12;
        ea1.leftOffset = -40;
        ea1.topOffset = 0;

        OneSpanAPIObjects.Field f2 = new OneSpanAPIObjects.Field();
        f2.type = 'INPUT';
        f2.page = 0;
        f2.extract = false; 
        f2.left = 0;
        f2.subtype = 'LABEL';
		f2.binding = '{approval.signed}';
        f2.top = 0;
        f2.extractAnchor = ea1;

        // Create request
        List<OneSpanAPIObjects.AuthChallenge> challenges = new List<OneSpanAPIObjects.AuthChallenge>();
        
        OneSpanAPIObjects.Delivery delivery = new OneSpanAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;

        OneSpanAPIObjects.Auth auth = new OneSpanAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = OneSpanAPIObjects.AuthScheme.NONE;

        OneSpanAPIObjects.Signer signer = new OneSpanAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = 'firstName';
        signer.lastName = 'lastName';
        signer.email = 'fnln@test.com';
        signer.name = 'firstNamelastName';

        List<OneSpanAPIObjects.Signer> signers = new List<OneSpanAPIObjects.Signer>();
        signers.add(signer);

        OneSpanAPIObjects.Role role = new OneSpanAPIObjects.Role();
        role.signers = signers;
        role.reassign = true;
        role.name = 'firstNamelastName';
        role.id = 'firstNamelastName';
        role.type = 'SIGNER';

        OneSpanAPIObjects.Approval approval1 = new OneSpanAPIObjects.Approval();
        approval1.role = 'firstNamelastName';
        approval1.fields = new List<OneSpanAPIObjects.Field> {f1,f2};

        OneSpanAPIObjects.Document doc1 = new OneSpanAPIObjects.Document();
        doc1.name = 'testDocumentOne';
        doc1.approvals = new List<OneSpanAPIObjects.Approval> {approval1};

        OneSpanAPIObjects.Document doc2 = new OneSpanAPIObjects.Document();
        doc2.name = 'testDocumentTwo';

        pkg.documents = new List<OneSpanAPIObjects.Document> {doc1,doc2};
        pkg.roles = new List<OneSpanAPIObjects.Role> {role};

        // Call the SDK method and get the packageId which is returned from the SDK method
        String response = sdk.createPackage(pkg,blobMap);       

        // Print the packageId to console
        System.debug('=> Response from createPackageWithDocumentsExample: ' + response);
    }

    /**
     * Example method for getting a package
     */
    public static OneSpanAPIObjects.Package_x getPackageExample(String packageId)
    {
        OneSpanSDK sdk = new OneSpanSDK();

        OneSpanAPIObjects.Package_x pkg = sdk.getPackage(packageId);
        System.debug('=> Response Package from getPackageExample: ' + pkg);
        
        return pkg;
    }

    /**
     * Example method for updating a package
     */
    public static void updatePackageExample(OneSpanAPIObjects.Package_x pkg, String packageId)
    {
        OneSpanSDK sdk = new OneSpanSDK();
        sdk.updatePackage(pkg,packageId);
    }

    /**
     * Example method for creating a document
     */
    public static String createDocumentsExample(String packageId, String docName, String docDescription)
    {
        OneSpanSDK sdk = new OneSpanSDK();

        // Set up the Document data
        Map<String,Blob> blobMap = new Map<String,Blob>();

        Blob b1 = Blob.valueOf('testDocumentOne');
        Blob b2 = Blob.valueof('testDocumentTwo');
        
        blobMap.put('testDocumentOne', b1);
        blobMap.put('testDocumentTwo', b2);

        OneSpanAPIObjects.Document doc = new OneSpanAPIObjects.Document();
        doc.Name = docName;
        doc.description = docDescription;

        OneSpanAPIObjects.ExtractAnchor ea = new OneSpanAPIObjects.ExtractAnchor();
        ea.text = 'testDocumentOne';
        ea.index = 0;
        ea.width = 150;
        ea.height = 40;
        ea.anchorPoint = OneSpanAPIObjects.AnchorPoint.TOPRIGHT;
        ea.characterIndex = 12;
        ea.leftOffset = -20;
        ea.topOffset = -60;

        OneSpanAPIObjects.Field f1 = new OneSpanAPIObjects.Field();
        f1.type = 'SIGNATURE';
        f1.page = 0;
        f1.extract = false; 
        f1.left = 0;
        f1.subtype = 'FULLNAME';
        f1.top = 0;
        f1.extractAnchor = ea;


        OneSpanAPIObjects.ExtractAnchor ea1 = new OneSpanAPIObjects.ExtractAnchor();
        ea1.text = 'testDocumentOne';
        ea1.index = 0;
        ea1.width = 150;
        ea1.height = 40;
        ea1.anchorPoint = OneSpanAPIObjects.AnchorPoint.BOTTOMRIGHT;
        ea1.characterIndex = 12;
        ea1.leftOffset = -40;
        ea1.topOffset = 0;

        OneSpanAPIObjects.Field f2 = new OneSpanAPIObjects.Field();
        f2.type = 'INPUT';
        f2.page = 0;
        f2.extract = false; 
        f2.left = 0;
        f2.subtype = 'LABEL';
        f2.binding = '{approval.signed}';
        f2.top = 0;
        f2.extractAnchor = ea1;

        // Create request
        List<OneSpanAPIObjects.AuthChallenge> challenges = new List<OneSpanAPIObjects.AuthChallenge>();
        
        OneSpanAPIObjects.Delivery delivery = new OneSpanAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;

        OneSpanAPIObjects.Auth auth = new OneSpanAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = OneSpanAPIObjects.AuthScheme.NONE;

        OneSpanAPIObjects.Signer signer = new OneSpanAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = 'firstName';
        signer.lastName = 'lastName';
        signer.email = 'fnln@test.com';
        signer.name = 'firstNamelastName';

        List<OneSpanAPIObjects.Signer> signers = new List<OneSpanAPIObjects.Signer>();
        signers.add(signer);

        OneSpanAPIObjects.Role role = new OneSpanAPIObjects.Role();
        role.signers = signers;
        role.reassign = true;
        role.name = 'firstNamelastName';
        role.id = 'firstNamelastName';
        role.type = 'SIGNER';

        OneSpanAPIObjects.Approval approval1 = new OneSpanAPIObjects.Approval();
        approval1.role = 'firstNamelastName';
        approval1.fields = new List<OneSpanAPIObjects.Field> {f1,f2};

        OneSpanAPIObjects.Document doc1 = new OneSpanAPIObjects.Document();
        doc.name = 'testDocumentOne';
        doc.approvals = new List<OneSpanAPIObjects.Approval> {approval1};
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
        OneSpanSDK sdk = new OneSpanSDK();

        // Set up the example attachment requirements
        List<OneSpanAPIObjects.AttachmentRequirement> arList = new List<OneSpanAPIObjects.AttachmentRequirement>();

        OneSpanAPIObjects.AttachmentRequirement ar1 = new OneSpanAPIObjects.AttachmentRequirement();
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
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();
        
        List<OneSpanAPIObjects.AuthChallenge> challenges = new List<OneSpanAPIObjects.AuthChallenge>();
        OneSpanAPIObjects.AuthChallenge challenge = new OneSpanAPIObjects.AuthChallenge();

        challenge.question = question;
        challenge.answer = answer;
        challenge.maskInput = maskInput;

        challenges.add(challenge);

        // Call the SDK method and get the response status code and status string
        String response = sdk.safeSetAuth(packageId, roleId, OneSpanAPIObjects.AuthScheme.CHALLENGE, challenges);

        // Print the response to console
        System.debug('=> Response from safeSetAuthExample: ' + response);
    }

    /**
     * Example method to set the signing order
     */
    public static void setSigningOrderExample(String packageId, String roleId, Integer index)
    {
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();
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
        OneSpanSDK sdk = new OneSpanSDK();
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
        OneSpanSDK sdk = new OneSpanSDK();
        Blob documentBlob = sdk.downloadDocument(packageId,documentId);

        // Print the Base64 Encoded document string to console
        System.debug('=> Response from downloadDocumentExample: ' + EncodingUtil.base64Encode(documentBlob));

        return documentBlob;
    }

    /**
     * Example method to set the package status
     */
    public static void setStatusExample(String packageId, OneSpanAPIObjects.PackageStatus status)
    {
        OneSpanSDK sdk = new OneSpanSDK();
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
        OneSpanSDK sdk = new OneSpanSDK();
        
        OneSpanAPIObjects.Field field1 = new OneSpanAPIObjects.Field();
        field1.left = left;
        field1.top = top;
        field1.width = width;
        field1.height = height;
        field1.type = fieldType;
        field1.subtype = fieldSubType;
        field1.value = null;
        field1.page = page;


        List<OneSpanAPIObjects.Field> fieldList = new List<OneSpanAPIObjects.Field>();
        fieldList.add(field1);

        OneSpanAPIObjects.Approval approval = new OneSpanAPIObjects.Approval();
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
        OneSpanSDK sdk = new OneSpanSDK();
        
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
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();

        // Example that will update the document name and description
        OneSpanAPIObjects.Document doc = new OneSpanAPIObjects.Document();
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
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response  = sdk.deleteDocument(packageId, roleId);

        // Print the response to console
        System.debug('=> Response from deleteRoleExample: ' + response);
        
        return response;
    }

    /**
     * Example method to get an approval
     */
    public static OneSpanAPIObjects.Approval getApprovalExample(String packageId, String documentId, String approvalId)
    {
        OneSpanSDK sdk = new OneSpanSDK();

        // Call the SDK method and get the Approval object as response
        OneSpanAPIObjects.Approval response = sdk.getApproval(packageId, documentId, approvalId);

        // Print the Approval object to console
        System.debug('=> Response from getApprovalExample: ' + response);
        
        return response;
    }

    /**
     * Example method to update an approval
     */
    public static String updateApprovalExample(String packageId, String documentId, String approvalId)
    {
        OneSpanSDK sdk = new OneSpanSDK();
        
        OneSpanAPIObjects.Approval approval = new OneSpanAPIObjects.Approval();
        approval.name = 'New name';
        approval.role = 'New role';
        approval.fields = new List<OneSpanAPIObjects.Field>();

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
        OneSpanSDK sdk = new OneSpanSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.deleteApproval(packageId, documentId, approvalId);

        // Print the response to console
        System.debug('=> Response from deleteApprovalExample: ' + response);
        
        return response;
    }

    /**
     * Example method to get a role
     */
    public static OneSpanAPIObjects.Role getRoleExample(String packageId, String roleId)
    {
        OneSpanSDK sdk = new OneSpanSDK();

        // Call the SDK method and get the Role object as the response
        OneSpanAPIObjects.Role response = sdk.getRole(packageId, roleId);

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
        List<OneSpanAPIObjects.AuthChallenge> challenges = new List<OneSpanAPIObjects.AuthChallenge>();
        
        OneSpanAPIObjects.Delivery delivery = new OneSpanAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;

        OneSpanAPIObjects.Auth auth = new OneSpanAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = OneSpanAPIObjects.AuthScheme.NONE;

        OneSpanAPIObjects.Signer signer = new OneSpanAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = firstName;
        signer.lastName = lastName;
        signer.email = email;
        signer.name = firstName + lastName;

        List<OneSpanAPIObjects.Signer> signers = new List<OneSpanAPIObjects.Signer>();
        signers.add(signer);

        OneSpanAPIObjects.Role role = new OneSpanAPIObjects.Role();
        role.signers = signers;
        role.reassign = reassign;
  
        OneSpanSDK sdk = new OneSpanSDK();

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
        OneSpanSDK sdk = new OneSpanSDK();
        
        OneSpanAPIObjects.Field field1 = new OneSpanAPIObjects.Field();
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
    public static OneSpanAPIObjects.Field getFieldExample(String packageId, String documentId, String approvalId, String fieldId)
    {
        OneSpanSDK sdk = new OneSpanSDK();

        // Call the SDK method and get the Field object as the response
        OneSpanAPIObjects.Field response = sdk.getField(packageId, documentId, approvalId, fieldId);

        // Print the field object to console
        System.debug('=> Response from getFieldExample: ' + response);
        
        return response;
    }

    /**
     * Example method to update a field
     */
    public static String updateFieldExample(String packageId, String documentId, String approvalId, String fieldId)
    {
        OneSpanSDK sdk = new OneSpanSDK();
        
        // Example that will update the document name and role
        OneSpanAPIObjects.Field field1 = new OneSpanAPIObjects.Field();
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
        OneSpanSDK sdk = new OneSpanSDK();

        // Call the SDK method and get the HTTP response status code and status string
        String response = sdk.deleteField(packageId, documentId, approvalId, fieldId);

        // Print the response to console
        System.debug('=> Response from deleteFieldExample: ' + response);
        
        return response;
    }


}
