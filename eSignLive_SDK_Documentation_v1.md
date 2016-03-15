**Introduction**
----------------

The e-SignLive™ Salesforce™ SDK is an e-SignLive™ feature that enables
users to integrate e-signature processes from Salesforce orgs.

This SDK is written in Apex which is the Salesforce on-demand
programming language.

**Getting Started**
-------------------

1.  Install the package using the instructions in the README file of our
    [GitHub](https://github.com/KadenceCollective/esignlive-apex-sdk) repository.

2.  Set the Custom Setting with the name as ‘Main’

3.  Add e-SignLive URL to the Remote Site Setting

4.  Run the getSessionId() from the Examples class to see if the
    integration is working as expected.

**Overview**
------------

The e-SignLive Salesforce SDK leverages e-SignLive REST API to interact
with the e-SignLive system.

The SDK contains following classes:

1.  ESignLiveExamples: This class has the examples to perform different
    operations like creating a package, downloading the signer
    attachments etc.

2.  ESignLiveSDK: This is the class with which the users
    interact directly. It has different methods which take input
    parameters and call the appropriate API helper methods to do the
    callouts to e-SignLive system.

3.  ESignLiveRESTAPIHelper: Helper class to handle the callouts to the
    e-SignLive system and parse the response received. This class has
    the generic methods to do the basic CRUD operations on different
    objects like the Package, Document, Attachment etc.

4.  ESignLiveValidate: This class is used for validating the input data.
    It has validation methods for all data types used in the SDK. All
    these methods are overloaded. The validation is done at the
    ESignLiveSDK class level.

5.  ESignLiveDocumentUtilities: ESignLiveSDK class makes use of the
    methods in this utilities class. The methods in this class are
    mainly used to encode the document content, so that the encoded
    content can passed to the API helper class for doing the callouts.

6.  ESignLiveJSONHelper: Another utility class to convert the inbound
    and prepare the outbound messages. This conversion is needed for the
    outbound messages as we would need to only pass non-null content
    to eSignLive. And we would need to process and convert the response
    from eSignLive, as there are few Apex level restrictions on the
    usage of few reserved keywords in the code.

7.  ESignLiveAPIObjects: This class holds all the objects used for
    serializing and de-serializing the messages used for interacting
    with the eSignLive REST API. Each object has an empty constructor
    and a constructor with full set of field attributes. This class also
    has various enum values which are used to for attributes on
    different objects.

**Objects**
-----------

1.  Address

2.  Approval

3.  AttachmentBin

4.  AttachmentRequirement

5.  Auth

6.  AuthChallenge

7.  Authentication

8.  BrandingBarOptions

9.  CeremonyEvents

10. CeremonyEventComplete

11. CeremonySettings

12. CurrentSignerProgress

13. Data

14. Delivery

15. Document

16. DocumentToolbarOptions

17. EmailMessage

18. External

19. ExtractAnchor

20. Field

21. FieldValidation

22. FooterOptions

23. GlobalActionsOptions

24. GroupMembership

25. HeaderOptions

26. Image

27. LayoutStyle

28. LayoutOptions

29. Link

30. Message

31. OverAllProgress

32. Package\_x

33. PackageArtifactsLimits

34. Page\_x

35. Role

36. Sender

37. Settings

38. SignatureStyle

39. SignedDocumentDelivery

40. Signer

41. SigningUrl

42. Style

43. TextualSignatureStyle

44. TitleBarOptions

45. User

**Packages**
------------

Package is a top level container which can have documents, signatures,
signers etc.

We can create the package using one of the two methods listed below:

1.  *Create Package by passing the Package object: *

    The Package object can be created with different fields wherein the
    only field which is required to create a package successfully is the
    “name” field.

![](media/image3.png){width="6.5in" height="0.9923611111111111in"}

1.  *Create Package with Document Binaries:*

    The above createPackage method with just the Package object doesn’t
    include the actual documents. In order to add documents to a package
    when creating the package, we would need to use the createPackage
    method with two parameters, one is the package object and the second
    is the map of document Blobs along with the document names.

![](media/image4.png){width="6.5in" height="1.2729166666666667in"}

1.  *Get Package:*

    This method is used to get an already existing package
    in e-SignLive. It would take the package id as the input parameter.

    ![](media/image5.png){width="6.5in" height="0.9451388888888889in"}

2.  *Update Package:*

    This method updates an existing package. It takes the existing
    package id and a Package object with which the existing package
    would be overridden.

    ![](media/image6.png){width="6.5in" height="1.0173611111111112in"}

3.  *Delete Package:*

    This method deletes the package specified as the input parameter.

    ![](media/image7.png){width="6.5in" height="0.8152777777777778in"}

4.  *Get Audit Trail:*

    If we need to get the “Evidence Summary” or the “Audit Trail” for a
    package we can use this method. It takes only one parameter which is
    the package id. It returns the Base64 encoded string for the
    PDF document. If we need to view the PDF document, do the Base64
    decoding on the output string and then save the file with
    .pdf extension.

    ![](media/image8.png){width="6.5in" height="0.9854166666666667in"}

5.  *Get Signing Status:*

> In order to enquire about the signing status for the package sent, we
> can use this method to know the signing status on the package. The
> only method argument to be passed is the package id. It returns the
> signing status string.
>
> ![](media/image9.png){width="6.5in" height="0.9048611111111111in"}

1.  *Set Package Status:*

> We can change the package status (for example from DRAFT to SENT etc)
> using this method. We need to pass the package id and the Package
> Status enumerated value as the input parameters to this method. The
> valid values for the Package Status are in the ESignLiveAPIObjects
> class.
>
> ![](media/image10.png){width="6.5in" height="1.1229166666666666in"}

**Documents**
-------------

1.  *Create Documents:*

> Once a package is created without any documents, we can add the
> documents at a later point of time. We can use this method to create
> the documents with the existing package. *(If you need to create the
> package along with the documents, please see the createPackage method
> with the Package and the Map Document Blobs method).*
>
> This method takes two input arguments. First parameter is the existing
> package id and the second is the Map of Document Blobs.
>
> ![](media/image11.png){width="6.5in" height="1.0319444444444446in"}

1.  *Download Document:*

    Using this method, we can download the existing documents in
    a package. We would need to pass the id of the Package where the
    document exists and the id of the Document to be downloaded to
    the method. It would return the document Blob.

    ![](media/image12.png){width="6.5in" height="1.1229166666666666in"}

2.  *Update Document: *

    Update an existing document. This method takes Id of the Package
    where the document is present, Id of the Document to be updated, and
    the Document object as the input parameters.

    ![](media/image13.png){width="6.5in" height="0.8430555555555556in"}

3.  *Delete Document: *

> Use this method to delete an existing document. It takes Id of the
> Package where the document is present, Id of the Document to be
> deleted as the input parameters.
>
> ![](media/image14.png){width="6.458333333333333in"
> height="1.0416666666666667in"}

**Roles/Signers**
-----------------

1.  *Create Role:*

    In order to create the signers, who do the signing on the documents,
    we would need to use this addRole method. The input parameters for
    this method are the first name of the signer, last name of the
    signer, email of the signer, a Boolean value (true or false) for
    specifying if the signer has the ability to delegate someone else
    for doing the signing on their behalf (true) or not (false), and the
    Id of the existing Package where you would like to create
    the signer.

    ![](media/image15.png){width="6.5in" height="4.626388888888889in"}

2.  *Get Role:*

    Get the existing signer information using this method. This method
    takes the following parameters:

-   Id of the Package in which the Role/Signer exists

-   Id of the Role

> ![](media/image16.png){width="6.5in" height="0.9819444444444444in"}

1.  *Update Role:*

    Update the existing Role information. This method takes the
    following parameters:

-   Id of the Package in which the Role/Signer exists

-   Id of the Role to be updated

-   The role object with the Role information to be updated

> ![](media/image17.png){width="6.5in" height="1.2909722222222222in"}

1.  *Delete Role:*

    This method deletes the role specified. It takes the following
    parameters:

-   Id of the Package in which the Role/Signer exists

-   Id of the Role to be deleted.

![](media/image18.png){width="6.5in" height="1.0208333333333333in"}

1.  *Set Role Authentication (SMS, Q&A or Email):*

    Use the safeSetAuth method to set the authentication required for
    the Signer in order to do the signing. There are three
    authentication mechanisms supported by eSignLive. One is Email which
    is the default way of authenticating. Second is the Question and
    Answer mechanism. And the third is the SMS.

    When creating role/signer using the addRole method, the Signer is
    created with the default Email authentication scheme. If you need to
    change it, you can use this method by passing following parameters

-   Id of the Package in which the Signer exists.

-   Id of the Role (please note that this the Role Id not the Signer Id.
    Role contains the Signer information).

-   Authentication Scheme \[NONE, CHALLENGE, SMS\]

-   Challenges List. \[Each Challenge contains Question, Answer
    and MaskInput\]. We need not require this if we choose the
    Authentication Scheme as NONE.

![](media/image19.png){width="6.5in" height="4.979166666666667in"}

1.  *Set Attachment Requirements:*

    If we need to have the Signer upload a document in order to complete
    the signing process, we can use this method to set the list of
    required attachments for a particular Signer.

    We would need to pass the id of the Package, id of the Role, and the
    list of attachment requirement objects.

    ![](media/image20.png){width="6.5in" height="3.029166666666667in"}

2.  *Download all attachments for the Signer:*

    In order to view/download all of the attachments which were uploaded
    by a Signer, use this method. This method takes two parameters. One
    is the id of the Package and second is the id of the Role who has
    uploaded the attachments we need.

    The output is the Base4 encoded string of the zip file of the
    attachments for a particular signer.

    ![](media/image21.png){width="6.5in" height="1.2791666666666666in"}

3.  *Set Signing Order for the Role:*

> By default, all the signers in a Package can sign the documents in
> Parallel. However, if we need to have the signers sign one after
> another in a sequential order, then we can set the signing order for
> the roles. Use the setSigningOrder method to set the signing order.

It takes the following three parameters as input.

-   The id of the package in which we need the signing order.

-   The id of the role for which we set the signing sequence number.

-   The index or the signing sequence number of the Signer. (Please note
    that it would set the signing sequence numbers for the other Signers
    too in the Package).

> ![](media/image22.png){width="6.5in" height="3.245138888888889in"}

1.  *Get Signing URL for the Role:*

    The method getSigingUrl returns the signing URL for the Package Id
    and the Role specified.

    ![](media/image23.png){width="6.5in" height="1.2819444444444446in"}

2.  *Delegate the signing authority to other Signer:*

> If the Role is created with the ability to re-assign the Signer, the
> Signer can delegate the signing authority to another person. We would
> need the following input parameters to do the delegation.

-   Id of the Package

-   Id of the Role for whom the delegation is about to happen.

-   First name of the new Signer

-   Last name of the new Signer

-   Email of the new Signer

-   Optional message to the new Signer

    Please note that the delegation is only allowed if the current
    signer has the permission to change the signer and the package must
    be sent to the signers before this is allowed.

    ![](media/image24.png){width="6.5in" height="5.4944444444444445in"}

**\
**

**Signatures/Approvals**
------------------------

1.  *Create Signature:*

    Use this method to create the signature place holders on
    the document. The following are the input parameters which are
    needed in order to add the signature field on the document.

-   Id of the Package in which the Document exists.

-   Id of the Document on which we need the signature place holder.

-   Approval object.

    ![](media/image25.png){width="6.5in" height="1.3368055555555556in"}

    *Please note that you can create the signatures using the text
    anchors only when you are creating the package or the documents. You
    can’t use text anchors when adding the signatures at a later point
    of time. Please see the createPackageWithDocumentsExample method in
    the Examples class on how to use the text anchors when creating
    the package.*

1.  *Get Signature:*

    Get the existing signature place holders’ information on a
    specific document. This getApproval method takes the following
    parameters:

-   Id of the Package in which the Document exists.

-   Id of the Document where the signature place holder exists.

-   Id of the Signature place holder

    ![](media/image26.png){width="6.5in" height="0.9347222222222222in"}

1.  *Update Signature:*

    Modify an existing approval using this updateApproval method. This
    method takes the following parameters:

-   Id of the Package in which the Document exists.

-   Id of the Document where the signature place holder exists.

-   Id of the Signature place holder

-   The approval object with the new information

> ![](media/image27.png){width="6.5in" height="0.8986111111111111in"}

1.  *Delete Signature: *

    Use this method deleteApproval to delete an existing
    approval/signature place holder on the document. This method takes
    the following parameters:

-   Id of the Package in which the Document exists.

-   Id of the Document where the signature place holder exists.

-   Id of the Signature place holder

> ![](media/image28.png){width="6.479166666666667in"
> height="1.1770833333333333in"}

**Troubleshooting**
-------------------

The following would help in resolving the common issues with the SDK
setup.

1.  *Custom Setting Issues:*

> In order to make the callouts to the e-SignLive system, we would need
> the e-SignLive endpoint and the API key.
>
> Please ensure that we have a Custom Setting with the API name
> “e\_SignLive\_Connection\_Settings\_\_c” in the org and it has the
> following fields in it:

-   Endpoint\_\_c

-   API\_Key\_\_c

> ![](media/image29.png){width="6.5in" height="2.423611111111111in"}
>
> ![](media/image30.png){width="6.5in" height="2.9305555555555554in"}
>
> Once we have the Custom Setting in place, we would need to ensure that
> we have a record in the above defined Custom Setting with a name as
> “Main”. If you don’t have a record in the Custom Setting, go the
> Custom Setting Detail page and click on “Manage”. Then in the page
> click on “New” and enter the Name as “Main” without the quotes and
> then enter your e-SignLive endpoint and the API key in the appropriate
> fields and click on Save.
>
> *Please note that for Production (integrated license), API key will be
> emailed upon account creation.*
>
> ![](media/image31.png){width="6.5in" height="1.9979166666666666in"}
>
> ![](media/image32.png){width="6.5in" height="2.5194444444444444in"}

1.  *Remote Site Setting Issues:*

    In order to do the callouts from Salesforce, we would need to add
    the remote site endpoint (in this case the e-SignLive sandbox or
    Prod instance URL) to the “Remote Site Settings” of the Salesforce
    org from which we intend to use the SDK.

    Once you add the Remote Site, ensure that it is marked as “Active”.

2.  This package can be installed to developer or test sandboxes only.
    Please use standard metadata migration tools like Change sets,
    Force.com ANT migration tool etc. to move the data to Production.

**UML Diagram for the SDK**
---------------------------

![](media/image33.png){width="7.9375in" height="7.0993055555555555in"}
