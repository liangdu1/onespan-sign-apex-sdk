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



## Reserved Identifiers and JSON Mapping
To avoid conflicts with Salesforce reserved words, this SDK rewrites only a few specific JSON fields. The JSON keys `enum`, `from`, and `group` are mapped to `enum_x`, `from_x`, and `group_x` in Apex, and mapped back to their original names when sending data to the API.

For JSON values, only `status: "NEW"` and `type: "PACKAGE"` are mapped to the internal enum values `NEW_X` and `PACKAGE_X` (and back again on outbound). Other uses of these Apex reserved words (for example, `"NEW"`, `"PACKAGE"`, `"from"` in IDs, names, descriptions, or signing links) are not changed by the helper and are safe to use.

---

##License##
This OneSpan Apex SDK is released under the following [license](/LICENSE).

[onespan]: https://i.imgur.com/PGpgbGB.png "OneSpan logo"
