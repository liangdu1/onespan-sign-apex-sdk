/**
 * Class Name: OneSpanAPIObjectsls
 * 
 * This class contains classes used for serializing requests and deserializing responses
 * to and from the OneSpan REST API.  Each class contains both an empty constructor
 * and a constructor with arguments for easy variable setting.
 *
 * These classes were derived from the OneSpan API Schema Docs which can be
 * found here: http://docs.e-signlive.com/10.0/schema/index.html
 */

public with sharing class OneSpanAPIObjects
{
    /**
     * Enumerated Values
     */
    public enum MessageStatus  {NEW_X, READ, TRASHED}
    public enum AnchorPoint    {TOPLEFT, TOPRIGHT, BOTTOMLEFT, BOTTOMRIGHT}
    public enum AuthScheme     {NONE, PROVIDER, CHALLENGE, SMS}
    public enum MemberType     {REGULAR, MANAGER}
    public enum SenderStatus   {INVITED, ACTIVE, LOCKED}
    public enum SenderType     {REGULAR, MANAGER}
    public enum PackageStatus  {DRAFT, SENT, COMPLETED, ARCHIVED, DECLINED, OPTED_OUT, EXPIRED, SIGNING_PENDING}
    public enum PackageType    {PACKAGE_X, TEMPLATE, LAYOUT}

    public OneSpanAPIObjects(){}

    public class Address
    {
        public String address1;
        public String address2;
        public String city;
        public String country;
        public String state;
        public String zipcode;

        public Address(){}

        public Address(String address1, String address2, String city,
                String country, String state, String zipcode)
        {
            this.address1 = address1;
            this.address2 = address2;
            this.city = city;
            this.country = country;
            this.state = state;
            this.zipcode = zipcode;
        }
    }

    public class Approval
    {
        public DateTime accepted;
        public String data;
        public List<Field> fields;
        public String id;
        public String name;
        public String role;
        public DateTime signed;

        public Approval(){}

        public Approval(DateTime accepted, String data, List<Field> fields, String id,
                String name, String role, DateTime signed)
        {
            this.accepted = accepted;
            this.data = data;
            this.fields = fields;
            this.id = id;
            this.name = name;
            this.role =role;
            this.signed = signed;
        }
    }

    public class AttachmentBin
    {
        public String attachmentUid;
        public String data;
        public String id;
        public DateTime insertDate;
        public String name;

        public AttachmentBin(){}

        public AttachmentBin(String attachmentUid, String data, String id, DateTime insertDate, String name)
        {
            this.attachmentUid = attachmentUid;
            this.data = data;
            this.id = id;
            this.insertDate = insertDate;
            this.name = name;
        }
    }

    public class AttachmentRequirement
    {
        public String data;
        public String description;
        public String id;
        public String name;
        public Boolean required;
        public String comment;
        public String status;

        public AttachmentRequirement(){}

        public AttachmentRequirement(String data, String description, String id, String name,
                Boolean required, String comment, String status)
        {
            this.data = data;
            this.description = description;
            this.id = id;
            this.name = name;
            this.required = required;
            this.comment = comment;
            this.status = status;
        }
    }

    public class Auth
    {
        public List<AuthChallenge> challenges;
        public AuthScheme scheme;

        public Auth(){}

        public Auth(List<AuthChallenge> challenges, AuthScheme scheme)
        {
            this.challenges = challenges;
            this.scheme = scheme;
        }
    }

    public class AuthChallenge
    {
        public String answer;
        public Boolean maskInput;
        public String question;

        public AuthChallenge(){}

        public AuthChallenge(String answer, Boolean maskInput, String question)
        {
            this.answer = answer;
            this.maskInput = maskInput;
            this.question = question;
        }
    }

    public class Authentication
    {
        public String value;

        public Authentication(){}

        public Authentication(String value)
        {
            this.value = value;
        }
    }

    public class BrandingBarOptions
    {
        public Image logo;

        public BrandingBarOptions(){}

        public BrandingBarOptions(Image logo)
        {
            this.logo = logo;
        }
    }

    public class CeremonyEvents
    {
        public CeremonyEventComplete complete;

        public CeremonyEvents(){}

        public CeremonyEvents(CeremonyEventComplete complete)
        {
            this.complete = complete;
        }
    }

    public class CeremonyEventComplete
    {
        public Boolean dialog;
        public String redirect;

        public CeremonyEventComplete(){}

        public CeremonyEventComplete(Boolean diaglog, string redirect)
        {
            this.dialog = dialog;
            this.redirect = redirect;
        }
    }

    public class CeremonySettings
    {
        public Boolean declineButton;
        public DocumentToolbarOptions documentToolbarOptions;
        public CeremonyEvents events;
        public Link handOver;
        public Boolean hideCaptureText;
        public Boolean hideWatermark;
        public Boolean inPerson;
        public LayoutOptions layout;
        public Integer maxAuthFailsAllowed;
        public Boolean optOutButton;
        public List<String> optOutReasons;
        public LayoutStyle style;

        public CeremonySettings(){}

        public CeremonySettings(Boolean declineButton, DocumentToolbarOptions documentToolbarOptions,
                CeremonyEvents events, Link handOver, Boolean hideCaptureText, Boolean hideWatermark,
                Boolean inPerson, LayoutOptions layout, Integer maxAuthFailsAllowed,
                Boolean optOutButton, List<String> optOutReasons, LayoutStyle style)
        {
            this.declineButton = declineButton;
            this.documentToolbarOptions = documentToolbarOptions;
            this.events = events;
            this.handOver = handOver;
            this.hideCaptureText = hideCaptureText;
            this.hideWatermark = hideWatermark;
            this.inPerson = inPerson;
            this.layout = layout;
            this.maxAuthFailsAllowed = maxAuthFailsAllowed;
            this.optOutButton = optOutButton;
            this.optOutReasons = optOutReasons;
            this.style = style;
        }
    }

    public class Data
    {
        String origin;
        String sdk;
        String ese_document_texttag_extract_needed;

        public Data()
        {
            origin = 'Salesforce';
            sdk = 'Apex v1.0';
        }
    }

    public class Delivery
    {
        public Boolean download;
        public Boolean email;
        public Boolean provider;

        public Delivery(){}

        public Delivery(Boolean download, Boolean email, Boolean provider)
        {
            this.download = download;
            this.email = email;
            this.provider = provider;
        }
    }

    public class Document
    {
        public List<Approval> approvals;
        public Data data;
        public String description;
        public External external;
        public Boolean extract;
        public List<Field> fields;
        public String id;
        public Integer index;
        public String name;
        public List<Page_x> pages;
        public Integer size;

        public Document(){}

        public Document(List<Approval> approvals, Data data, String description, External external,
                List<Field> fields, String id, Integer index, String name, List<Page_x> pages, Integer size)
        {
            this.approvals = approvals;
            this.data = data;
            this.description = description;
            this.external = external;
            this.fields = fields;
            this.id = id;
            this.index = index;
            this.name = name;
            this.pages = pages;
            this.size = size;
        }
    }

    public class DocumentToolbarOptions
    {
        public Boolean downloadButton;

        public DocumentToolbarOptions(){}

        public DocumentToolbarOptions(Boolean downloadButton)
        {
            this.downloadButton = downloadButton;
        }
    }

    public class EmailMessage
    {
        public String content;

        public EmailMessage(){}

        public EmailMessage(String content)
        {
            this.content = content;
        }
    }

    public class External
    {
        public String data;
        public String id;
        public String provider;
        public String providerName;

        public External(){}

        public External(String data, String id, String provider, String providerName)
        {
            this.data = data;
            this.id = id;
            this.provider = providerName;
            this.providerName = providerName;
        }
    }

    public class ExtractAnchor
    {
        public AnchorPoint anchorPoint;
        public Integer characterIndex;
        public Integer height;
        public Integer index;
        public Integer leftOffset;
        public String text;
        public Integer topOffset;
        public Integer width;

        public ExtractAnchor(){}

        public ExtractAnchor(AnchorPoint anchorPoint, Integer characterIndex, Integer height, Integer index,
                Integer leftOffset, String text, Integer topOffset, Integer width)
        {
            this.anchorPoint = anchorPoint;
            this.characterIndex = characterIndex;
            this.height = height;
            this.index = index;
            this.leftOffset = leftOffset;
            this.text = text;
            this.topOffset = topOffset;
            this.width = width;
        }
    }

    public class Field
    {
        public String data;
        public Boolean extract;
        public ExtractAnchor extractAnchor;
        public Decimal height;
        public String id;
        public Decimal left;
        public String name;
        public Integer page;
        public String subtype;
        public Decimal top;
        public String type;
        public FieldValidation validation;
        public String value;
        public Decimal width;
        public String binding;

        public Field(){}

        public Field(String data, Boolean extract, ExtractAnchor extractAnchor, Decimal height, String id,
                Decimal left, String name, Integer page, String subtype, Decimal top, String type,
                FieldValidation validation, String value, Decimal width,String binding)
        {
            this.data = data;
            this.extract = extract;
            this.extractAnchor = extractAnchor;
            this.height = height;
            this.id = id;
            this.left = left;
            this.name = name;
            this.page = page;
            this.subtype = subtype;
            this.top = top;
            this.type = type;
            this.validation = validation;
            this.value = value;
            this.width = width;
            this.binding = binding;
        }
    }

    public class FieldValidation
    {
        public List<String> enum_x;
        public Integer errorCode;
        public String errorMessage;
        public Integer maxLength;
        public Integer minLength;
        public String pattern;
        public Boolean required;

        public FieldValidation(){}

        public FieldValidation(List<String> enum_x, Integer errorCode, String errorMessage, Integer maxLength,
                Integer minLength, String pattern, Boolean required)
        {
            this.enum_x = enum_x;
            this.errorCode = errorCode;
            this.errorMessage = errorMessage;
            this.maxLength = maxLength;
            this.minLength = minLength;
            this.pattern = pattern;
            this.required = required;
        }
    }

    public class FooterOptions
    {
        public FooterOptions(){}
    }

    public class GlobalActionsOptions
    {
        public Boolean confirm;
        public Boolean download;
        public Boolean saveAsLayout;

        public GlobalActionsOptions(){}

        public GlobalActionsOptions(Boolean confirm, Boolean download, Boolean saveAsLayout)
        {
            this.confirm = confirm;
            this.download = download;
            this.saveAsLayout = saveAsLayout;
        }
    }

    public class GroupMembership
    {
        public String groupId;
        public String groupName;
        public MemberType memberType;

        public GroupMembership(){}

        public GroupMembership(String groupId, String groupName, MemberType memberType)
        {
            this.groupId = groupId;
            this.groupName = groupName;
            this.memberType = memberType;
        }
    }

    public class HeaderOptions
    {
        public Boolean breadcrumbs;
        public Boolean feedback;
        public GlobalActionsOptions globalActions;
        public Boolean globalNavigation;
        public Boolean sessionBar;
        public TitleBarOptions titleBar;

        public HeaderOptions(){}

        public HeaderOptions(Boolean breadcrumbs, Boolean feedback, GlobalActionsOptions globalActions,
                Boolean globalNavigation, Boolean sessionBar, TitleBarOptions titleBar)
        {
            this.breadcrumbs = breadcrumbs;
            this.feedback = feedback;
            this.globalActions = globalActions;
            this.globalNavigation = globalNavigation;
            this.sessionBar = sessionBar;
            this.titleBar = titleBar;
        }
    }

    public class Image
    {
        public String link;
        public String src;

        public Image(){}

        public Image(String link, String src)
        {
            this.link = link;
            this.src = src;
        }
    }

    public class LayoutStyle
    {
        public Image brandingBar;
        public Style dialog;
        public Style titleBar;
        public Style toolBar;

        public LayoutStyle(){}

        public LayoutStyle(Image brandingBar, Style dialog, Style titleBar, Style toolBar)
        {
            this.brandingBar = brandingBar;
            this.dialog = dialog;
            this.titleBar = titleBar;
            this.toolBar = toolBar;
        }
    }

    public class LayoutOptions
    {
        public BrandingBarOptions brandingBar;
        public FooterOptions footer;
        public HeaderOptions header;
        public Boolean iframe;
        public Boolean navigator;

        public LayoutOptions(){}

        public LayoutOptions(BrandingBarOptions brandingBar, FooterOptions footer,
                HeaderOptions header, Boolean iframe, Boolean navigator)
        {
            this.brandingBar = brandingBar;
            this.footer = footer;
            this.header = header;
            this.iframe = iframe;
            this.navigator = navigator;
        }
    }

    public class Link
    {
        public String href;
        public String text;
        public String title;

        public Link(){}

        public Link(String href, String text, String title)
        {
            this.href = href;
            this.text = text;
            this.title = title;
        }
    }

    public class Message
    {
        public String content;
        public DateTime created;
        public List<Document> documents;
        public User from_x;
        public MessageStatus status;
        public List<User> to;

        public Message(){}

        public Message(String content, DateTime created, List<Document> documents, User from_x,
                MessageStatus status, List<USer> to)
        {
            this.content = content;
            this.created = created;
            this.documents = documents;
            this.from_x = from_x;
            this.status = status;
            this.to = to;
        }
    }

    public class Package_x
    {
        public Boolean autocomplete;
        public DateTime completed;
        public String consent;
        public String description;
        public List<Document> documents;
        public DateTime due;
        public String emailMessage;
        public String id;
        public String language;
        public PackageArtifactsLimits limits;
        public List<Message> messages;
        public String name;
        public List<Role> roles;
        public Sender sender;
        public Settings settings;
        public SignedDocumentDelivery signedDocumentDelivery;
        public PackageStatus status;
        public Boolean trashed;
        public PackageType type;
        public DateTime updated;
        public Data data;

        public Package_x()
        {
            this.data = new Data();
        }

        public Package_x(Boolean autocomplete, DateTime completed, String consent, String description,
                List<Document> documents, DateTime due, String emailMessage, String id, String language,
                PackageArtifactsLimits limits, List<Message> messages, String name, List<Role> roles,
                Sender sender, Settings settings, SignedDocumentDelivery signedDocumentDelivery,
                PackageStatus status, Boolean trashed, PackageType type, DateTime updated)
        {
            this.autocomplete = autocomplete;
            this.completed = completed;
            this.consent = consent;
            this.description = description;
            this.documents = documents;
            this.due = due;
            this.emailMessage = emailMessage;
            this.id = id;
            this.language = language;
            this.limits = limits;
            this.messages = messages;
            this.name = name;
            this.roles = roles;
            this.sender = sender;
            this.settings = settings;
            this.signedDocumentDelivery = signedDocumentDelivery;
            this.status = status;
            this.trashed = trashed;
            this.type = type;
            this.updated = updated;
            this.data = new Data();
        }
    }

    public class PackageArtifactsLimits
    {
        public Integer documents;
        public Integer roles;

        public PackageArtifactsLimits(){}

        public PackageArtifactsLimits(Integer documents, Integer roleId)
        {
            this.documents = documents;
            this.roles = roles;
        }
    }

    public class Page_x
    {
        public Decimal height;
        public String id;
        public Integer index;
        public Decimal left;
        public Decimal top;
        public Integer version;
        public Decimal width;

        public Page_x(){}

        public Page_x(Decimal height, String id, Integer index, Decimal left, Decimal top,
                Integer version, Decimal width)
        {
            this.height = height;
            this.id = id;
            this.index = index;
            this.left = left;
            this.top = top;
            this.version = version;
            this.width = width;
        }
    }

    public class Role
    {
        public List<AttachmentRequirement> attachmentRequirements;
        public String data;
        public EmailMessage emailMessage;
        public String id;
        public Integer index;
        public Boolean locked;
        public String name;
        public Boolean reassign;
        public List<Signer> signers;
        public String type;

        public Role(){}

        public Role(List<AttachmentRequirement> attachmentRequirements, String data, EmailMessage emailMessage,
                String id, Integer index, Boolean locked, String name, Boolean reassign, List<Signer> signers,
                String type)
        {
            this.attachmentRequirements = attachmentRequirements;
            this.data = data;
            this.emailMessage = emailMessage;
            this.id = id;
            this.index = index;
            this.locked = locked;
            this.name = name;
            this.reassign = reassign;
            this.signers = signers;
            this.type = type;
        }
    }

    public class SignatureStyle
    {
        public String handdrawn;
        public TextualSignatureStyle textual;

        public SignatureStyle(){}

        public SignatureStyle(String handdrawn, TextualSignatureStyle textual)
        {
            this.handdrawn = handdrawn;
            this.textual = textual;
        }
    }

    // not standard object in their list
    public class SigningUrl
    {
        public String roleId;
        public String url;
        public String packageId;

        public SigningUrl(){}

        public SigningUrl(String roleId, String url, String packageId)
        {
            this.roleId = roleId;
            this.url = url;
            this.packageId = packageId;
        }
    }

    public class Sender
    {
        public DateTime activated;
        public Address address;
        public String company;
        public DateTime created;
        public String email;
        public External external;
        public String firstName;
        public String id;
        public String language;
        public String lastName;
        public DateTime locked;
        public List<GroupMembership> memberships;
        public String name;
        public String phone;
        public SignatureStyle signature;
        public SenderStatus status;
        public String title;
        public SenderType type;
        public DateTime updated;

        public Sender(){}

        public Sender(DateTime activated, Address address, String company, DateTime created,  String email,
                External external, String firsName, String id, String language, String lastName, DateTime locked,
                List<GroupMembership> memberships, String name, String phone, SignatureStyle signature,
                SenderStatus status, SenderType type, String title, DateTime updated )
        {
            this.activated = activated;
            this.address = address;
            this.company = company;
            this.created = created;
            this.email = email;
            this.external = external;
            this.firstName = firsName;
            this.id = id;
            this.language = language;
            this.lastName = lastName;
            this.locked = locked;
            this.memberships = memberships;
            this.name = name;
            this.phone = phone;
            this.signature = signature;
            this.status = status;
            this.type = type;
            this.title = title;
            this.updated = updated;
        }
    }

    public class CurrentSignerProgress
    {
        public Integer documentsToConfirmCount;
        public Integer documentsConfirmedCount;
        public Integer approvalsToConfirmCount;
        public Integer approvalsConfirmedCount;
        public Integer documentsPartiallyCompletedCount;
        public Integer approvalsToSignNowCount;

        public CurrentSignerProgress(){}

        public CurrentSignerProgress(Integer documentsToConfirmCount,Integer documentsConfirmedCount,Integer approvalsToConfirmCount,
                Integer approvalsConfirmedCount,Integer documentsPartiallyCompletedCount,Integer approvalsToSignNowCount)
        {
            this.documentsToConfirmCount = documentsToConfirmCount;
            this.documentsConfirmedCount = documentsConfirmedCount;
            this.approvalsToConfirmCount = approvalsToConfirmCount;
            this.approvalsConfirmedCount = approvalsConfirmedCount;
            this.documentsPartiallyCompletedCount = documentsPartiallyCompletedCount;
            this.approvalsToSignNowCount = approvalsToSignNowCount;
        }
    }

    public class OverAllProgress
    {
        public Integer documentsToCompleteCount;
        public Integer documentsCompletedCount;
        public Integer documentsToConfirmCount;
        public Integer documentsConfirmedCount;
        public Integer documentsPartiallyCompletedCount;

        public OverAllProgress(){}

        public OverAllProgress(Integer documentsToCompleteCount,Integer documentsCompletedCount,Integer documentsToConfirmCount,
                Integer documentsConfirmedCount,Integer documentsPartiallyCompletedCount)
        {
            this.documentsToCompleteCount = documentsToCompleteCount;
            this.documentsCompletedCount = documentsCompletedCount;
            this.documentsToConfirmCount = documentsToConfirmCount;
            this.documentsConfirmedCount = documentsConfirmedCount;
            this.documentsPartiallyCompletedCount = documentsPartiallyCompletedCount;
        }
    }

    public class Settings
    {
        public CeremonySettings ceremony;
    }

    public class SignedDocumentDelivery
    {
        public List<External> destinations;
        public List<Document> excludedDocuments;
        public String filePrefix;
        public String fileSuffix;

        public SignedDocumentDelivery(){}

        public SignedDocumentDelivery(List<External> destinations, List<Document> excludedDocuments,
                String filePrefix, String fileSuffix)
        {
            this.destinations = destinations;
            this.excludedDocuments = excludedDocuments;
            this.filePrefix = filePrefix;
            this.fileSuffix = fileSuffix;
        }
    }

    public class Signer
    {
        public Address address;
        public Auth auth;
        public String company;
        public DateTime created;
        public String data;
        public Delivery delivery;
        public String email;
        public External external;
        public String firstName;
        public Group group_x;
        public String id;
        public String language;
        public String lastName;
        public String name;
        public String phone;
        public SignatureStyle signature;
        public String title;
        public DateTime updated;

        public Signer(){}

        public Signer(Address address, Auth auth, String company, String data, Delivery delivery, String email,
                External external, String firsName, Group group_x, String id, String language,
                String lastName, String name, String phone, SignatureStyle signature,
                String title, DateTime updated )
        {
            this.address = address;
            this.auth = auth;
            this.company = company;
            this.created = created;
            this.data = data;
            this.delivery = delivery;
            this.email = email;
            this.external = external;
            this.firstName = firstName;
            this.group_x = group_x;
            this.id = id;
            this.language = language;
            this.lastName = lastName;
            this.name = name;
            this.phone = phone;
            this.signature = signature;
            this.title = title;
            this.updated = updated;
        }
    }

    public class Style
    {
        public String backgroundColor;
        public String color;

        public Style(){}

        public Style(String backgroundColor, String color)
        {
            this.backgroundColor = backgroundColor;
            this.color = color;
        }
    }

    public class TextualSignatureStyle
    {
        public String color;
        public String font;

        public TextualSignatureStyle(){}

        public TextualSignatureStyle(String color, String font)
        {
            this.color = color;
            this.font = font;
        }
    }

    public class TitleBarOptions
    {
        public Boolean progressBar;
        public Boolean title;

        public TitleBarOptions(){}

        public TitleBarOptions(Boolean progressBar, Boolean title)
        {
            this.progressBar = progressBar;
            this.title = title;
        }
    }

    public class User
    {
        public Address address;
        public String company;
        public DateTime created;
        public String data;
        public String email;
        public External external;
        public String firstName;
        public String id;
        public String language;
        public String lastName;
        public String name;
        public String phone;
        public SignatureStyle signature;
        public String title;
        public DateTime updated;

        public User(){}

        public User(Address address, String company, DateTime created, String data, String email, External external,
                String firstName, String id, String language, String lastName, String name, String phone,
                SignatureStyle signature, String title, DateTime updated)
        {
            this.address = address;
            this.company = company;
            this.created = created;
            this.data = data;
            this.email = email;
            this.external = external;
            this.firstName = firstName;
            this.id = id;
            this.language = language;
            this.lastName = lastName;
            this.name = name;
            this.phone = phone;
            this.signature = signature;
            this.title = title;
            this.updated = updated;
        }
    }
}