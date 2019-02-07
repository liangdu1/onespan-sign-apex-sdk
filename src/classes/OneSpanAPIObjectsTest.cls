/**
 * Class Name: OneSpanAPIObjectsTestls
 *
 * This class is a test class for the OneSpanAPIObjects class and
 * contains test methods for testing enumerated values, for instantiating classes using empty
 * constructors, and one for instantiating classes using arguments
 */

@isTest
public class OneSpanAPIObjectsTest
{
    /**
     * Method to test the enumerated values
     */
    private static testMethod void testEnumeratedValues()
    {
        OneSpanAPIObjects.MessageStatus newMessageStatus = OneSpanAPIObjects.MessageStatus.NEW_X;
        OneSpanAPIObjects.AnchorPoint newAnchorPoint = OneSpanAPIObjects.AnchorPoint.TOPLEFT;
        OneSpanAPIObjects.AuthScheme newAuthScheme = OneSpanAPIObjects.AuthScheme.NONE;
        OneSpanAPIObjects.MemberType newMemberType = OneSpanAPIObjects.MemberType.REGULAR;
        OneSpanAPIObjects.SenderStatus newSenderStatus = OneSpanAPIObjects.SenderStatus.INVITED;
        OneSpanAPIObjects.SenderType newSenderType = OneSpanAPIObjects.SenderType.REGULAR;
        OneSpanAPIObjects.PackageStatus newPackageStatus = OneSpanAPIObjects.PackageStatus.DRAFT;
        OneSpanAPIObjects.PackageType newPackageType = OneSpanAPIObjects.PackageType.PACKAGE_X;
    }

