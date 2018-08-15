/**
 * Class Name: OneSpanJSONHelper.cls*
 * Class that contains helper methods for working with JSON
 * requests and responses
 */

public with sharing class OneSpanJSONHelper
{
    /**
     * Method to prepare outbound JSON to include removing _x
     * values and removing null properties and values
     */
    public static String prepareOutboundJSON(String jsonString)
    {
        if(String.isNotEmpty(jsonString))
        {
            jsonString = remove_x(jsonString);
            jsonString = removeNullProperties(jsonString);
        }

        return jsonString;
    }

    /**
     * Method to replace inbound values using the getInboundReplacementMap method
     * This is needed to handle reserved words in Apex
     */
    public static String prepareInboundJSON(String jsonString)
    {
        if(String.isNotEmpty(jsonString))
        {
            Map<String, String> inboundReplacementMap = getInboundReplacementMap();
            for(String key : inboundReplacementMap.keySet())
            {
                if(jsonString.contains(key))
                {
                    jsonString = jsonString.replace(key, inboundReplacementMap.get(key));
                }
            }
        }
        jsonString = removeNullProperties(jsonString);
        return jsonString;
    }

    /**
     * Method to remove all _x values used for handling reserved words
     * in Apex
     */
    private static String remove_x(String jsonString)
    {
        if(String.isNotEmpty(jsonString))
        {
            jsonString = jsonString.replace('_x', '');
            jsonString = jsonString.replace('_X', '');
        }

        return jsonString;
    }

    /**
     * Method to remove null properties and values using regex
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

    /**
     * Method to build map for replacing inbound values to Salesforce safe values
     * This is needed to get around reserved words in Apex
     */
    private static Map<String, String> getInboundReplacementMap()
    {
        Map<String, String> inboundReplacementMap = new Map<String, String>();
        inboundReplacementMap.put('"enum"', '"enum_x"');
        inboundReplacementMap.put('"from"', '"from_x"');
        inboundReplacementMap.put('"group"', '"group_x"');
        inboundReplacementMap.put('NEW', 'NEW_X');
        inboundReplacementMap.put('PACKAGE', 'PACKAGE_X');
        inboundReplacementMap.put('PACKAGE_X_X', 'PACKAGE_X');

        return inboundReplacementMap;
    }
}