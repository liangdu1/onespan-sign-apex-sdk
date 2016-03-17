public with sharing class TestOneClickFlow 
{
    public TestOneClickFlow() 
    {
        
    }

    public static void testLifeCycle()
    {
        //createPackage without documents
        String packageId = ESignLiveExamples.createPackageExample();

        ESignLiveExamples.createPackageWithDocumentsExample('testpkg',null,null, null, null);
        
        //Get Package
        ESignLiveAPIObjects.Package_x pkg = ESignLiveExamples.getPackageExample(packageId);
        
        //update Package
        pkg.description = 'Update Package';
        ESignLiveExamples.updatePackageExample(pkg,packageId);
        
        //Get Package to check whether the update has worked or not.
        ESignLiveAPIObjects.Package_x pkg1 = ESignLiveExamples.getPackageExample(packageId);
        System.debug('=> pkg1.description:'+pkg1.description);

        //create Roles
        String roleString = ESignLiveExamples.addRoleExample(packageId,'firstname','lastname','karthik+email@hirekadence.com');
        ESignLiveAPIObjects.Role role = (ESignLiveAPIObjects.Role)JSON.deserialize(roleString, ESignLiveAPIObjects.Role.class);
        
        String roleId = role.id;
        System.debug('=> Role Id:'+roleId);

        //create Documents with Blob for the Package created in step 1
        String docString = ESignLiveExamples.createDocumentsExample(packageId);
        
        System.debug('=> docString:'+docString);
        
        List<ESignLiveAPIObjects.Document> docList = (List<ESignLiveAPIObjects.Document>)JSON.deserialize(docString, List<ESignLiveAPIObjects.Document>.class);



        //update Roles

        //Set Signer Attachments
        ESignLiveExamples.setAttachmentRequirementsExample(packageId,roleId,'Driver\'s License', true,'DL');

        //Set Signer Authentication
        ESignLiveExamples.safeSetAuthExample(packageId,roleId,'question','answer',true);

        //create Approvals/Signatures
        String approvalResponse = ESignLiveExamples.addSignatureExample(packageId,roleId,docList[0].id,100.00,50.00,150.00,25.00,'SIGNATURE','FULLNAME',0);
        ESignLiveAPIObjects.Approval approval = (ESignLiveAPIObjects.Approval)JSON.deserialize(approvalResponse, ESignLiveAPIObjects.Approval.class);
        
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','LABEL',0,'{signer.name}');
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','LABEL',0,'{approval.signed}');
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','LABEL',0,'{signer.title}');
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','LABEL',0,'{signer.company}');
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','TEXTFIELD',0,null);
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','CHECKBOX',0,null);
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','LABEL',0,null);
        ESignLiveExamples.addFieldExample(packageId,docList[0].id,approval.id,200.00,50.00,150.00,25.00,'INPUT','CUSTOMFIELD',0,null);

        //create Approvals/Signatures
        //ESignLiveExamples.addSignatureWithAnchorsExample(packageId,roleId,docList[0].id,'SIGNATURE','FULLNAME',null,'testDocumentOne',0,12,75,40,100,150,ESignLiveAPIObjects.AnchorPoint.TOPRIGHT);
        
        //Set Signing Order
        ESignLiveExamples.setSigningOrderExample(packageId,roleId,1);

        ////Change Package Status to SENT
        ESignLiveExamples.setStatusExample(packageId,ESignLiveAPIObjects.PackageStatus.SENT);

        //update Approvals/Signatures or Change Signing Authority ( Delegate )
        ESignLiveExamples.updateSignerExample(packageId,roleId,'TestFN','TestLN','karthik+testfntestln@hirekadence.com', 'optionalMessageToTheAssignee');

        //Get Signing URL
        String signingURL = ESignLiveExamples.getSigningUrlExample(packageId,roleId);
        System.debug('=> signingURL:'+signingURL);


        //Get the signed document
        Blob documentBlob = ESignLiveExamples.downloadDocumentExample(packageId,docList[0].id);
        System.debug('=> documentBlob:'+EncodingUtil.base64Encode(documentBlob));

        //getPackageSigningStatus
        String signingStatus = ESignLiveExamples.getSigningStatusExample(packageId);
        System.debug('=> signingStatus:'+signingStatus);

        //Get Audit Trail
        String auditTrailString = ESignLiveExamples.getAuditExample(packageId);
        System.debug('=> auditTrailString:'+auditTrailString);      



    }
}