    /**
     * Method to test instantiating classes using empty constructors
     */
    private static testMethod void testEmptyConstructors()
    {
        OneSpanAPIObjects newAPIObjects = new OneSpanAPIObjects();
        OneSpanAPIObjects.Package_x newPackage = new OneSpanAPIObjects.Package_x();
        OneSpanAPIObjects.Approval newApproval = new OneSpanAPIObjects.Approval();
        OneSpanAPIObjects.AttachmentRequirement newAttachmentRequirement = new OneSpanAPIObjects.AttachmentRequirement();
        OneSpanAPIObjects.Auth newAuth = new OneSpanAPIObjects.Auth();
        OneSpanAPIObjects.Authentication newAuthentication = new OneSpanAPIObjects.Authentication();
        OneSpanAPIObjects.CeremonyEventComplete newCeremonyEventComplete = new OneSpanAPIObjects.CeremonyEventComplete();
        OneSpanAPIObjects.CeremonyEvents newCeremonyEvents = new OneSpanAPIObjects.CeremonyEvents();
        OneSpanAPIObjects.CeremonySettings newCeremonySettings = new OneSpanAPIObjects.CeremonySettings();
        OneSpanAPIObjects.AuthChallenge newAuthChallenge = new OneSpanAPIObjects.AuthChallenge();
        OneSpanAPIObjects.Delivery newDelivery = new  OneSpanAPIObjects.Delivery();
        OneSpanAPIObjects.Address newAddress = new OneSpanAPIObjects.Address();
        OneSpanAPIObjects.BrandingBarOptions newBrandingBarOptions = new OneSpanAPIObjects.BrandingBarOptions();
        OneSpanAPIObjects.DocumentToolbarOptions newDocumentToolBarOptions = new OneSpanAPIObjects.DocumentToolbarOptions();
        OneSpanAPIObjects.Document newDocument = new OneSpanAPIObjects.Document();
        OneSpanAPIObjects.External newExternal = new OneSpanAPIObjects.External();
        OneSpanAPIObjects.ExtractAnchor newExtractAnchor = new OneSpanAPIObjects.ExtractAnchor();
        OneSpanAPIObjects.Field newField = new OneSpanAPIObjects.Field();
        OneSpanAPIObjects.FieldValidation newFieldValidation = new OneSpanAPIObjects.FieldValidation();
        OneSpanAPIObjects.FooterOptions newFooterOptions = new OneSpanAPIObjects.FooterOptions();
        OneSpanAPIObjects.GlobalActionsOptions newGLobalActionOptions = new OneSpanAPIObjects.GlobalActionsOptions();
        OneSpanAPIObjects.GroupMembership newGroupMembership = new OneSpanAPIObjects.GroupMembership();
        OneSpanAPIObjects.Image newImage = new OneSpanAPIObjects.Image();
        OneSpanAPIObjects.LayoutStyle newLayoutStyle = new OneSpanAPIObjects.LayoutStyle();
        OneSpanAPIObjects.LayoutOptions newLayoutOptions = new OneSpanAPIObjects.LayoutOptions();
        OneSpanAPIObjects.Link newLink = new OneSpanAPIObjects.Link();
        OneSpanAPIObjects.Message newMessage = new OneSpanAPIObjects.Message();
        OneSpanAPIObjects.PackageArtifactsLimits newPackageArtifactsLimits = new OneSpanAPIObjects.PackageArtifactsLimits();
        OneSpanAPIObjects.Page_x newPage = new OneSpanAPIObjects.Page_x();
        OneSpanAPIObjects.Role newRole = new OneSpanAPIObjects.Role();
        OneSpanAPIObjects.SignatureStyle newSignatureStyle = new OneSpanAPIObjects.SignatureStyle();
        OneSpanAPIObjects.SigningUrl newSigningUrl = new OneSpanAPIObjects.SigningUrl();
        OneSpanAPIObjects.Sender newSender = new OneSpanAPIObjects.Sender();
        OneSpanAPIObjects.Settings newSettings = new OneSpanAPIObjects.Settings();
        OneSpanAPIObjects.SignedDocumentDelivery newSignedDocumentDelivery = new OneSpanAPIObjects.SignedDocumentDelivery();
        OneSpanAPIObjects.Signer newSigner = new OneSpanAPIObjects.Signer();
        OneSpanAPIObjects.Style newStyle = new OneSpanAPIObjects.Style();
        OneSpanAPIObjects.TextualSignatureStyle newTextualSignatureStyle = new OneSpanAPIObjects.TextualSignatureStyle();
        OneSpanAPIObjects.TitleBarOptions newTitleBarOptions = new OneSpanAPIObjects.TitleBarOptions();
        OneSpanAPIObjects.User newUser = new OneSpanAPIObjects.User();
        OneSpanAPIObjects.EmailMessage newEmailMessage = new OneSpanAPIObjects.EmailMessage();
        OneSpanAPIObjects.HeaderOptions newHeaderOptions = new OneSpanAPIObjects.HeaderOptions();
        OneSpanAPIObjects.CurrentSignerProgress newCurrentSignerProgress = new OneSpanAPIObjects.CurrentSignerProgress();
        OneSpanAPIObjects.OverallProgress newOverallProgress = new OneSpanAPIObjects.OverallProgress();
    }

