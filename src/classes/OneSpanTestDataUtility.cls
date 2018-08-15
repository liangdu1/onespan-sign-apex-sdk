/**
 * Class Name: OneSpanTestDataUtility.cls*
 * Utility class used for creating test data for test classes
 */
  
public with sharing class OneSpanTestDataUtility
{ 
    /**
     * Creates a OneSpanAPIObjects.Package_x object
     */
    public static OneSpanAPIObjects.Package_x createPackageX(String id, String name, String consent, List<OneSpanAPIObjects.Document> docList)
    {
        OneSpanAPIObjects.Package_x pack = new OneSpanAPIObjects.Package_x();
        pack.name = name;
        pack.autocomplete = True;
        pack.completed = Date.today();
        pack.consent = consent;
        pack.description = 'this is description';
        pack.emailMessage = 'thi is the email meesage';
        pack.id = id;
        pack.language = 'English';
        pack.documents = docList;
        pack.status = OneSpanAPIObjects.PackageStatus.OPTED_OUT;
        pack.documents = docList;
        return pack;
    }

    /**
     * Creates a OneSpanAPIObjects.Package_x object
     */
    public static OneSpanAPIObjects.Package_x createPackageX(String id, String name, String consent)
    {  
        List<OneSpanAPIObjects.Document> docList = new List<OneSpanAPIObjects.Document>();
        docList.add(createDocument('a1','First Doc',1));
        docList.add(createDocument('a2','Second Doc',2));
        return createPackageX(id,name,consent, docList);
    }

    /**
     * Creates a OneSpanAPIObjects.Approval object
     */
    public static OneSpanAPIObjects.Approval createApproval(String approvalId, String approvalName, String approvalRole)
    {
        OneSpanAPIObjects.Approval approval = new OneSpanAPIObjects.Approval();
        approval.id = approvalId;
        approval.name = approvalName;
        approval.role = approvalRole;
        
        List<OneSpanAPIObjects.Field> fieldsList = new List<OneSpanAPIObjects.Field>();
        OneSpanAPIObjects.Field f = new OneSpanAPIObjects.Field();
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
     * Creates a OneSpanAPIObjects.Rol object
     */
    public static OneSpanAPIObjects.Role createRole(String roleId, String roleName, String roleType)
    {
        OneSpanAPIObjects.Role role = new OneSpanAPIObjects.Role();
        role.id = roleId;
        role.name = roleName;
        role.type = roleType;
        role.index = 1;
        return role;
    }

    /**
     * Creates a OneSpanAPIObjects.Rol object
     */
    public static OneSpanAPIObjects.Role createRole(String roleId, String roleName, String roleType, List<OneSpanAPIObjects.Signer> signersList)
    {
        OneSpanAPIObjects.Role role = new OneSpanAPIObjects.Role();
        role.id = roleId;
        role.name = roleName;
        role.type = roleType;
        role.index = 1;
        role.signers = signersList;
        return role;
    }

    /**
     * Creates a OneSpanAPIObjects.SignedDocumentDelivery object
     */
    public static OneSpanAPIObjects.SignedDocumentDelivery createSignedDocumentDelivery()
    {
        OneSpanAPIObjects.SignedDocumentDelivery sdd = new OneSpanAPIObjects.SignedDocumentDelivery();
        OneSpanAPIObjects.External ext1 = createExternal();
        OneSpanAPIObjects.External ext2 = createExternal();
        List<OneSpanAPIObjects.External> extList = new List<OneSpanAPIObjects.External>();
        extList.add(ext1);
        extList.add(ext2);
        sdd.destinations = extList;
        List<OneSpanAPIObjects.Document> excludedDocuments = new List<OneSpanAPIObjects.Document>();
        excludedDocuments.add(createDocument());
        sdd.filePrefix = 'prefix'; 
        sdd.fileSuffix = 'fileSuffix';
        return sdd;
    }

    /**
     * Creates a OneSpanAPIObjects.Document object
     */
    public static OneSpanAPIObjects.Document createDocument(String docId, String documentName, Integer index)
    {
        OneSpanAPIObjects.Document doc = new OneSpanAPIObjects.Document();
        doc.description = 'description';
        doc.external = createExternal();
        doc.extract = False;
        doc.id = docId;
        doc.name = documentName; 
        doc.index = index;
        doc.size = 120000;
     
        OneSpanAPIObjects.Approval approval1 = createApproval('a1','appr1','role1');
        OneSpanAPIObjects.Approval approval2 = createApproval('a2','appr2','role2');
        List<OneSpanAPIObjects.Approval> approvals = new List<OneSpanAPIObjects.Approval>();
        approvals.add(approval1);
        approvals.add(approval2);
        doc.approvals = approvals;
     
        OneSpanAPIObjects.Page_x pagex1 = createPage_x('pageX1');
        OneSpanAPIObjects.Page_x pagex2 = createPage_x('pageX2');
        List<OneSpanAPIObjects.Page_x> pages = new List<OneSpanAPIObjects.Page_x>();
        pages.add(pagex1);
        pages.add(pagex2);
        doc.pages = pages;
        return doc;
    }

    /**
     * Creates a OneSpanAPIObjects.Document object
     */
    public static OneSpanAPIObjects.Document createDocument()
    {
        return createDocument('docId', 'Document Name', 123);
    }

    /**
     * Creates a List<OneSpanAPIObjects.Document> object
     */
    public static List<OneSpanAPIObjects.Document> createDocumentList()
    {
        List<OneSpanAPIObjects.Document> documentList = new List<OneSpanAPIObjects.Document>();
        documentList.add( createDocument() );
        return documentList;
    }

    /**
     * Creates a OneSpanAPIObjects.External object
     */
    public static OneSpanAPIObjects.External createExternal()
    {
        OneSpanAPIObjects.External ext = new OneSpanAPIObjects.External();
        ext.id = 'extId';
        ext.provider = 'provider';
        ext.providerName = 'providerName';   
        return ext;
    }

    /**
     * Creates a OneSpanAPIObjects.Page_x object
     */
    public static OneSpanAPIObjects.Page_x createPage_x(String id)
    {
        OneSpanAPIObjects.Page_x pageX = new OneSpanAPIObjects.Page_x();
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
     * Creates a OneSpanAPIObjects.Style object
     */
    public static OneSpanAPIObjects.Style createStyle()
    {
        OneSpanAPIObjects.Style obj = new OneSpanAPIObjects.Style();
        obj.backgroundColor = 'black';
        obj.color = 'white';
        return obj;
    }

    /**
     * Create OneSpanAPIObjects.AuthChallenge object
     */
    public static OneSpanAPIObjects.AuthChallenge createAuthChallenge()
    {
        OneSpanAPIObjects.AuthChallenge authChallenge = new OneSpanAPIObjects.AuthChallenge();
        authChallenge.answer = 'Anser';
        authChallenge.maskInput = true;
        authChallenge.question = 'Question';

        return authChallenge;
    }

    /**
     * Creates a OneSpan_Connection_Settings__c object
     */
    public static Document createDocumentObject()
    {
        Document doc = new Document();
        doc.name = 'Test File';
        doc.body = Blob.valueOf('This is the body');
        return doc;
    }

    /**
     * Creates a OneSpan_Connection_Settings__c object
     */
    public static void createConnectionSetting()
    {
        OneSpan_Connection_Settings__c connectionSettings = new OneSpan_Connection_Settings__c();
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