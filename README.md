# Apex SDK for eSignLive
This SDK allows you to integrate with eSignLive's REST API using Apex.  Examples on how to use the SDK are included in the ESignLiveExamples class.

To get started, you'll need to create a free developer account [here](https://www.esignlive.com/partners-and-apps/sandbox-account-creation/?_ga=1.248624133.38793117.1457297517).

For documentation and help use eSignLive's [Developer Community](https://developer.esignlive.com/).

## Installation and Configuration
The SDK can be installed using the <a href="https://githubsfdeploy.herokuapp.com?owner=KadenceCollective&repo=esignlive-apex-sdk">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a> button.

After installing in your sandbox or developer org you'll need to configure the connection settings by creating an entry in the eSignLive Connection Settings custom setting.

**Name** = Main  
**Endpoint** = https://sandbox.e-signlive.com/api (SANDBOX) || https://apps.e-signlive.com/api (PROD)  
**API Key** = YOUR_API_KEY - can be obtained by going to the Account page in your eSignLive Sandbox.  For production accounts it should be emailed to you upon account creation.

insert image here
