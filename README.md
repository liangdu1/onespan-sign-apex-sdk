# Apex SDK for OneSpan

  ![onespan]

This SDK allows you to integrate with OneSpan's REST API using Apex.  Examples on how to use the SDK are included in the OneSpanExamples class.

To get started, you'll need to create a free developer account [here](http://bit.ly/2wamkvq).

Documentation for the SDK can be accessed [here](http://bit.ly/2uN6Rlz).

For help, use OneSpan's [Developer Community](http://bit.ly/2uJz52e).

## Installation and Configuration

### Option1 Install via GitHub Salesforce Deploy Tool

The SDK can be installed using the <a href="https://githubsfdeploy.herokuapp.com?owner=OneSpan&repo=onespan-sign-apex-sdk">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a> button.

### Option2 Install via Salesforce Workbench 
To deploy manually via Salesforce Workbench, first download or clone the master branch of this repository to your local machine, then compress the src/ folder into a file named src.zip. Next, go to https://workbench.developerforce.com, log in to your Salesforce org, navigate to Migration > Deploy, upload the src.zip, then proceed with the deployment.

---

After installing in your sandbox or developer org you'll need to configure the connection settings by creating an entry in the OneSpan Connection Settings custom setting.

**Name** = Main  
**Endpoint** = https://sandbox.esignlive.com/api (SANDBOX) || https://apps.esignlive.com/api (PROD)  
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



## Reserved Keywords
Due to Salesforce's internal keyword handling and the custom serialization logic in this SDK, the following keywords are considered reserved and will be rewritten to avoid conflicts during payload construction:

`enum` `from` `group` `NEW` `PACKAGE` `_x` `_X`

Avoid including reserved words in your transaction name, template name, transaction description, role ID, or other outbound fields, as this may lead to unexpected API behavior or failure.


---

##License##
This OneSpan Apex SDK is released under the following [license](/LICENSE).

[onespan]: https://i.imgur.com/PGpgbGB.png "OneSpan logo"
