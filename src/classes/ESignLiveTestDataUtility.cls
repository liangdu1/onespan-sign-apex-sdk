/**
 * Class Name: ESignLiveTestDataUtility.cls
 *
 * Utility class used for creating test data for test classes
 */
  
public with sharing class ESignLiveTestDataUtility
{ 
    /**
     * Creates a ESignLiveAPIObjects.Package_x object
     */
    public static ESignLiveAPIObjects.Package_x createPackageX(String id, String name, String consent, List<ESignLiveAPIObjects.Document> docList)
    {
        ESignLiveAPIObjects.Package_x pack = new ESignLiveAPIObjects.Package_x();
        pack.name = name;
        pack.autocomplete = True;
        pack.completed = Date.today();
        pack.consent = consent;
        pack.description = 'this is description';
        pack.emailMessage = 'thi is the email meesage';
        pack.id = id;
        pack.language = 'English';
        pack.documents = docList;
        pack.status = ESignLiveAPIObjects.PackageStatus.OPTED_OUT;
        pack.documents = docList;
        return pack;
    }

    /**
     * Creates a ESignLiveAPIObjects.Package_x object
     */
    public static ESignLiveAPIObjects.Package_x createPackageX(String id, String name, String consent)
    {  
        List<ESignLiveAPIObjects.Document> docList = new List<ESignLiveAPIObjects.Document>();
        docList.add(createDocument('a1','First Doc',1));
        docList.add(createDocument('a2','Second Doc',2));
        return createPackageX(id,name,consent, docList);
    }

    /**
     * Creates a ESignLiveAPIObjects.Approval object
     */
    public static ESignLiveAPIObjects.Approval createApproval(String approvalId, String approvalName, String approvalRole)
    {
        ESignLiveAPIObjects.Approval approval = new ESignLiveAPIObjects.Approval();
        approval.id = approvalId;
        approval.name = approvalName;
        approval.role = approvalRole;
        
        List<ESignLiveAPIObjects.Field> fieldsList = new List<ESignLiveAPIObjects.Field>();
        ESignLiveAPIObjects.Field f = new ESignLiveAPIObjects.Field();
        f.width = 10;
        f.type = 'type';
        f.top = 100;
        f.subtype = 'subType';
        f.page = 1;
        f.left = 1;
        f.height = 10;
        fieldsList.add(f);
        approval.fields = fieldsList; 
        return approval;
    }

    /**
     * Creates a ESignLiveAPIObjects.Rol object
     */
    public static ESignLiveAPIObjects.Role createRole(String roleId, String roleName, String roleType)
    {
        ESignLiveAPIObjects.Role role = new ESignLiveAPIObjects.Role();
        role.id = roleId;
        role.name = roleName;
        role.type = roleType;
        role.index = 1;
        return role;
    }

    /**
     * Creates a ESignLiveAPIObjects.Rol object
     */
    public static ESignLiveAPIObjects.Role createRole(String roleId, String roleName, String roleType, List<ESignLiveAPIObjects.Signer> signersList)
    {
        ESignLiveAPIObjects.Role role = new ESignLiveAPIObjects.Role();
        role.id = roleId;
        role.name = roleName;
        role.type = roleType;
        role.index = 1;
        role.signers = signersList;
        return role;
    }

    /**
     * Creates a ESignLiveAPIObjects.SignedDocumentDelivery object
     */
    public static ESignLiveAPIObjects.SignedDocumentDelivery createSignedDocumentDelivery()
    {
        ESignLiveAPIObjects.SignedDocumentDelivery sdd = new ESignLiveAPIObjects.SignedDocumentDelivery();
        ESignLiveAPIObjects.External ext1 = createExternal();
        ESignLiveAPIObjects.External ext2 = createExternal();
        List<ESignLiveAPIObjects.External> extList = new List<ESignLiveAPIObjects.External>();
        extList.add(ext1);
        extList.add(ext2);
        sdd.destinations = extList;
        List<ESignLiveAPIObjects.Document> excludedDocuments = new List<ESignLiveAPIObjects.Document>();
        excludedDocuments.add(createDocument());
        sdd.filePrefix = 'prefix'; 
        sdd.fileSuffix = 'fileSuffix';
        return sdd;
    }

    /**
     * Creates a ESignLiveAPIObjects.Document object
     */
    public static ESignLiveAPIObjects.Document createDocument(String docId, String documentName, Integer index)
    {
        ESignLiveAPIObjects.Document doc = new ESignLiveAPIObjects.Document();
        doc.description = 'description';
        doc.external = createExternal();
        doc.extract = False;
        doc.id = docId;
        doc.name = documentName; 
        doc.index = index;
        doc.size = 120000;
     
        ESignLiveAPIObjects.Approval approval1 = createApproval('a1','appr1','role1');
        ESignLiveAPIObjects.Approval approval2 = createApproval('a2','appr2','role2');
        List<ESignLiveAPIObjects.Approval> approvals = new List<ESignLiveAPIObjects.Approval>();
        approvals.add(approval1);
        approvals.add(approval2);
        doc.approvals = approvals;
     
        ESignLiveAPIObjects.Page_x pagex1 = createPage_x('pageX1');
        ESignLiveAPIObjects.Page_x pagex2 = createPage_x('pageX2');
        List<ESignLiveAPIObjects.Page_x> pages = new List<ESignLiveAPIObjects.Page_x>();
        pages.add(pagex1);
        pages.add(pagex2);
        doc.pages = pages;
        return doc;
    }

    /**
     * Creates a ESignLiveAPIObjects.Document object
     */
    public static ESignLiveAPIObjects.Document createDocument()
    {
        return createDocument('docId', 'Document Name', 123);
    }

    /**
     * Creates a List<ESignLiveAPIObjects.Document> object
     */
    public static List<ESignLiveAPIObjects.Document> createDocumentList()
    {
        List<ESignLiveAPIObjects.Document> documentList = new List<ESignLiveAPIObjects.Document>();
        documentList.add( createDocument() );
        return documentList;
    }

    /**
     * Creates a ESignLiveAPIObjects.External object
     */
    public static ESignLiveAPIObjects.External createExternal()
    {
        ESignLiveAPIObjects.External ext = new ESignLiveAPIObjects.External();
        ext.id = 'extId';
        ext.provider = 'provider';
        ext.providerName = 'providerName';   
        return ext;
    }

    /**
     * Creates a ESignLiveAPIObjects.Page_x object
     */
    public static ESignLiveAPIObjects.Page_x createPage_x(String id)
    {
        ESignLiveAPIObjects.Page_x pageX = new ESignLiveAPIObjects.Page_x();
        pageX.height = 100;
        pageX.id = id;
        pageX.index = 100;
        pageX.left = 100;
        pageX.top = 100;
        pageX.version = 1;
        pageX.width = 100;
        return pageX;
    }

    /**
     * Creates a ESignLiveAPIObjects.Style object
     */
    public static ESignLiveAPIObjects.Style createStyle()
    {
        ESignLiveAPIObjects.Style obj = new ESignLiveAPIObjects.Style();
        obj.backgroundColor = 'black';
        obj.color = 'white';
        return obj;
    }

    /**
     * Create ESignLiveAPIObjects.AuthChallenge object
     */
    public static ESignLiveAPIObjects.AuthChallenge createAuthChallenge()
    {
        ESignLiveAPIObjects.AuthChallenge authChallenge = new ESignLiveAPIObjects.AuthChallenge();
        authChallenge.answer = 'Anser';
        authChallenge.maskInput = true;
        authChallenge.question = 'Question';

        return authChallenge;
    }

    /**
     * Creates a e_SignLive_Connection_Settings__c object
     */
    public static Document createDocumentObject()
    {
        Document doc = new Document();
        doc.name = 'Test File';
        doc.body = Blob.valueOf('This is the body');
        return doc;
    }

    /**
     * Creates a e_SignLive_Connection_Settings__c object
     */
    public static void createConnectionSetting()
    {
        e_SignLive_Connection_Settings__c connectionSettings = new e_SignLive_Connection_Settings__c();
        connectionSettings.Name = 'Main';
        connectionSettings.Endpoint__c= 'http//www.test.com';
        connectionSettings.API_Key__c = 'ABC123';
        insert connectionSettings;
    }

    /**
     * Creates a Map<String,Blob> object
     */
    public static Map<String,Blob> createDocumentMap()
    {
        Map<String,Blob> documentMap = new Map<String,Blob>();
        Blob firstBlob = Blob.valueOf('firstBlob');
        Blob secondBlob = Blob.valueOf('secondBlob');
        documentMap.put('First Doc', firstBlob);
        documentMap.put('Second Doc', secondBlob);
        return documentMap;
    }   
}