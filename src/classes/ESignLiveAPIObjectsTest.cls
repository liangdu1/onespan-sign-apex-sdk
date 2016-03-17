/**
 * Class Name: ESignLiveAPIObjectsTest.cls
 *
 * This class is a test class for the ESignLiveAPIObjects class and
 * contains test methods for testing enumerated values, for instantiating classes using empty
 * constructors, and one for instantiating classes using arguments
 */

@isTest
public class ESignLiveAPIObjectsTest 
{
    /**
     * Method to test the enumerated values
     */
    private static testMethod void testEnumeratedValues()
    {
        ESignLiveAPIObjects.MessageStatus newMessageStatus = ESignLiveAPIObjects.MessageStatus.NEW_X;
        ESignLiveAPIObjects.AnchorPoint newAnchorPoint = ESignLiveAPIObjects.AnchorPoint.TOPLEFT;
        ESignLiveAPIObjects.AuthScheme newAuthScheme = ESignLiveAPIObjects.AuthScheme.NONE;
        ESignLiveAPIObjects.MemberType newMemberType = ESignLiveAPIObjects.MemberType.REGULAR;
        ESignLiveAPIObjects.SenderStatus newSenderStatus = ESignLiveAPIObjects.SenderStatus.INVITED;
        ESignLiveAPIObjects.SenderType newSenderType = ESignLiveAPIObjects.SenderType.REGULAR;
        ESignLiveAPIObjects.PackageStatus newPackageStatus = ESignLiveAPIObjects.PackageStatus.DRAFT;
        ESignLiveAPIObjects.PackageType newPackageType = ESignLiveAPIObjects.PackageType.PACKAGE_X;
    } 

