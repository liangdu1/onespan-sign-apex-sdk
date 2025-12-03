/**
 * Class Name: OneSpanJSONHelper.cls*
 * Class that contains helper methods for working with JSON
 * requests and responses
 */

public with sharing class OneSpanJSONHelper
{
    /**
     * Method to prepare outbound JSON including:
     *  - mapping Apex-safe field names back to API field names
     *    (e.g. enum_x -> enum, from_x -> from, group_x -> group)
     *  - mapping Apex-safe enum values back to API values
     *    (e.g. NEW_X -> NEW, PACKAGE_X -> PACKAGE)
     *  - removing null properties and values
     */
    public static String prepareOutboundJSON(String jsonString)
    {
        if(String.isNotEmpty(jsonString))
        {
            // Map internal property names back to API-safe keys
            jsonString = replacePropertyName(jsonString, 'enum_x', 'enum');
            jsonString = replacePropertyName(jsonString, 'from_x', 'from');
            jsonString = replacePropertyName(jsonString, 'group_x', 'group');

            // Map internal enum values back to API values
            jsonString = replaceEnumValue(jsonString, 'status', 'NEW_X', 'NEW');          // MessageStatus
            jsonString = replaceEnumValue(jsonString, 'type',   'PACKAGE_X', 'PACKAGE');  // PackageType

            // Remove null properties
            jsonString = removeNullProperties(jsonString);
        }

        return jsonString;
    }

    /**
     * Method to prepare inbound JSON including:
     *  - mapping API field names to Apex-safe field names
     *    (e.g. enum -> enum_x, from -> from_x, group -> group_x)
     *  - mapping API enum values to Apex-safe enum values
     *    (e.g. NEW -> NEW_X, PACKAGE -> PACKAGE_X)
     *  - removing null properties and values
     */
    public static String prepareInboundJSON(String jsonString)
    {
        if(String.isNotEmpty(jsonString))
        {
            // Property-name mappings (keys)
            jsonString = replacePropertyName(jsonString, 'enum',  'enum_x');
            jsonString = replacePropertyName(jsonString, 'from',  'from_x');
            jsonString = replacePropertyName(jsonString, 'group', 'group_x');

            // Enum value mappings (values)
            jsonString = replaceEnumValue(jsonString, 'status', 'NEW',     'NEW_X');      // MessageStatus
            jsonString = replaceEnumValue(jsonString, 'type',   'PACKAGE', 'PACKAGE_X');  // PackageType

            // Remove null properties
            jsonString = removeNullProperties(jsonString);
        }

        return jsonString;
    }

    /**
     * Helper to replace a JSON property name
     */
    private static String replacePropertyName(String jsonString, String original, String replacement)
    {
        if(String.isEmpty(jsonString))
        {
            return jsonString;
        }

        // with optional whitespace before the colon
        String regex = '"' + original + '"\\s*:';
        String repl  = '"' + replacement + '":';

        return jsonString.replaceAll(regex, repl);
    }

    /**
     * Helper to replace a JSON enum value for a specific property.
     * Example: "status":"NEW" -> "status":"NEW_X"
     */
    private static String replaceEnumValue(String jsonString, String propName, String fromValue, String toValue)
    {
        if(String.isEmpty(jsonString))
        {
            return jsonString;
        }

        // with optional whitespace before the colon
        String regex = '"' + propName + '"\\s*:\\s*"' + fromValue + '"';
        String replacement = '"' + propName + '":"' + toValue + '"';

        return jsonString.replaceAll(regex, replacement);
    }

    /**
     * Method to remove null properties and values using regex.
     */
    private static String removeNullProperties(String jsonString)
    {
        if(String.isNotEmpty(jsonString))       
        {
            jsonString = jsonString.replaceAll('\"[^\"]*\" *: *null *, *','');
            jsonString = jsonString.replaceAll('\"[^\"]*\" *: *null *','');
            jsonString = jsonString.replaceAll(',{2,}', ',');
            jsonString = jsonString.replace('{,', '{');
            jsonString = jsonString.replace(',}', '}');
            jsonString = jsonString.replace('[,', '[');
            jsonString = jsonString.replace(',]', ']');
        }
    
        return jsonString;
    }
}