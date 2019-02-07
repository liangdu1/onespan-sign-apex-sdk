/**
 * Class Name: OneSpanDocumentUtilities.cls*
 * This class contains method used for encoding documents for sending
 * to OneSpan.
 */

public with sharing class OneSpanDocumentUtilities
{
    public OneSpanDocumentUtilities(){}

    /**
     * Method to encode documents passed in the documentMap
     */
    public static List<String> encodeDocuments(Map<String,Blob> documentMap, String boundary, String name)
    {
        String bodyEncoded = '';
        String last4Bytes = '';
        String footerEncoded ='';
        String headerPlusBodyEncoded = '';
        String headerEncoded = '';
        String newLine = '';
        String newLineEncoded = '';
        String footer = '--' + boundary + '--';             

        for(String fileName : documentMap.keySet())
        {    
            String header = '' ;
            header =  '--' + boundary + '\nContent-Disposition: form-data; name="'+name+'"; filename="' + fileName +'"\nContent-Type: application/pdf';    

            headerEncoded = encodeString(header);
            newLineEncoded = encodeString(newLine);
            bodyEncoded = EncodingUtil.base64Encode(documentMap.get(fileName));

            last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());                    
            if(last4Bytes.endsWith('==')) 
            {
                last4Bytes = last4Bytes.substring(0,2) + '0K';
                bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;                
                footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            }
            else if(last4Bytes.endsWith('=')) 
            {
                last4Bytes = last4Bytes.substring(0,3) + 'N';
                bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;                
                footer = '\n' + footer;
                footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            }
            else 
            {
                footer = '\r\n' + footer;
                footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            }

            if(String.isBlank(headerPlusBodyEncoded))
            {
                headerPlusBodyEncoded = headerEncoded + bodyEncoded ;
            }
            else
            {
                headerPlusBodyEncoded = headerPlusBodyEncoded + newLineEncoded + headerEncoded + bodyEncoded ;    
            }
        }

        return new List<String> {headerPlusBodyEncoded,footerEncoded};
    }

    /** 
     * Method to endocde the string passed
     */
    public static String encodeString(String stringToEncode)
    {
        String encodedString = EncodingUtil.base64Encode(Blob.valueOf(stringToEncode + '\r\n\r\n'));
        while(encodedString.endsWith('='))
        {
            stringToEncode += ' ';
            encodedString = EncodingUtil.base64Encode(Blob.valueOf(stringToEncode+'\r\n\r\n'));
        }
        return encodedString;
    }

    /**
     * Method to encode the content passed
     */
    public static String encodeContent(String content)
    {
        String contentEncoded = EncodingUtil.base64Encode(Blob.valueOf(content + '\r\n'));
        String last4BytesForContent = contentEncoded.substring(contentEncoded.length()-4,contentEncoded.length());
        if(contentEncoded.endsWith('=='))
        {
            last4BytesForContent = last4BytesForContent.substring(0,2) + '0K';
            
            contentEncoded = contentEncoded.substring(0,contentEncoded.length()-4) + last4BytesForContent;
        }
        else if( last4BytesForContent.endsWith('=')) 
        {
            last4BytesForContent =  last4BytesForContent.substring(0,3) + 'N';
            contentEncoded = contentEncoded.substring(0,contentEncoded.length()-4) + last4BytesForContent;
        }

        return contentEncoded;
    }

}