    /**
     * Method to test instantiating classes using empty constructors
     */
    private static testMethod void testEmptyConstructors()
    {
        ESignLiveAPIObjects newAPIObjects = new ESignLiveAPIObjects();
        ESignLiveAPIObjects.Package_x newPackage = new ESignLiveAPIObjects.Package_x();
        ESignLiveAPIObjects.Approval newApproval = new ESignLiveAPIObjects.Approval();
        ESignLiveAPIObjects.AttachmentRequirement newAttachmentRequirement = new ESignLiveAPIObjects.AttachmentRequirement();
        ESignLiveAPIObjects.Auth newAuth = new ESignLiveAPIObjects.Auth();
        ESignLiveAPIObjects.Authentication newAuthentication = new ESignLiveAPIObjects.Authentication();
        ESignLiveAPIObjects.CeremonyEventComplete newCeremonyEventComplete = new ESignLiveAPIObjects.CeremonyEventComplete();
        ESignLiveAPIObjects.CeremonyEvents newCeremonyEvents = new ESignLiveAPIObjects.CeremonyEvents();        
        ESignLiveAPIObjects.CeremonySettings newCeremonySettings = new ESignLiveAPIObjects.CeremonySettings();
        ESignLiveAPIObjects.AuthChallenge newAuthChallenge = new ESignLiveAPIObjects.AuthChallenge();
        ESignLiveAPIObjects.Delivery newDelivery = new  ESignLiveAPIObjects.Delivery();
        ESignLiveAPIObjects.Address newAddress = new ESignLiveAPIObjects.Address();
        ESignLiveAPIObjects.BrandingBarOptions newBrandingBarOptions = new ESignLiveAPIObjects.BrandingBarOptions();
        ESignLiveAPIObjects.DocumentToolbarOptions newDocumentToolBarOptions = new ESignLiveAPIObjects.DocumentToolbarOptions();
        ESignLiveAPIObjects.Document newDocument = new ESignLiveAPIObjects.Document();
        ESignLiveAPIObjects.External newExternal = new ESignLiveAPIObjects.External();
        ESignLiveAPIObjects.ExtractAnchor newExtractAnchor = new ESignLiveAPIObjects.ExtractAnchor();
        ESignLiveAPIObjects.Field newField = new ESignLiveAPIObjects.Field();
        ESignLiveAPIObjects.FieldValidation newFieldValidation = new ESignLiveAPIObjects.FieldValidation();
        ESignLiveAPIObjects.FooterOptions newFooterOptions = new ESignLiveAPIObjects.FooterOptions();
        ESignLiveAPIObjects.GlobalActionsOptions newGLobalActionOptions = new ESignLiveAPIObjects.GlobalActionsOptions();
        ESignLiveAPIObjects.GroupMembership newGroupMembership = new ESignLiveAPIObjects.GroupMembership();
        ESignLiveAPIObjects.Image newImage = new ESignLiveAPIObjects.Image();
        ESignLiveAPIObjects.LayoutStyle newLayoutStyle = new ESignLiveAPIObjects.LayoutStyle();
        ESignLiveAPIObjects.LayoutOptions newLayoutOptions = new ESignLiveAPIObjects.LayoutOptions();
        ESignLiveAPIObjects.Link newLink = new ESignLiveAPIObjects.Link();
        ESignLiveAPIObjects.Message newMessage = new ESignLiveAPIObjects.Message();
        ESignLiveAPIObjects.PackageArtifactsLimits newPackageArtifactsLimits = new ESignLiveAPIObjects.PackageArtifactsLimits();
        ESignLiveAPIObjects.Page_x newPage = new ESignLiveAPIObjects.Page_x();
        ESignLiveAPIObjects.Role newRole = new ESignLiveAPIObjects.Role();
        ESignLiveAPIObjects.SignatureStyle newSignatureStyle = new ESignLiveAPIObjects.SignatureStyle();
        ESignLiveAPIObjects.SigningUrl newSigningUrl = new ESignLiveAPIObjects.SigningUrl();
        ESignLiveAPIObjects.Sender newSender = new ESignLiveAPIObjects.Sender();
        ESignLiveAPIObjects.Settings newSettings = new ESignLiveAPIObjects.Settings();
        ESignLiveAPIObjects.SignedDocumentDelivery newSignedDocumentDelivery = new ESignLiveAPIObjects.SignedDocumentDelivery();
        ESignLiveAPIObjects.Signer newSigner = new ESignLiveAPIObjects.Signer();
        ESignLiveAPIObjects.Style newStyle = new ESignLiveAPIObjects.Style();
        ESignLiveAPIObjects.TextualSignatureStyle newTextualSignatureStyle = new ESignLiveAPIObjects.TextualSignatureStyle();
        ESignLiveAPIObjects.TitleBarOptions newTitleBarOptions = new ESignLiveAPIObjects.TitleBarOptions();
        ESignLiveAPIObjects.User newUser = new ESignLiveAPIObjects.User();
        ESignLiveAPIObjects.EmailMessage newEmailMessage = new ESignLiveAPIObjects.EmailMessage();
        ESignLiveAPIObjects.HeaderOptions newHeaderOptions = new ESignLiveAPIObjects.HeaderOptions();        
        ESignLiveAPIObjects.CurrentSignerProgress newCurrentSignerProgress = new ESignLiveAPIObjects.CurrentSignerProgress();
        ESignLiveAPIObjects.OverallProgress newOverallProgress = new ESignLiveAPIObjects.OverallProgress();
    }  

