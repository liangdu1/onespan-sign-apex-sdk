# Apex SDK for OneSpan

![kadence]                 |  ![onespan]
:-------------------------:|:-------------------------:

Developed by [Kadence Collective](http://hirekadence.com), this SDK allows you to integrate with OneSpan's REST API using Apex.  Examples on how to use the SDK are included in the OneSpanExamples class.

To get started, you'll need to create a free developer account [here](http://bit.ly/2wamkvq).

Documentation for the SDK can be accessed [here](http://bit.ly/2uN6Rlz).

For help, use OneSpan's [Developer Community](http://bit.ly/2uJz52e).

## Installation and Configuration
The SDK can be installed using the <a href="https://githubsfdeploy.herokuapp.com?owner=KadenceCollective&repo=esignlive-apex-sdk">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a> button.

Alternatively, it can be installed as an unmanaged package:
* [Production/Developer Sandbox](	https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1C0000011MJ2)
* [Test Sandbox](	https://test.salesforce.com/packaging/installPackage.apexp?p0=04t1C0000011MJ2)

After installing in your sandbox or developer org you'll need to configure the connection settings by creating an entry in the OneSpan Connection Settings custom setting.

**Name** = Main  
**Endpoint** = https://sandbox.e-signlive.com/api (SANDBOX) || https://apps.e-signlive.com/api (PROD)  
**API Key** = YOUR_API_KEY - can be obtained by going to the Account page in your OneSpan Sandbox.  For production accounts it should be emailed to you upon account creation.

## SDK Methods
The following methods are included in the current version of the SDK:

**Packages**
* Create Package
* Create Package with Binaries
* Get Package
* Update Package
* Delete Package
* Get Audit Trail
* Get Signing Status
* Set Package Status

**Documents**
* Create Documents
* Download Document
* Update Document
* Delete Document

**Roles/Signers**
* Create Role
* Get Role
* Update Role
* Delete Role
* Set Role Authentication
* Set Attachment Requirements
* Download All Attachments for Signer
* Set Signing Order for Role
* Get Signing Url for Role

**Signatures/Approvals**
* Create Signature
* Get Signature
* Update Signature
* Delete Signature

##License##
This OneSpan Apex SDK is released under the following [license](/LICENSE).

[onespan]: https://i.imgur.com/PGpgbGB.png "OneSpan logo"
[kadence]: https://i.imgur.com/IgbJMbD.png "Kadence Collective Logo"
