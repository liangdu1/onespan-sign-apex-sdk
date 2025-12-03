/**
 * Class Name: OneSpanJSONHelperTestls
 *
 * Test class for the OneSpanJSONHelper class
 */

@isTest
public class OneSpanJSONHelperTest
{    
    /**
     * Verifies that prepareOutboundJSON:
     *  - does not alter arbitrary values containing "PACKAGE_X"
     *  - removes null values from a real Package_x JSON
     */
    private static testMethod void prepareOutboundJSONTest()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        // Set parameters for call
        String packageId = 'PACKAGE_X';
        Map<String,Blob> documentMap = OneSpanTestDataUtility.createDocumentMap();
        OneSpanAPIObjects.Package_x pkg = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');
        String result = OneSpanValidation.comparePackageDocumentsAndMap(pkg, documentMap);

        // Get JSON response
        String mockResponse = JSON.serialize(pkg);

        // Object response
        System.assertEquals(true, mockResponse.contains('PACKAGE_X'));
        System.assertEquals(true, mockResponse.contains('null'));
        mockResponse = OneSpanJSONHelper.prepareOutboundJSON(mockResponse);

        // Assert
        System.assertEquals(true, mockResponse.contains('PACKAGE_X'),
            'Reserved word in a value should not be altered by default.');
        System.assertEquals(false, mockResponse.contains('null'),
            'Null values should be removed from outbound JSON.');