    /**
     * Method to test instantiating classes using arguments
     */
    private static testMethod void testConstructorsWithArguments()
    {
        ESignLiveAPIObjects.Approval newApproval = new ESignLiveAPIObjects.Approval(System.Now(), '', new List<ESignLiveAPIObjects.Field>(), 'Id', 'Name', 'Role', System.Now());
        ESignLiveAPIObjects.AttachmentRequirement newAttachmentRequirement = new ESignLiveAPIObjects.AttachmentRequirement('', 'Description', 'Id', 'Name', true, 'Comment', 'Status');
        ESignLiveAPIObjects.Auth newAuth = new ESignLiveAPIObjects.Auth(new List<ESignLiveAPIObjects.AuthChallenge>(), ESignLiveAPIObjects.AuthScheme.NONE);
        ESignLiveAPIObjects.Authentication newAuthentication = new ESignLiveAPIObjects.Authentication('Value');
        ESignLiveAPIObjects.CeremonyEventComplete newCeremonyEventComplete = new ESignLiveAPIObjects.CeremonyEventComplete(true, 'Redirect');
        ESignLiveAPIObjects.CeremonyEvents newCeremonyEvents = new ESignLiveAPIObjects.CeremonyEvents(new ESignLiveAPIObjects.CeremonyEventComplete());
        ESignLiveAPIObjects.CeremonySettings newCeremonySettings = new ESignLiveAPIObjects.CeremonySettings(true, new ESignLiveAPIObjects.DocumentToolbarOptions(), new ESignLiveAPIObjects.CeremonyEvents(), new ESignLiveAPIObjects.Link(), true, true, true, new ESignLiveAPIObjects.LayoutOptions(), 0, true, new List<String>(), new ESignLiveAPIObjects.LayoutStyle());
        ESignLiveAPIObjects.AuthChallenge newAuthChallenge = new ESignLiveAPIObjects.AuthChallenge('Answer', true, 'Question');
        ESignLiveAPIObjects.Delivery newDelivery = new  ESignLiveAPIObjects.Delivery(true, true, true);
        ESignLiveAPIObjects.Address newAddress = new ESignLiveAPIObjects.Address('123 Maple St', '', 'Houston','USA', 'Texas', '77347');
        ESignLiveAPIObjects.AttachmentBin newAttachmentBin = new ESignLiveAPIObjects.AttachmentBin('attachmentId', '', 'Id', System.now(), 'Name');
        ESignLiveAPIObjects.BrandingBarOptions newBrandingBarOptions = new ESignLiveAPIObjects.BrandingBarOptions(new ESignLiveAPIObjects.Image());
        ESignLiveAPIObjects.DocumentToolbarOptions newDocumentToolbarOptions = new ESignLiveAPIObjects.DocumentToolbarOptions(true);
        ESignLiveAPIObjects.Document newDocument = new ESignLiveAPIObjects.Document(new List<ESignLiveAPIObjects.Approval>(), 'data', 'description', new ESignLiveAPIObjects.External(), new List<ESignLiveAPIObjects.Field>(), 'id', 1, 'name',new List<ESignLiveAPIObjects.Page_x>(), 10);
        ESignLiveAPIObjects.EmailMessage newEmailMessage = new ESignLiveAPIObjects.EmailMessage('content');
        ESignLiveAPIObjects.External newExternal = new ESignLiveAPIObjects.External('data', 'id', 'provider', 'providerName');
        ESignLiveAPIObjects.ExtractAnchor newExtractAnchor = new ESignLiveAPIObjects.ExtractAnchor(ESignLiveAPIObjects.AnchorPoint.TOPLEFT, 1, 1, 1, 1, 'text', 1, 1);
        ESignLiveAPIObjects.Field newField = new ESignLiveAPIObjects.Field('data', true, new ESignLiveAPIObjects.ExtractAnchor(), 0.1, 'id', 0.1, 'name', 1, 'subtype', 0.1, 'type', new ESignLiveAPIObjects.FieldValidation(), 'value', 0.1,null);
        ESignLiveAPIObjects.FieldValidation newFieldValidation = new ESignLiveAPIObjects.FieldValidation(new List<String>(), 1, 'errorMessage', 1, 1, 'pattern', true);
        ESignLiveAPIObjects.GlobalActionsOptions newGLobalActionOptions = new ESignLiveAPIObjects.GlobalActionsOptions(true, true, true);
        ESignLiveAPIObjects.GroupMembership newGroupMembership = new ESignLiveAPIObjects.GroupMembership('groupId', 'groupName', ESignLiveAPIObjects.MemberType.REGULAR);
        ESignLiveAPIObjects.HeaderOptions newHeaderOptions = new ESignLiveAPIObjects.HeaderOptions(true, true, new ESignLiveAPIObjects.GlobalActionsOptions(), true, true, new ESignLiveAPIObjects.TitleBarOptions());
        ESignLiveAPIObjects.Image newImage = new ESignLiveAPIObjects.Image('link', 'src');
        ESignLiveAPIObjects.LayoutStyle newLayoutStyle = new ESignLiveAPIObjects.LayoutStyle(new ESignLiveAPIObjects.Image(), new ESignLiveAPIObjects.Style(), new ESignLiveAPIObjects.Style(), new ESignLiveAPIObjects.Style());
        ESignLiveAPIObjects.LayoutOptions newLayoutOptions = new ESignLiveAPIObjects.LayoutOptions(new ESignLiveAPIObjects.BrandingBarOptions(), new ESignLiveAPIObjects.FooterOptions(), new ESignLiveAPIObjects.HeaderOptions(), true, true);
        ESignLiveAPIObjects.Link newLink = new ESignLiveAPIObjects.Link('href', 'text', 'title');
        ESignLiveAPIObjects.Package_x newPackage = new ESignLiveAPIObjects.Package_x(true, DateTime.now(), 'consent', 'description', new List<ESignLiveAPIObjects.Document>(), DateTime.now(), 'emailMessage', 'id', 'language', new ESignLiveAPIObjects.PackageArtifactsLimits(), new List<ESignLiveAPIObjects.Message>(), 'name', new List<ESignLiveAPIObjects.Role>(), new ESignLiveAPIObjects.Sender(), new ESignLiveAPIObjects.Settings(), new ESignLiveAPIObjects.SignedDocumentDelivery(), ESignLiveAPIObjects.PackageStatus.DRAFT, true, ESignLiveAPIObjects.PackageType.TEMPLATE, DateTime.now());
        ESignLiveAPIObjects.PackageArtifactsLimits newPackageArtifactsLimits = new ESignLiveAPIObjects.PackageArtifactsLimits(1, 1);
        ESignLiveAPIObjects.Page_x newPage = new ESignLiveAPIObjects.Page_x(0.1, 'id', 1, 0.1, 0.1, 1, 0.1);
        ESignLiveAPIObjects.Role newRole = new ESignLiveAPIObjects.Role(new List<ESignLiveAPIObjects.AttachmentRequirement>(), 'data', new ESignLiveAPIObjects.EmailMessage(), 'id', 1, true, 'name', true, new List<ESignLiveAPIObjects.Signer>(), 'type');
        ESignLiveAPIObjects.SignatureStyle newSignatureStyle = new ESignLiveAPIObjects.SignatureStyle('handdrawn', new ESignLiveAPIObjects.TextualSignatureStyle());
        ESignLiveAPIObjects.SigningUrl newSigningUrl = new ESignLiveAPIObjects.SigningUrl('roleId', 'url', 'packageId');
        ESignLiveAPIObjects.Sender newSender = new ESignLiveAPIObjects.Sender(DateTime.now(), new ESignLiveAPIObjects.Address(), 'company', DateTime.now(), 'email', new ESignLiveAPIObjects.External(), 'firsName', 'id', 'language', 'lastName', DateTime.now(), new List<ESignLiveAPIObjects.GroupMembership>(), 'name', 'phone', new ESignLiveAPIObjects.SignatureStyle(), ESignLiveAPIObjects.SenderStatus.LOCKED, ESignLiveAPIObjects.SenderType.MANAGER, 'title', DateTime.now());        
        ESignLiveAPIObjects.CurrentSignerProgress newCurrentSignerProgress = new ESignLiveAPIObjects.CurrentSignerProgress(1, 1, 1, 1, 1, 1);
        ESignLiveAPIObjects.OverallProgress newOverallProgress = new ESignLiveAPIObjects.OverallProgress(1, 1, 1, 1, 1);
        ESignLiveAPIObjects.SignedDocumentDelivery newSignedDocumntDelivery = new ESignLiveAPIObjects.SignedDocumentDelivery(new List<ESignLiveAPIObjects.External>(), new List<ESignLiveAPIObjects.Document>(), 'filePrefix', 'fileSuffix');
        ESignLiveAPIObjects.Signer newSigner = new ESignLiveAPIObjects.Signer(new ESignLiveAPIObjects.Address(), new ESignLiveAPIObjects.Auth(), 'company', 'data', new ESignLiveAPIObjects.Delivery(), 'email', new ESignLiveAPIObjects.External(), 'firsName', new Group(), 'id', 'language', 'lastName', 'name','phone', new ESignLiveAPIObjects.SignatureStyle(), 'title', DateTime.now());
        ESignLiveAPIObjects.Style newStyle = new ESignLiveAPIObjects.Style('background', 'color');
        ESignLiveAPIObjects.TextualSignatureStyle newTextualSignatureStyle = new ESignLiveAPIObjects.TextualSignatureStyle('color', 'font');
        ESignLiveAPIObjects.TitleBarOptions newTitleBarOptions = new ESignLiveAPIObjects.TitleBarOptions(true, true);
        ESignLiveAPIObjects.User newUser = new ESignLiveAPIObjects.User(new ESignLiveAPIObjects.Address(), 'company', DateTime.now(), 'data', 'email', new ESignLiveAPIObjects.External(), 'firtsName', 'id', 'language', 'lastName', 'name', 'phone', new ESignLiveAPIObjects.SignatureStyle(), 'title', DateTime.now());
    }
}