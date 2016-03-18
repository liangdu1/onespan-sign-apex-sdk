# Apex SDK for eSignLive
This SDK allows you to integrate with eSignLive's REST API using Apex.  Examples on how to use the SDK are included in the ESignLiveExamples class.

To get started, you'll need to create a free developer account [here](https://www.esignlive.com/partners-and-apps/sandbox-account-creation/?_ga=1.248624133.38793117.1457297517).

Documentation for the SDK can be accessed [here](https://github.com/KadenceCollective/esignlive-apex-sdk/wiki/SDK-Documentation).

For help, use eSignLive's [Developer Community](https://developer.esignlive.com/).

## Installation and Configuration
The SDK can be installed using the <a href="https://githubsfdeploy.herokuapp.com?owner=KadenceCollective&repo=esignlive-apex-sdk">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a> button.

Alternatively, it can be installed as an unmanaged package:
* [Production/Developer Sandbox](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t15000000Kooq)
* [Test Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t15000000Kooq)

After installing in your sandbox or developer org you'll need to configure the connection settings by creating an entry in the eSignLive Connection Settings custom setting.

**Name** = Main  
**Endpoint** = https://sandbox.e-signlive.com/api (SANDBOX) || https://apps.e-signlive.com/api (PROD)  
**API Key** = YOUR_API_KEY - can be obtained by going to the Account page in your eSignLive Sandbox.  For production accounts it should be emailed to you upon account creation.

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
This eSignLive Apex SDK is released under the following [license](/LICENSE).
