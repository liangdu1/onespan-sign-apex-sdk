/**
 * Class Name: ESignLiveSDK
 *
 * Entry methods for eSignLive SDK
 */

public with sharing class ESignLiveSDK
{
    public ESignLiveRESTAPIHelper helper;
    public static final String BOUNDARY = '----WebKitFormBoundary1bNO60n7FqP5WO4t';
    /**
     * Constructor - instantiate helper used throughout class
     */
    public ESignLiveSDK()
    {
        helper = new ESignLiveRESTAPIHelper();
    }

    /**
     * Method Name: safeSetAuth
     * Inputs: Package Id, Role/Signer Id, Authentication Scheme [NONE, CHALLENGE, SMS], Challenges List [Question, Answer and MaskInput]
     * Output: None
     * This method sets the signer/role authentication mechanism to Email(NONE), Q/A(CHALLENGE) and SMS(SMS) 
     * based on the inputs provided.
     */
    public String safeSetAuth(String packageId, String roleId,
                                ESignLiveAPIObjects.AuthScheme scheme,
                                List<ESignLiveAPIObjects.AuthChallenge> challenges)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);
        ESignLiveValidation.validate(scheme);

        if(scheme != ESignLiveAPIObjects.AuthScheme.NONE)
        {
            ESignLiveValidation.validate(challenges);    
        }
        
        String response;

        // Get the Role for the RoleId and validate it
        ESignLiveAPIObjects.Role role = helper.getRole(packageId,roleId);
        
        if(role != null && role.signers != null)
        {
            ESignLiveAPIObjects.Auth auth = new ESignLiveAPIObjects.Auth();   

            auth.scheme = scheme;
            auth.challenges = challenges;
            
            //Set the Auth portion of the Role with the info passed
            role.signers[0].auth = auth;
            response = helper.updateRole(packageId,roleId,role);
        }
        
        return response;
    }

    /**
     * Method Name: getAudit
     * Inputs: Package Id
     * Output: Base64 encoded String
     * This method gets the Evidence Summary of the package. 
     */
    public String getAudit(String packageId)
    {
        ESignLiveValidation.validate('Package Id', packageId);

        String str = helper.getAuditTrail(packageId);
        return str;
    }

    /**
     * Method Name: updateSigner
     * Inputs: Package Id, Role/Signer Id, First Name of the new Signer, 
     *         Last Name of the new Signer, Email of the new Signer, 
     *         Optional Message to the new Signer
     * Output: None
     * This method delegates the signing authority to another signer. 
     * The delegation is only allowed if the current signer has the permission to change the signer.
     * Also, the package must be sent to the signers before this is allowed. 
     */
    public String updateSigner(String packageId,String roleId,String firstname,String lastname,String email,String optionalMessageToTheAssignee)
    {

        ESignLiveValidation.validate('Email', email);
        ESignLiveValidation.validate('First Name', firstname);
        ESignLiveValidation.validate('Last Name', lastname);

        // Get the Role for the RoleId and validate it
        ESignLiveAPIObjects.Role oldSigner = helper.getRole(packageId,roleId);
        String response;

        if(oldSigner != null)
        {
            if(!oldSigner.reassign)
            {
                throw new ESignLiveSDKException('This role is not allowed to change Signer: ' +roleId);
            }

            ESignLiveAPIObjects.Role newSigner = new ESignLiveAPIObjects.Role();
            newSigner.name = firstname + lastname;
            newSigner.index = oldSigner.index;
            newSigner.id = '';
            newSigner.type = 'SIGNER';
            newSigner.reassign = true;
            newSigner.attachmentRequirements = oldSigner.attachmentRequirements;
            newSigner.emailMessage = new ESignLiveAPIObjects.EmailMessage(optionalMessageToTheAssignee);
            newSigner.signers = createRolesSigner(firstname, lastname, email, '', '');
            newSigner.signers[0].name = firstname + lastname;
            newSigner.signers[0].id = '';
            newSigner.signers[0].delivery.download = true;

            response = helper.reassignRole(packageId,roleId,newSigner);
        }
        else
        {
            throw new ESignLiveSDKException('There is no role for the role id: ' + roleId + 'in the package: ' + packageId);
        }

        return response;
    }

    /**
     * Method Name: setAttachmentRequirements
     * Inputs: List<ESignLiveAPIObjects.AttachmentRequirement>, Package Id, Role Id
     * Output: Response String
     * This method sets the attachment requirements for a particular signer. 
     */
    public String setAttachmentRequirements(List<ESignLiveAPIObjects.AttachmentRequirement> 
                                            attachmentRequirements,String packageId,
                                            String roleId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);
        ESignLiveValidation.validate(attachmentRequirements);

        // Get the Role for the RoleId 
        ESignLiveAPIObjects.Role role = helper.getRole(packageId,roleId);

        // add the Attachment Requirements
        for(ESignLiveAPIObjects.AttachmentRequirement ar : attachmentRequirements)
        {
            role.attachmentRequirements.add(ar);
        }

        String response = helper.updateRole(packageId,roleId,role);
        
        return response;    
    }

    /**
     * Method Name: downloadAllAttachmentFilesForSignerInPackage
     * Inputs: Package Id, Role Id
     * Output: Base64 encoded String
     * This method gets the zip file of the attachments for a particular signer. 
     */
    public String downloadAllAttachmentFilesForSignerInPackage(String packageId,String roleId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);

        String response = helper.getSignerAttachments(packageId,roleId);
        return response;
    }

    /**
     * Method Name: createPackage
     * Inputs: Package object
     * Output: Package Id
     * This method creates the package with the information provided. 
     */
    public String createPackage(ESignLiveAPIObjects.Package_x pkg)
    {
        ESignLiveValidation.validate(pkg);

        String response = helper.createPackage(pkg);
        return response;
    }

    /**
     * Method Name: createPackage
     * Inputs: Package object, Document Blob Map
     * Output: Package Id
     * This method creates the package along with the documents with the information provided. 
     */
    public String createPackage(ESignLiveAPIObjects.Package_x pkg, Map<String,Blob> documentBlobMap)
    {
        ESignLiveValidation.validate(pkg);
        ESignLiveValidation.validate(documentBlobMap);

        String response = createPackageWithBinaries(pkg,documentBlobMap);
        return response;
    }

    /**
     * Method Name: getPackage
     * Inputs: Package Id
     * Output: Package Object
     * This method gets the Package object for the Package Id passed.
     */
    public ESignLiveAPIObjects.Package_x getPackage(String packageId)
    {
        ESignLiveValidation.validate('Package Id', packageId);

        ESignLiveAPIObjects.Package_x pkg = helper.getPackage(packageId);
        return pkg;
    }

    /**
     * Method Name: updatePackage
     * Inputs: Package Id, Package Object
     * Output: Response String
     * This method updates the Package for the Package Id and the Package object passed.
     */
    public void updatePackage(ESignLiveAPIObjects.Package_x packageToUpdate, String packageId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate(packageToUpdate);

        helper.updatePackage(packageToUpdate,packageId);
    }

    /**
     * Method Name: createDocuments
     * Inputs: Package Id, Document Blob Map
     * Output: Documents JSON String
     * This method adds the documents in the existing package.
     */
    public String createDocuments(String packageId,ESignLiveAPIObjects.Document document, Map<String,Blob> documentBlobMap)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate(documentBlobMap);

        String response = createDocumentWithBinariesAndFields(packageId,document,documentBlobMap);
        return response;
    }    

    /**
     * Method Name: setSigningOrder
     * Inputs: Package Id, Role Id, Index/Signing order number for the Signer
     * Output: Response String
     * This method sets the signing order for the Role Id passed.
     */
    public String setSigningOrder(String packageId,String roleId,Integer index)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);
        ESignLiveValidation.validate('Role Index/Signing Order', index);

        // Get the Role for the RoleId and validate it
        ESignLiveAPIObjects.Role signer = helper.getRole(packageId,roleId);
        String response;

        if(signer != null)
        {
            signer.index = index;
            response = helper.updateRole(packageId,roleId,signer);
        }
        else
        {
            throw new ESignLiveSDKException('setSigningOrder: There is no role for the role id:'+roleId + ' in the package:'+packageId);
        }

        return response;
    }

    /**
     * Method Name: getSigningStatus
     * Inputs: Package Id
     * Output: Response String
     * This method gets the signing status for the Package Id passed.
     */
    public String getSigningStatus(String packageId)
    {
        ESignLiveValidation.validate('Package Id', packageId);

        String response = helper.getPackageSigningStatus(packageId);
        return response;
    }

    /**
     * Method Name: getSigningUrl
     * Inputs: Package Id, Signer Id
     * Output: Signing URL 
     * This method gets the signing URL for the Package Id and Signer Id passed.
     */
    public String getSigningUrl(String packageId, String signerId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Signer Id', signerId);

        ESignLiveAPIObjects.SigningUrl signingURL = helper.getSigningUrl(packageId,signerId);
        return signingURL.url;
    }

    /**
     * Method Name: downloadDocument
     * Inputs: Package Id, Document Id
     * Output: Document Blob
     * This method gets the Document Blob for the Package Id and Document Id passed.
     */
    public Blob downloadDocument(String packageId,String docId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', docId);

        Blob documentBlob = helper.getSignedDocument(packageId,docId);
        return documentBlob;
    }

    /**
     * Method Name: setStatus
     * Inputs: Package Id, PackageStatus Enumerated Value
     * Output: Response String
     * This method sets the status for the Package Id passed.
     */
    public String setStatus(String packageId, ESignLiveAPIObjects.PackageStatus status)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate(status);

        String response = helper.updatePackageStatus(packageId, status);

        return response;
    }

    /**
     * Method Name: addSignature
     * Inputs: Package Id, Document Id, Approval object
     * Output: Approval String
     * This method adds the Signature for the Package Id, Document Id and Approval passed.
     */
    public String addSignature(String packageId, String documentId,ESignLiveAPIObjects.Approval approval)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate(approval);

        ESignLiveAPIObjects.Approval approvalResponse = helper.createApproval(packageId,documentId,approval);

        return JSON.serialize(approvalResponse);
    }

    /**
     * Method Name: addRole
     * Inputs: FirstName, LastName, Email and Package Id
     * Output: Role object JSON string
     * This method adds the Role with the information provided 
     * in the inputs in the Package specified by the Package Id.
     */
    public String addRole(String firstName, String lastName, String email, String packageId)
    {
        ESignLiveValidation.validate('Email', email);
        ESignLiveValidation.validate('First Name', firstname);
        ESignLiveValidation.validate('Last Name', lastname);
        ESignLiveValidation.validate('Package Id', packageId);

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
        role.reassign = true;
        
        String roleResponse = helper.createRole(packageId,role);

        return roleResponse;
    }
 
    /**
     * Method Name: createPackageWithBinaries
     * Inputs: Package_x object, Document Map
     * Output: Package Id
     * This method is a private method which is called from the createPackage method
     * to create the package with the document blobs.
     */
    private String createPackageWithBinaries(ESignLiveAPIObjects.Package_x pkg, Map<String,Blob> documentMap)
    {
        // Check if the documents in the Package (if any provided) match with the documents in the documentMap
        String compResult ='success';

        if(pkg.documents != null)
        {
            compResult = ESignLiveValidation.comparePackageDocumentsAndMap(pkg,documentMap);    
        }
        
        if(compResult.equals('success'))
        {
            Blob multipartFormData;

            String secondHeader = '--' + BOUNDARY + '\nContent-Disposition: form-data; name="payload"';

            String footer = '--' + BOUNDARY + '--';             

            String secondHeaderEncoded = ESignLiveDocumentUtilities.encodeString(secondHeader);

            List<String> encodedStrings = ESignLiveDocumentUtilities.encodeDocuments(documentMap,BOUNDARY,'file');

            String fileNamesJSON = '';

            for(String fileName : documentMap.keySet())
            {              
                fileNamesJSON = fileNamesJSON +'{ "name":"'+fileName+'" }' + ',';
            }
            
            String headerPlusBodyEncoded = encodedStrings[0];
            String footerEncoded = encodedStrings[1];

            String packageContent = '';
            if(pkg.documents == null)
            {
                packageContent = '{ "documents":['+fileNamesJSON.substring(0,fileNamesJSON.length()-1)+'] }';
                ESignLiveAPIObjects.Package_x tempPkg = (ESignLiveAPIObjects.Package_x)JSON.deserialize(packageContent, ESignLiveAPIObjects.Package_x.class);
                pkg.documents = tempPkg.documents;
            }

            pkg.data = null;
            packageContent = JSON.serialize(pkg);
            packageContent = ESignLiveJSONHelper.prepareOutboundJSON(packageContent);

            String packageContentEncoded = ESignLiveDocumentUtilities.encodeContent(packageContent);

            multipartFormData = EncodingUtil.base64Decode(headerPlusBodyEncoded+secondHeaderEncoded+packageContentEncoded+footerEncoded);

            String packageId = helper.createPackageWithBinaries(multipartFormData);
            return packageId;
        }

        return null;
    }

    /*
     * Method Name: createDocumentWithBinariesAndFields
     * Inputs: Package Id, ESignLiveAPIObjects.Document document, Document Map
     * Output: Document Response string
     * This method is a private method which is called from the createDocument method
     * to create the documents within an existing package.
     */
    private String createDocumentWithBinariesAndFields(String packageId, ESignLiveAPIObjects.Document document, Map<String,Blob> documentMap)
    {
        Blob multipartFormData;

        String secondHeader = '--' + BOUNDARY + '\nContent-Disposition: form-data; name="payload"';

        String footer = '--' + BOUNDARY + '--';             

        String secondHeaderEncoded = ESignLiveDocumentUtilities.encodeString(secondHeader);

        List<String> encodedStrings = ESignLiveDocumentUtilities.encodeDocuments(documentMap,BOUNDARY,'file');

        String fileNamesJSON = '';

        for(String fileName : documentMap.keySet())
        {              
            fileNamesJSON = fileNamesJSON +'{ "name":"'+fileName+'" }' + ',';
        }
        
        String headerPlusBodyEncoded = encodedStrings[0];
        String footerEncoded = encodedStrings[1];
        
        String documentJSON = JSON.serialize(document);
        documentJSON = ESignLiveJSONHelper.prepareOutboundJSON(documentJSON);        

        String documentJSONEncoded = ESignLiveDocumentUtilities.encodeContent(documentJSON);

        multipartFormData = EncodingUtil.base64Decode(headerPlusBodyEncoded+secondHeaderEncoded+documentJSONEncoded+footerEncoded);

        String packageIdResponse = helper.createDocumentsWithBinaries(packageId, multipartFormData);
        return packageIdResponse;
    }

    /**
     * Method Name: createRolesSigner
     * Inputs: FirstName, LastName, Email, Title, Company
     * Output: List of Signer objects
     * This method builds the signer
     */
    public List<ESignLiveAPIObjects.Signer> createRolesSigner(String firstName, String lastName, String email, String title, String company)
    {
        // Create request
        List<ESignLiveAPIObjects.AuthChallenge> challenges = new List<ESignLiveAPIObjects.AuthChallenge>();
        
        ESignLiveAPIObjects.Delivery delivery = new ESignLiveAPIObjects.Delivery();
        delivery.email = true;
        delivery.provider = true;
        delivery.download = true;

        ESignLiveAPIObjects.Auth auth = new ESignLiveAPIObjects.Auth();
        auth.challenges = challenges;
        auth.scheme = ESignLiveAPIObjects.AuthScheme.NONE;

        ESignLiveAPIObjects.Signer signer = new ESignLiveAPIObjects.Signer();
        signer.auth = auth;
        signer.delivery = delivery;
        signer.firstName = firstName;
        signer.lastName = lastName;
        signer.email = email;
        signer.name = firstName+lastName;
        signer.company = company;
        signer.title= title;

        List<ESignLiveAPIObjects.Signer> signers = new List<ESignLiveAPIObjects.Signer>();
        signers.add(signer);
        return signers;
    }

    /**
     * Method Name: deletePackage
     * Inputs: Package Id of the Package which needs to be deleted
     * Output: Response String
     * This method deletes the Package specified by the Package Id.
     */
    public String  deletePackage(String packageId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        return helper.deletePackage(packageId);
    }

    /**
     * Method Name: updateDocument
     * Inputs: Package Id, Document Id and Document object.
     * Output: Response String
     * This method updates the Document specified by the Package Id and the Document Id.
     */
    public String updateDocument(String packageId, String documentId, ESignLiveAPIObjects.Document doc)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        return helper.updateDocument(packageId, documentId, doc);
    }

    /**
     * Method Name: deleteDocument
     * Inputs: Package Id, Document Id of the document which needs to be deleted
     * Output: Response String
     * This method deletes the Document specified by the Document Id in the Package specified by the Package Id.
     */
    public String deleteDocument(String packageId, String documentId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        return helper.deleteDocument(packageId, documentId);
    } 

    /**
     * Method Name: deleteRole
     * Inputs: Package Id, Role Id of the Role which needs to be deleted
     * Output: Response String
     * This method deletes the Role specified by the Role Id in the Package specified by the Package Id.
     */
    public String deleteRole(String packageId, String roleId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);
        return helper.deleteDocument(packageId, roleId);
    }

    /**
     * Method Name: getApproval
     * Inputs: Package Id, Document Id, Approval Id of the Approval 
     * Output: Approval Response String
     * This method gets the Approval specified by the Approval Id on the Document 
     * identified by the Document Id in the Package specified by the Package Id.
     */
    public ESignLiveAPIObjects.Approval getApproval(String packageId, String documentId, String approvalId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        return helper.getApproval(packageId, documentId, approvalId);
    }

    /**
     * Method Name: updateApproval
     * Inputs: Package Id, Document Id, Approval Id of the Approval and the Approval object.
     * Output: Response String
     * This method updates the Approval specified by the Approval Id on the Document 
     * identified by the Document Id in the Package specified by the Package Id.
     */
    public String updateApproval(String packageId, String documentId, String approvalId, ESignLiveAPIObjects.Approval approval)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        ESignLiveValidation.validate(approval);
        return helper.updateApproval(packageId, documentId, approvalId, approval);
    }

    /**
     * Method Name: deleteApproval
     * Inputs: Package Id, Document Id, Approval Id of the Approval to be deleted.
     * Output: Response String
     * This method deletes the Approval specified by the Approval Id on the Document 
     * identified by the Document Id in the Package specified by the Package Id.
     */
    public String deleteApproval(String packageId, String documentId, String approvalId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        return helper.deleteApproval(packageId, documentId, approvalId);
    }

    /**
     * Method Name: getRole
     * Inputs: Package Id, Role Id of the Role 
     * Output: Approval Response String
     * This method gets the Role specified by the Role Id in the Package specified by the Package Id.
     */
    public ESignLiveAPIObjects.Role getRole(String packageId, String roleId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);
        return helper.getRole(packageId, roleId);
    }

    /**
     * Method Name: updateRole
     * Inputs: Package Id, Role Id of the Role and the Role object.
     * Output: Response String
     * This method updates the Role specified by the Role Id in the Package specified by the Package Id.
     */
    public String updateRole(String packageId, String roleId, ESignLiveAPIObjects.Role role)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Role Id', roleId);
        
        String roleResponse = helper.updateRole(packageId,roleId,role);

        return roleResponse;
    }

    /**
     * Method Name: addField
     * Inputs: Package Id, Document Id, Approval Id and the Field object
     * Output: Field JSON Response String
     * This method adds the Role for the Package Id passed.
     */
    public String addField(String packageId, String documentId, String approvalId, ESignLiveAPIObjects.Field fieldToCreate)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        ESignLiveValidation.validate(fieldToCreate);

        // Create request
       
        String fieldResponse = helper.createField(packageId,documentId,approvalId,fieldToCreate);

        return fieldResponse;
    }

    /**
     * Method Name: getField
     * Inputs:  Package Id, Document Id, Approval Id and the Field Id to get.
     * Output: Field Response String
     * This method gets the Field specified by the inputs.
     */
    public ESignLiveAPIObjects.Field getField(String packageId, String documentId, String approvalId, String fieldId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        ESignLiveValidation.validate('Field Id', fieldId);

        return helper.getField(packageId, documentId, approvalId, fieldId);
    }

    /**
     * Method Name: updateField
     * Inputs:  Package Id, Document Id, Approval Id, Field Id to update and the Field object .
     * Output: Field Response String
     * This method updates the Field specified by the inputs.
     */
    public String updateField(String packageId, String documentId, String approvalId, String fieldId, ESignLiveAPIObjects.Field fieldToUpdate)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        ESignLiveValidation.validate(fieldToUpdate);

        return helper.updateField(packageId, documentId, approvalId, fieldId, fieldToUpdate);
    }

    /**
     * Method Name: deleteField
     * Inputs:  Package Id, Document Id, Approval Id, Field Id to delete.
     * Output: Response String
     * This method deletes the Field specified by the inputs.
     */
    public String deleteField(String packageId, String documentId, String approvalId, String fieldId)
    {
        ESignLiveValidation.validate('Package Id', packageId);
        ESignLiveValidation.validate('Document Id', documentId);
        ESignLiveValidation.validate('Approval Id', approvalId);
        ESignLiveValidation.validate('Field Id', fieldId);

        return helper.deleteField(packageId, documentId, approvalId, fieldId);
    }

    /*
    *   SDK Specific Exception class 
    */
    public class ESignLiveSDKException extends Exception{}
}
