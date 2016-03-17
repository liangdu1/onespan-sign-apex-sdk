/**
 * Class Name: ESignLiveValidation.cls
 *
 * Class handling validation for eSignLive objects
 */

public with sharing class ESignLiveValidation
{
    public ESignLiveValidation(){}

    /**
     * Method to validate a string value
     */
    public static void validate(String nameOfStringToValidate, String stringToValidate)
    {
        if(String.isBlank(stringToValidate))
        {
            throw new ESignLiveValidationException('String can\'t be empty:'+nameOfStringToValidate);
        }
    }

    /**
     * Method to validate an integer value
     */
    public static void validate(String nameOfIntegerToValidate, Integer integerToValidate)
    {
        if(integerToValidate == null || ( !(nameOfIntegerToValidate.startsWith('ExtractAnchor')) && integerToValidate < 0) )
        {
            throw new ESignLiveValidationException('Not a valid value for :'+nameOfIntegerToValidate);
        }
    }

    /**
     * Method to validate an AuthScheme
     */
    public static void validate(ESignLiveAPIObjects.AuthScheme scheme)
    {
        if( scheme == null || (
            scheme != ESignLiveAPIObjects.AuthScheme.NONE &&
            scheme != ESignLiveAPIObjects.AuthScheme.PROVIDER &&
            scheme != ESignLiveAPIObjects.AuthScheme.CHALLENGE &&
            scheme != ESignLiveAPIObjects.AuthScheme.SMS))
        {
            throw new ESignLiveValidationException('Not a valid Auth Scheme:'+scheme);
        }
    }

    /**
     * Method to validate an AuthChallenge
     */
    public static void validate(ESignLiveAPIObjects.AuthChallenge authChallenge)
    {
            if(authChallenge == null || authChallenge.maskInput == null ||
                String.isBlank(authChallenge.answer) ||
                String.isBlank(authChallenge.question) )
            {
                try
                {
                    throw new ESignLiveValidationException('Not a valid Auth Challenge:'+authChallenge);  
                }
                catch(Exception e)
                {
                    throw new ESignLiveValidationException('Not a valid Auth Challenge:'+authChallenge);
                }
            }
    }

    /**
     * Method to validate an AuthChallenge list
     */
    public static void validate(List<ESignLiveAPIObjects.AuthChallenge> authChallengeList)
    {
        //If we have CHALLENGE or SMS as the scheme then we would need to have at least 1 AuthChallenge object in challenges list
        if(authChallengeList == null || authChallengeList.size() == 0)
        {
            throw new ESignLiveValidationException('At least one Auth Challenge is needed for the scheme selected: '+authChallengeList);
        }
        
        for(ESignLiveAPIObjects.AuthChallenge authChallenge : authChallengeList)
        {   
            validate(authChallenge);
        }
    }

    /**
     * Method to validate an AttachmentRequirement
     */
    public static void validate(ESignLiveAPIObjects.AttachmentRequirement ar)
    {
        if(ar == null || String.isBlank(ar.name))
        {
            throw new ESignLiveValidationException('Not a valid Attachment Requirement:'+ar);
        }
    }

    /**
     * Method to validate an AttachmentRequirement list
     */
    public static void validate(List<ESignLiveAPIObjects.AttachmentRequirement> arList)
    {
        //If we have CHALLENGE or SMS as the scheme then we would need to have at least 1 AttachmentRequirement object in challenges list
        if(arList == null || arList.size() == 0)
        {
            throw new ESignLiveValidationException('At least one Auth Challenge is needed for the scheme selected: '+arList);
        }
        
        for(ESignLiveAPIObjects.AttachmentRequirement ar : arList)
        {   
            validate(ar);
        }
    }

    /**
     * Method to validate a Package
     */
    public static void validate(ESignLiveAPIObjects.Package_x pkg)
    {
        if(pkg == null || String.isBlank(pkg.name))
        {
            throw new ESignLiveValidationException('Not a valid Package:'+pkg);
        }
    }

    /**
     * Method to validate a blob map
     */
    public static void validate(Map<String,Blob> blobMap)
    {
        if(blobMap == null || blobMap.size() == 0)
        {
            throw new ESignLiveValidationException('Not a valid Map:'+blobMap);
        }

        for(String key : blobMap.keySet())
        {
            if(String.isBlank(key))
            {
                throw new ESignLiveValidationException('Not a valid key in the Map:'+blobMap);
            }
        }
    }

    /**
     * Method to validate a Package status
     */
    public static void validate(ESignLiveAPIObjects.PackageStatus status)
    {
        if( status == null || (
            status != ESignLiveAPIObjects.PackageStatus.DRAFT &&
            status != ESignLiveAPIObjects.PackageStatus.SENT &&
            status != ESignLiveAPIObjects.PackageStatus.COMPLETED &&
            status != ESignLiveAPIObjects.PackageStatus.ARCHIVED &&
            status != ESignLiveAPIObjects.PackageStatus.DECLINED &&
            status != ESignLiveAPIObjects.PackageStatus.OPTED_OUT &&
            status != ESignLiveAPIObjects.PackageStatus.EXPIRED))
        {
            throw new ESignLiveValidationException('Not a valid Auth Scheme:'+status);
        }
    }

    /**
     * Method to validate an Approval
     */
    public static void validate(ESignLiveAPIObjects.Approval approval)
    {
        if(approval == null || String.isBlank(approval.role) || approval.fields == null  )
        {
            throw new ESignLiveValidationException('Not a valid Approval:'+approval);
        }
        for(ESignLiveAPIObjects.Field field : approval.fields)
        {
            validate(field);
        }
    }

    /**
     * Method to validate a field
     */
    public static void validate(ESignLiveAPIObjects.Field field)
    {
        if(field == null)
        {
            throw new ESignLiveValidationException('Not a valid Approval Field:'+field);
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
    public static void validate(ESignLiveAPIObjects.ExtractAnchor ea)
    {
        validate('ExtractAnchor Text', ea.text);
        validate(ea.anchorPoint);
    }

    /**
     * Method to validate a AnchorPoint
     */
    public static void validate(ESignLiveAPIObjects.AnchorPoint anchorPointToValidate)
    {
        if( anchorPointToValidate == null || (
            anchorPointToValidate != ESignLiveAPIObjects.AnchorPoint.TOPLEFT &&
            anchorPointToValidate != ESignLiveAPIObjects.AnchorPoint.TOPRIGHT &&
            anchorPointToValidate != ESignLiveAPIObjects.AnchorPoint.BOTTOMLEFT &&
            anchorPointToValidate != ESignLiveAPIObjects.AnchorPoint.BOTTOMRIGHT))
        {
            throw new ESignLiveValidationException('Not a valid Anchor Point:'+anchorPointToValidate);
        }

    }

    /**
     * Method to validate a decimal
     */
    public static void validate(String nameOfDecimalToValidate, Decimal decimalToValidate)
    {
        if(decimalToValidate == null ||  decimalToValidate < 0.00 )
        {
            throw new ESignLiveValidationException('Not a valid value for :'+nameOfDecimalToValidate);
        }
    }

    /**
     * Method to check if the documents in the package are in the same order as in the Map passed
     */
    public static String comparePackageDocumentsAndMap(ESignLiveAPIObjects.Package_x pkg, Map<String,Blob> documentMap)
    {
        Integer count = 0;
        for(String docName : documentMap.keySet())
        {
            count ++;
        }

        if(pkg.documents.size() != count)
        {
            throw new ESignLiveValidationException ('Package should have equal number of documents as in the document Map');
        }

        if(pkg.documents != null && pkg.documents.size() > 0)
        {
            Integer index = 0;
            for(String docName : documentMap.keySet())
            {
                System.debug('=> docName, index: '+docName+','+index);
                if(docName == null ||  pkg.documents[index].name == null)
                {
                     throw new ESignLiveValidationException  ('Document name can\'t be null');
                }
                if(!docName.equalsIgnoreCase(pkg.documents[index].name))
                {
                     throw new ESignLiveValidationException ('Document name should be the same in Package and Document Map');
                }

                index ++;
            }
        }

        return 'success';        
    }

    public class ESignLiveValidationException extends Exception {}
}