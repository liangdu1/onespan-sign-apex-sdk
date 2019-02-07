/**
 * Class Name: OneSpanValidationls
 *
 * Class handling validation for OneSpan objects
 */

public with sharing class OneSpanValidation
{
    public OneSpanValidation(){}

    /**
     * Method to validate a string value
     */
    public static void validate(String nameOfStringToValidate, String stringToValidate)
    {
        if(String.isBlank(stringToValidate))
        {
            throw new OneSpanValidationException('String can\'t be empty:'+nameOfStringToValidate);
        }
    }

    /**
     * Method to validate an integer value
     */
    public static void validate(String nameOfIntegerToValidate, Integer integerToValidate)
    {
        if(integerToValidate == null || ( !(nameOfIntegerToValidate.startsWith('ExtractAnchor')) && integerToValidate < 0) )
        {
            throw new OneSpanValidationException('Not a valid value for :'+nameOfIntegerToValidate);
        }
    }

    /**
     * Method to validate an AuthScheme
     */
    public static void validate(OneSpanAPIObjects.AuthScheme scheme)
    {
        if( scheme == null || (
            scheme != OneSpanAPIObjects.AuthScheme.NONE &&
            scheme != OneSpanAPIObjects.AuthScheme.PROVIDER &&
            scheme != OneSpanAPIObjects.AuthScheme.CHALLENGE &&
            scheme != OneSpanAPIObjects.AuthScheme.SMS))
        {
            throw new OneSpanValidationException('Not a valid Auth Scheme:'+scheme);
        }
    }

    /**
     * Method to validate an AuthChallenge
     */
    public static void validate(OneSpanAPIObjects.AuthChallenge authChallenge)
    {
            if(authChallenge == null || authChallenge.maskInput == null ||
                String.isBlank(authChallenge.answer) ||
                String.isBlank(authChallenge.question) )
            {
                try
                {
                    throw new OneSpanValidationException('Not a valid Auth Challenge:'+authChallenge);
                }
                catch(Exception e)
                {
                    throw new OneSpanValidationException('Not a valid Auth Challenge:'+authChallenge);
                }
            }
    }

    /**
     * Method to validate an AuthChallenge list
     */
    public static void validate(List<OneSpanAPIObjects.AuthChallenge> authChallengeList)
    {
        //If we have CHALLENGE or SMS as the scheme then we would need to have at least 1 AuthChallenge object in challenges list
        if(authChallengeList == null || authChallengeList.size() == 0)
        {
            throw new OneSpanValidationException('At least one Auth Challenge is needed for the scheme selected: '+authChallengeList);
        }
        
        for(OneSpanAPIObjects.AuthChallenge authChallenge : authChallengeList)
        {   
            validate(authChallenge);
        }
    }

    /**
     * Method to validate an AttachmentRequirement
     */
    public static void validate(OneSpanAPIObjects.AttachmentRequirement ar)
    {
        if(ar == null || String.isBlank(ar.name))
        {
            throw new OneSpanValidationException('Not a valid Attachment Requirement:'+ar);
        }
    }

    /**
     * Method to validate an AttachmentRequirement list
     */
    public static void validate(List<OneSpanAPIObjects.AttachmentRequirement> arList)
    {
        //If we have CHALLENGE or SMS as the scheme then we would need to have at least 1 AttachmentRequirement object in challenges list
        if(arList == null || arList.size() == 0)
        {
            throw new OneSpanValidationException('At least one Auth Challenge is needed for the scheme selected: '+arList);
        }
        
        for(OneSpanAPIObjects.AttachmentRequirement ar : arList)
        {   
            validate(ar);
        }
    }

    /**
     * Method to validate a Package
     */
    public static void validate(OneSpanAPIObjects.Package_x pkg)
    {
        if(pkg == null || String.isBlank(pkg.name))
        {
            throw new OneSpanValidationException('Not a valid Package:'+pkg);
        }
    }

    /**
     * Method to validate a blob map
     */
    public static void validate(Map<String,Blob> blobMap)
    {
        if(blobMap == null || blobMap.size() == 0)
        {
            throw new OneSpanValidationException('Not a valid Map:'+blobMap);
        }

        for(String key : blobMap.keySet())
        {
            if(String.isBlank(key))
            {
                throw new OneSpanValidationException('Not a valid key in the Map:'+blobMap);
            }
        }
    }

    /**
     * Method to validate a Package status
     */
    public static void validate(OneSpanAPIObjects.PackageStatus status)
    {
        if( status == null || (
            status != OneSpanAPIObjects.PackageStatus.DRAFT &&
            status != OneSpanAPIObjects.PackageStatus.SENT &&
            status != OneSpanAPIObjects.PackageStatus.COMPLETED &&
            status != OneSpanAPIObjects.PackageStatus.ARCHIVED &&
            status != OneSpanAPIObjects.PackageStatus.DECLINED &&
            status != OneSpanAPIObjects.PackageStatus.OPTED_OUT &&
            status != OneSpanAPIObjects.PackageStatus.EXPIRED))
        {
            throw new OneSpanValidationException('Not a valid Auth Scheme:'+status);
        }
    }

    /**
     * Method to validate an Approval
     */
    public static void validate(OneSpanAPIObjects.Approval approval)
    {
        if(approval == null || String.isBlank(approval.role) || approval.fields == null  )
        {
            throw new OneSpanValidationException('Not a valid Approval:'+approval);
        }
        for(OneSpanAPIObjects.Field field : approval.fields)
        {
            validate(field);
        }
    }

    /**
     * Method to validate a field
     */
    public static void validate(OneSpanAPIObjects.Field field)
    {
        if(field == null)
        {
            throw new OneSpanValidationException('Not a valid Approval Field:'+field);
        }
        else
        {
            if(field.extractAnchor != null)
            {
                validate(field.extractAnchor);
                validate('Field Type', field.type);
                validate('Field Top', field.top);
                validate('Field SubType', field.subtype);
                validate('Field Left', field.left);
            }
            else
            {
                validate('Field Width', field.width);
                validate('Field Type', field.type);
                validate('Field Top', field.top);
                validate('Field SubType', field.subtype);
                validate('Field Page', field.page);
                validate('Field Left', field.left);
                validate('Field Height', field.height);
            }
        }
    }

    /**
     * Method to validate a ExtractAnchor
     */
    public static void validate(OneSpanAPIObjects.ExtractAnchor ea)
    {
        validate('ExtractAnchor Text', ea.text);
        validate(ea.anchorPoint);
    }

    /**
     * Method to validate a AnchorPoint
     */
    public static void validate(OneSpanAPIObjects.AnchorPoint anchorPointToValidate)
    {
        if( anchorPointToValidate == null || (
            anchorPointToValidate != OneSpanAPIObjects.AnchorPoint.TOPLEFT &&
            anchorPointToValidate != OneSpanAPIObjects.AnchorPoint.TOPRIGHT &&
            anchorPointToValidate != OneSpanAPIObjects.AnchorPoint.BOTTOMLEFT &&
            anchorPointToValidate != OneSpanAPIObjects.AnchorPoint.BOTTOMRIGHT))
        {
            throw new OneSpanValidationException('Not a valid Anchor Point:'+anchorPointToValidate);
        }

    }

    /**
     * Method to validate a decimal
     */
    public static void validate(String nameOfDecimalToValidate, Decimal decimalToValidate)
    {
        if(decimalToValidate == null ||  decimalToValidate < 0.00 )
        {
            throw new OneSpanValidationException('Not a valid value for :'+nameOfDecimalToValidate);
        }
    }

    /**
     * Method to check if the documents in the package are in the same order as in the Map passed
     */
    public static String comparePackageDocumentsAndMap(OneSpanAPIObjects.Package_x pkg, Map<String,Blob> documentMap)
    {
        Integer count = 0;
        for(String docName : documentMap.keySet())
        {
            count ++;
        }

        if(pkg.documents.size() != count)
        {
            throw new OneSpanValidationException ('Package should have equal number of documents as in the document Map');
        }

        if(pkg.documents != null && pkg.documents.size() > 0)
        {
            Integer index = 0;
            for(String docName : documentMap.keySet())
            {
                System.debug('=> docName, index: '+docName+','+index);
                if(docName == null ||  pkg.documents[index].name == null)
                {
                     throw new OneSpanValidationException  ('Document name can\'t be null');
                }
                if(!docName.equalsIgnoreCase(pkg.documents[index].name))
                {
                     throw new OneSpanValidationException ('Document name should be the same in Package and Document Map');
                }

                index ++;
            }
        }

        return 'success';        
    }

    public class OneSpanValidationException extends Exception {}
}