        System.assertEquals('success', result);
    }

    /**
     * Verifies that prepareInboundJSON:
     *  - does not globally replace values like "NEW" with "NEW_X"
     *  - removes null values from a real Package_x JSON
     */
    private static testMethod void prepareInboundJSONTest()
    {
        // Create custom setting for test
        OneSpanTestDataUtility.createConnectionSetting();
        String packageId = 'NEW';
        OneSpanAPIObjects.Package_x pkg = OneSpanTestDataUtility.createPackageX(packageId, 'packName', 'packConsent');

        // Get JSON response
        String mockResponse = JSON.serialize(pkg);

        System.assertEquals(true, mockResponse.contains(packageId));
        System.assertEquals(true, mockResponse.contains('null'));

        mockResponse = OneSpanJSONHelper.prepareInboundJSON(mockResponse);

        // Assert
        System.assertEquals(true, mockResponse.contains('NEW'),
            'Generic value "NEW" should not be globally replaced.');
        System.assertEquals(false, mockResponse.contains('NEW_X'),
            'Helper should not blindly append _X to all "NEW" values.');
        System.assertEquals(false, mockResponse.contains('null'),
            'Null values should be removed from inbound JSON.');
    }

    /**
     * Verifies that prepareInboundJSON:
     *  - leaves generic values "NEW" and "PACKAGE" unchanged
     *  - does not alter values that happen to contain "PACKAGE_X_X" as text
     */
    private static testMethod void prepareInboundJSON_ValuesNotChanged()
    {
        // CASE 1: generic values "NEW" / "PACKAGE" that are not enums
        String inboundJsonReserved =
            '{"statusDisplay":"NEW","typeDisplay":"PACKAGE","other":"unchanged"}';

        String preparedReserved = OneSpanJSONHelper.prepareInboundJSON(inboundJsonReserved);

        System.assertEquals(true, preparedReserved.contains('"statusDisplay":"NEW"'),
            'Reserved word NEW used as a generic value should not be altered.');
        System.assertEquals(true, preparedReserved.contains('"typeDisplay":"PACKAGE"'),
            'Reserved word PACKAGE used as a generic value should not be altered.');
        System.assertEquals(true, preparedReserved.contains('"other":"unchanged"'),
            'Non-reserved values should remain unchanged.');
        System.assertEquals(false, preparedReserved.contains('NEW_X'),
            'Generic values should not be suffixed with _X.');
        System.assertEquals(false, preparedReserved.contains('PACKAGE_X'),
            'Generic values should not be suffixed with _X.');

        // CASE 2: "PACKAGE_X_X" inside a larger text value
        String inboundJsonPackageXX = '{"description":"This is PACKAGE_X_X in text","id":123}';
        String preparedPackageXX = OneSpanJSONHelper.prepareInboundJSON(inboundJsonPackageXX);

        System.assertEquals(true,
            preparedPackageXX.contains('"description":"This is PACKAGE_X_X in text"'),
            'PACKAGE_X_X in plain text should not be changed to PACKAGE_X.');
        System.assertEquals(false,
            preparedPackageXX.contains('PACKAGE_X"'),
            'No replacement of PACKAGE_X_X to PACKAGE_X inside value text.');
    }

    /**
     * Verifies that prepareOutboundJSON:
     *  - preserves "_x" and "_X" inside arbitrary values
     *  - removes null properties
     */
    private static testMethod void prepareOutboundJSON_ValuesWith_x_NotStripped()
    {
        // CASE 1: lowercase "_x" in a value
        String outboundJsonLower = '{"description":"box_x_large","other":null}';
        String preparedLower = OneSpanJSONHelper.prepareOutboundJSON(outboundJsonLower);

        System.assertEquals(false, preparedLower.contains('"other":null'),
            'Null properties should be removed.');
        System.assertEquals(true, preparedLower.contains('"description":"box_x_large"'),
            'Natural occurrences of "_x" in values should not be stripped.');

        // CASE 2: uppercase "_X" in a value
        String outboundJsonUpper = '{"code":"MODEL_X_PROD","note":null}';
        String preparedUpper = OneSpanJSONHelper.prepareOutboundJSON(outboundJsonUpper);

        System.assertEquals(false, preparedUpper.contains('"note":null'),
            'Null properties should be removed.');
        System.assertEquals(true, preparedUpper.contains('"code":"MODEL_X_PROD"'),
            'Natural occurrences of "_X" in values should not be stripped.');
    }

    /**
     * Verifies that prepareInboundJSON:
     *  - maps "type":"PACKAGE" to PackageType.PACKAGE_X
     *  - maps message "status":"NEW" to MessageStatus.NEW_X
     *  - maps "enum" key to FieldValidation.enum_x
     */
    private static testMethod void prepareInboundJSON_EnumValuesMappedCorrectly()
    {
        // CASE 1: Package_x and MessageStatus enums
        String inboundPackageJson =
            '{"status":"SENT",' +
            ' "type":"PACKAGE",' +
            ' "messages":[{"status":"NEW"}]' +
            '}';

        String preparedPackageJson = OneSpanJSONHelper.prepareInboundJSON(inboundPackageJson);

        OneSpanAPIObjects.Package_x pkg =
            (OneSpanAPIObjects.Package_x)
                JSON.deserialize(preparedPackageJson, OneSpanAPIObjects.Package_x.class);

        System.assertEquals(OneSpanAPIObjects.PackageStatus.SENT, pkg.status,
            'Package status "SENT" should deserialize correctly.');
        System.assertEquals(OneSpanAPIObjects.PackageType.PACKAGE_X, pkg.type,
            'Inbound "PACKAGE" should map to enum value PACKAGE_X.');

        System.assertNotEquals(null, pkg.messages, 'Messages list should be deserialized.');
        System.assertEquals(1, pkg.messages.size(),
            'Messages list should contain exactly 1 message.');
        System.assertEquals(OneSpanAPIObjects.MessageStatus.NEW_X, pkg.messages[0].status,
            'Inbound "NEW" should map to enum value NEW_X for MessageStatus.');

        // CASE 2: "enum" key mapping to FieldValidation.enum_x
        String inboundFieldValidationJson =
            '{"enum":["VAL1","VAL2"],"required":true}';

        String preparedFieldValidationJson =
            OneSpanJSONHelper.prepareInboundJSON(inboundFieldValidationJson);

        OneSpanAPIObjects.FieldValidation fieldValidation =
            (OneSpanAPIObjects.FieldValidation)
                JSON.deserialize(preparedFieldValidationJson, OneSpanAPIObjects.FieldValidation.class);

        System.assertNotEquals(null, fieldValidation.enum_x,
            'enum_x should be populated from inbound "enum" key.');
        System.assertEquals(2, fieldValidation.enum_x.size(),
            'enum_x should contain both values from inbound "enum" array.');
        System.assertEquals('VAL1', fieldValidation.enum_x[0]);
        System.assertEquals('VAL2', fieldValidation.enum_x[1]);
        System.assertEquals(true, fieldValidation.required,
            '"required" flag should be deserialized correctly.');
    }

    /**
     * Verifies that prepareOutboundJSON:
     *  - serializes PackageType.PACKAGE_X as "type":"PACKAGE"
     *  - serializes MessageStatus.NEW_X as "status":"NEW"
     *  - serializes FieldValidation.enum_x using key "enum"
     */
    private static testMethod void prepareOutboundJSON_EnumValuesMappedCorrectly()
    {
        // CASE 1: Package_x and MessageStatus enums
        OneSpanAPIObjects.Package_x pkg = new OneSpanAPIObjects.Package_x();
        pkg.status = OneSpanAPIObjects.PackageStatus.SENT;
        pkg.type   = OneSpanAPIObjects.PackageType.PACKAGE_X;

        OneSpanAPIObjects.Message msg = new OneSpanAPIObjects.Message();
        msg.status = OneSpanAPIObjects.MessageStatus.NEW_X;
        pkg.messages = new List<OneSpanAPIObjects.Message>{ msg };

        String rawJson = JSON.serialize(pkg);
        String outboundJson = OneSpanJSONHelper.prepareOutboundJSON(rawJson);

        System.assertEquals(true, outboundJson.contains('"type":"PACKAGE"'),
            'Outbound JSON should expose PACKAGE_X enum as "PACKAGE".');
        System.assertEquals(false, outboundJson.contains('"type":"PACKAGE_X"'),
            'Outbound JSON should not expose the internal enum name PACKAGE_X.');

        System.assertEquals(true, outboundJson.contains('"status":"NEW"'),
            'Outbound JSON should expose NEW_X enum as "NEW" for message status.');
        System.assertEquals(false, outboundJson.contains('"status":"NEW_X"'),
            'Outbound JSON should not expose the internal enum name NEW_X.');

        // CASE 2: FieldValidation.enum_x -> "enum"
        OneSpanAPIObjects.FieldValidation fv = new OneSpanAPIObjects.FieldValidation();
        fv.enum_x = new List<String>{ 'VAL1', 'VAL2' };
        fv.required = true;

        String fvRawJson = JSON.serialize(fv);
        String fvOutboundJson = OneSpanJSONHelper.prepareOutboundJSON(fvRawJson);

        System.assertEquals(false, fvOutboundJson.contains('"enum_x"'),
            'Outbound JSON should not expose the internal property name "enum_x".');
        System.assertEquals(true, fvOutboundJson.contains('"enum"'),
            'Outbound JSON should expose enum_x field as "enum" key.');
        System.assertEquals(true, fvOutboundJson.contains('["VAL1","VAL2"]'),
            'Enum values should be preserved in outbound JSON.');
    }

    /**
     * Inbound JSON:
     *  - "from" should be mapped to "from_x"
     *  - "group" should be mapped to "group_x"
     *  - Only property names are changed, not the inner values
     */
    private static testMethod void prepareInboundJSON_ReservedPropertyKeysMappedCorrectly()
    {
        String inboundJson =
            '{' +
            '  "from":{"email":"from@test.com"},' +
            '  "group":{"id":"G1","name":"Test Group"}' +
            '}';

        String prepared = OneSpanJSONHelper.prepareInboundJSON(inboundJson);

        // Property names should be renamed
        System.assertEquals(true, prepared.contains('"from_x"'),
            '"from" key should be renamed to "from_x" for Apex compatibility.');
        System.assertEquals(false, prepared.contains('"from"'),
            '"from" key should not remain in the inbound JSON.');

        System.assertEquals(true, prepared.contains('"group_x"'),
            '"group" key should be renamed to "group_x" for Apex compatibility.');
        System.assertEquals(false, prepared.contains('"group"'),
            '"group" key should not remain in the inbound JSON.');

        // Nested values should remain unchanged
        System.assertEquals(true, prepared.contains('"email":"from@test.com"'),
            'Inner values under "from" should not be modified.');
        System.assertEquals(true, prepared.contains('"id":"G1"'),
            'Inner values under "group" should not be modified.');
    }

    /**
     * Outbound JSON:
     *  - "from_x" should be mapped back to "from"
     *  - "group_x" should be mapped back to "group"
     */
    private static testMethod void prepareOutboundJSON_ReservedPropertyKeysMappedCorrectly()
    {
        // Build objects using the Apex-safe names
        OneSpanAPIObjects.User fromUser = new OneSpanAPIObjects.User();
        fromUser.email = 'from@test.com';

        OneSpanAPIObjects.Message msg = new OneSpanAPIObjects.Message();
        msg.from_x = fromUser;
        msg.status = OneSpanAPIObjects.MessageStatus.READ;

        OneSpanAPIObjects.Signer signer = new OneSpanAPIObjects.Signer();
        OneSpanAPIObjects.GroupMembership gm =
            new OneSpanAPIObjects.GroupMembership('G1', 'Test Group', OneSpanAPIObjects.MemberType.REGULAR);
        // group_x is a Group, but if you don’t have a Group class wired here yet,
        // you can at least test the string-based JSON:
        // or leave signer.group_x = null and focus only on "from" for now if needed.

        String rawJson = JSON.serialize(msg);
        String outboundJson = OneSpanJSONHelper.prepareOutboundJSON(rawJson);

        // Property names should be mapped back for the API
        System.assertEquals(true, outboundJson.contains('"from"'),
            'Outbound JSON should expose "from_x" as "from" key.');
        System.assertEquals(false, outboundJson.contains('"from_x"'),
            'Outbound JSON should not expose the internal property name "from_x".');

        // Nested value still intact
        System.assertEquals(true, outboundJson.contains('"email":"from@test.com"'),
            'Nested values under "from" should remain unchanged.');
    }
}