    /**
     * Method to test instantiating classes using arguments
     */
    private static testMethod void testConstructorsWithArguments()
    {
        OneSpanAPIObjects.Approval newApproval = new OneSpanAPIObjects.Approval(System.Now(), '', new List<OneSpanAPIObjects.Field>(), 'Id', 'Name', 'Role', System.Now());
        OneSpanAPIObjects.AttachmentRequirement newAttachmentRequirement = new OneSpanAPIObjects.AttachmentRequirement('', 'Description', 'Id', 'Name', true, 'Comment', 'Status');
        OneSpanAPIObjects.Auth newAuth = new OneSpanAPIObjects.Auth(new List<OneSpanAPIObjects.AuthChallenge>(), OneSpanAPIObjects.AuthScheme.NONE);
        OneSpanAPIObjects.Authentication newAuthentication = new OneSpanAPIObjects.Authentication('Value');
        OneSpanAPIObjects.CeremonyEventComplete newCeremonyEventComplete = new OneSpanAPIObjects.CeremonyEventComplete(true, 'Redirect');
        OneSpanAPIObjects.CeremonyEvents newCeremonyEvents = new OneSpanAPIObjects.CeremonyEvents(new OneSpanAPIObjects.CeremonyEventComplete());
        OneSpanAPIObjects.CeremonySettings newCeremonySettings = new OneSpanAPIObjects.CeremonySettings(true, new OneSpanAPIObjects.DocumentToolbarOptions(), new OneSpanAPIObjects.CeremonyEvents(), new OneSpanAPIObjects.Link(), true, true, true, new OneSpanAPIObjects.LayoutOptions(), 0, true, new List<String>(), new OneSpanAPIObjects.LayoutStyle());
        OneSpanAPIObjects.AuthChallenge newAuthChallenge = new OneSpanAPIObjects.AuthChallenge('Answer', true, 'Question');
        OneSpanAPIObjects.Delivery newDelivery = new  OneSpanAPIObjects.Delivery(true, true, true);
        OneSpanAPIObjects.Address newAddress = new OneSpanAPIObjects.Address('123 Maple St', '', 'Houston','USA', 'Texas', '77347');
        OneSpanAPIObjects.AttachmentBin newAttachmentBin = new OneSpanAPIObjects.AttachmentBin('attachmentId', '', 'Id', System.now(), 'Name');
        OneSpanAPIObjects.BrandingBarOptions newBrandingBarOptions = new OneSpanAPIObjects.BrandingBarOptions(new OneSpanAPIObjects.Image());
        OneSpanAPIObjects.DocumentToolbarOptions newDocumentToolbarOptions = new OneSpanAPIObjects.DocumentToolbarOptions(true);
        OneSpanAPIObjects.Document newDocument = new OneSpanAPIObjects.Document(new List<OneSpanAPIObjects.Approval>(), new OneSpanAPIObjects.Data(), 'description', new OneSpanAPIObjects.External(), new List<OneSpanAPIObjects.Field>(), 'id', 1, 'name',new List<OneSpanAPIObjects.Page_x>(), 10);
        OneSpanAPIObjects.EmailMessage newEmailMessage = new OneSpanAPIObjects.EmailMessage('content');
        OneSpanAPIObjects.External newExternal = new OneSpanAPIObjects.External('data', 'id', 'provider', 'providerName');
        OneSpanAPIObjects.ExtractAnchor newExtractAnchor = new OneSpanAPIObjects.ExtractAnchor(OneSpanAPIObjects.AnchorPoint.TOPLEFT, 1, 1, 1, 1, 'text', 1, 1);
        OneSpanAPIObjects.Field newField = new OneSpanAPIObjects.Field('data', true, new OneSpanAPIObjects.ExtractAnchor(), 0.1, 'id', 0.1, 'name', 1, 'subtype', 0.1, 'type', new OneSpanAPIObjects.FieldValidation(), 'value', 0.1,null);
        OneSpanAPIObjects.FieldValidation newFieldValidation = new OneSpanAPIObjects.FieldValidation(new List<String>(), 1, 'errorMessage', 1, 1, 'pattern', true);
        OneSpanAPIObjects.GlobalActionsOptions newGLobalActionOptions = new OneSpanAPIObjects.GlobalActionsOptions(true, true, true);
        OneSpanAPIObjects.GroupMembership newGroupMembership = new OneSpanAPIObjects.GroupMembership('groupId', 'groupName', OneSpanAPIObjects.MemberType.REGULAR);
        OneSpanAPIObjects.HeaderOptions newHeaderOptions = new OneSpanAPIObjects.HeaderOptions(true, true, new OneSpanAPIObjects.GlobalActionsOptions(), true, true, new OneSpanAPIObjects.TitleBarOptions());
        OneSpanAPIObjects.Image newImage = new OneSpanAPIObjects.Image('link', 'src');
        OneSpanAPIObjects.LayoutStyle newLayoutStyle = new OneSpanAPIObjects.LayoutStyle(new OneSpanAPIObjects.Image(), new OneSpanAPIObjects.Style(), new OneSpanAPIObjects.Style(), new OneSpanAPIObjects.Style());
        OneSpanAPIObjects.LayoutOptions newLayoutOptions = new OneSpanAPIObjects.LayoutOptions(new OneSpanAPIObjects.BrandingBarOptions(), new OneSpanAPIObjects.FooterOptions(), new OneSpanAPIObjects.HeaderOptions(), true, true);
        OneSpanAPIObjects.Link newLink = new OneSpanAPIObjects.Link('href', 'text', 'title');
        OneSpanAPIObjects.Package_x newPackage = new OneSpanAPIObjects.Package_x(true, DateTime.now(), 'consent', 'description', new List<OneSpanAPIObjects.Document>(), DateTime.now(), 'emailMessage', 'id', 'language', new OneSpanAPIObjects.PackageArtifactsLimits(), new List<OneSpanAPIObjects.Message>(), 'name', new List<OneSpanAPIObjects.Role>(), new OneSpanAPIObjects.Sender(), new OneSpanAPIObjects.Settings(), new OneSpanAPIObjects.SignedDocumentDelivery(), OneSpanAPIObjects.PackageStatus.DRAFT, true, OneSpanAPIObjects.PackageType.TEMPLATE, DateTime.now());
        OneSpanAPIObjects.PackageArtifactsLimits newPackageArtifactsLimits = new OneSpanAPIObjects.PackageArtifactsLimits(1, 1);
        OneSpanAPIObjects.Page_x newPage = new OneSpanAPIObjects.Page_x(0.1, 'id', 1, 0.1, 0.1, 1, 0.1);
        OneSpanAPIObjects.Role newRole = new OneSpanAPIObjects.Role(new List<OneSpanAPIObjects.AttachmentRequirement>(), 'data', new OneSpanAPIObjects.EmailMessage(), 'id', 1, true, 'name', true, new List<OneSpanAPIObjects.Signer>(), 'type');
        OneSpanAPIObjects.SignatureStyle newSignatureStyle = new OneSpanAPIObjects.SignatureStyle('handdrawn', new OneSpanAPIObjects.TextualSignatureStyle());
        OneSpanAPIObjects.SigningUrl newSigningUrl = new OneSpanAPIObjects.SigningUrl('roleId', 'url', 'packageId');
        OneSpanAPIObjects.Sender newSender = new OneSpanAPIObjects.Sender(DateTime.now(), new OneSpanAPIObjects.Address(), 'company', DateTime.now(), 'email', new OneSpanAPIObjects.External(), 'firsName', 'id', 'language', 'lastName', DateTime.now(), new List<OneSpanAPIObjects.GroupMembership>(), 'name', 'phone', new OneSpanAPIObjects.SignatureStyle(), OneSpanAPIObjects.SenderStatus.LOCKED, OneSpanAPIObjects.SenderType.MANAGER, 'title', DateTime.now());
        OneSpanAPIObjects.CurrentSignerProgress newCurrentSignerProgress = new OneSpanAPIObjects.CurrentSignerProgress(1, 1, 1, 1, 1, 1);
        OneSpanAPIObjects.OverallProgress newOverallProgress = new OneSpanAPIObjects.OverallProgress(1, 1, 1, 1, 1);
        OneSpanAPIObjects.SignedDocumentDelivery newSignedDocumntDelivery = new OneSpanAPIObjects.SignedDocumentDelivery(new List<OneSpanAPIObjects.External>(), new List<OneSpanAPIObjects.Document>(), 'filePrefix', 'fileSuffix');
        OneSpanAPIObjects.Signer newSigner = new OneSpanAPIObjects.Signer(new OneSpanAPIObjects.Address(), new OneSpanAPIObjects.Auth(), 'company', 'data', new OneSpanAPIObjects.Delivery(), 'email', new OneSpanAPIObjects.External(), 'firsName', new Group(), 'id', 'language', 'lastName', 'name','phone', new OneSpanAPIObjects.SignatureStyle(), 'title', DateTime.now());
        OneSpanAPIObjects.Style newStyle = new OneSpanAPIObjects.Style('background', 'color');
        OneSpanAPIObjects.TextualSignatureStyle newTextualSignatureStyle = new OneSpanAPIObjects.TextualSignatureStyle('color', 'font');
        OneSpanAPIObjects.TitleBarOptions newTitleBarOptions = new OneSpanAPIObjects.TitleBarOptions(true, true);
        OneSpanAPIObjects.User newUser = new OneSpanAPIObjects.User(new OneSpanAPIObjects.Address(), 'company', DateTime.now(), 'data', 'email', new OneSpanAPIObjects.External(), 'firtsName', 'id', 'language', 'lastName', 'name', 'phone', new OneSpanAPIObjects.SignatureStyle(), 'title', DateTime.now());
    }
}