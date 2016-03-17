/**
 * Class Name: ESignLiveValidationTest.cls
 *
 * Test class for the ESignLiveValidation class
 */

@isTest
public class ESignLiveValidationTest
{
    /**
     * Method to test validating an empty string
     */
    private static testmethod void validateEmptyStringTest()
    {
        // Set parameters
        String nameOfString = 'variableName';
        String valueString = '';
        try
        {
            // Code to test
            ESignLiveValidation.validate(nameOfString, valueString);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to test a null string
     */
    private static testmethod void validateNullStringTest()
    {
        // Set parameters
        String nameOfString = 'variableName';
        String valueString = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(nameOfString, valueString);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Metod to test a zero integer
     */
    private static testmethod void validateZeroIntegerTest()
    {
        // Set parameters
        String nameOfInteger = 'variableName';
        Integer valueInteger = 0;
        try
        {
            // Code to test
            ESignLiveValidation.validate(nameOfInteger, valueInteger);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a negative integer
     */
    private static testmethod void validateMinus1IntegerTest()
    {
        // Set parameters
        String nameOfInteger = 'variableName';
        Integer valueInteger = -1;
        try
        {
            // Code to test
            ESignLiveValidation.validate(nameOfInteger, valueInteger);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null integer
     */
    private static testmethod void validateNullIntegerTest()
    {
        // Set parameters
        String nameOfInteger = 'variableName';
        Integer valueInteger = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(nameOfInteger, valueInteger);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null AuthScheme
     */
    private static testmethod void validateNullScheme()
    {
        // Set parameters
        ESignLiveAPIObjects.AuthScheme auth = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(auth);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null AuthChallenge
     */
    private static testmethod void validateNullAuthChallenge()
    {
        // Set parameters
        ESignLiveAPIObjects.AuthChallenge authChallenge = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(authChallenge);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null maskInput in an AuthChallenge
     */
    private static testmethod void validateNullAuthChallengeMaskInput()
    {
        // Set parameters
        ESignLiveAPIObjects.AuthChallenge authChallenge = new ESignLiveAPIObjects.AuthChallenge();
        authChallenge.maskInput = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(authChallenge);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null challenge question in an AuthChallenge
     */
    private static testmethod void validateNullAuthChallengeQuestion()
    {
        // Set parameters
        ESignLiveAPIObjects.AuthChallenge authChallenge = new ESignLiveAPIObjects.AuthChallenge();
        authChallenge.maskInput = false;
        authChallenge.question = '';
        authChallenge.answer = 'answer';
        try
        {
            // Code to test
            ESignLiveValidation.validate(authChallenge);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null challenge answer in an AuthChallenge
     */
    private static testmethod void validateNullAuthChallengeAnswer()
    {
        // Set parameters
        ESignLiveAPIObjects.AuthChallenge authChallenge = new ESignLiveAPIObjects.AuthChallenge();
        authChallenge.maskInput = null;
        authChallenge.question = 'question';
        authChallenge.answer = '';
        try
        {
            // Code to test
            ESignLiveValidation.validate(authChallenge);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null AuthChallenge
     */
    private static testmethod void validateAuthChallengeList()
    {
        List<ESignLiveAPIObjects.AuthChallenge> authChallengeList = new List<ESignLiveAPIObjects.AuthChallenge>();
        try
        {
            // Code to test
            ESignLiveValidation.validate(authChallengeList);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null AttachmentRequirement
     */
    private static testmethod void validateNullAttachmentRequirement()
    {
        ESignLiveAPIObjects.AttachmentRequirement ar = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(ar);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a name in an Attachment Requirement
     */
    private static testmethod void validateNullNameAttachmentRequirement()
    {
        ESignLiveAPIObjects.AttachmentRequirement ar = new ESignLiveAPIObjects.AttachmentRequirement();
        ar.Name = '';
        try
        {
            // Code to test
            ESignLiveValidation.validate(ar);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null Package
     */
    private static testmethod void validateNullPackageX()
    {
        ESignLiveAPIObjects.Package_x pkg = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(pkg);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null name in a Package;
     */
    private static testmethod void validateNullNamePackageX()
    {
        ESignLiveAPIObjects.Package_x pkg = new ESignLiveAPIObjects.Package_x();
        pkg.name = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(pkg);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null blob map
     */
    private static testmethod void validateNullMapBlob()
    {
        Map<String,Blob> blobMap = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(blobMap);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate an empty key in a blob map
     */
    private static testmethod void validateEmptyKeyMapBlob()
    {
        Map<String,Blob> blobMap = new Map<String,Blob>();
        blobMap.put('',Blob.valueOf('myBlob'));
        try
        {
            // Code to test
            ESignLiveValidation.validate(blobMap);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a package status
     */
    private static testmethod void validateStatus()
    {
        
        ESignLiveAPIObjects.PackageStatus status = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(status);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }

    }

    /**
     * Method to validate a null Approval
     */
    private static testmethod void validateNullApproval()
    {
        ESignLiveAPIObjects.Approval approval = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(approval);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate an empty role in an Approval
     */
    private static testmethod void validateEmptyRoleApproval()
    {
        ESignLiveAPIObjects.Approval approval = new ESignLiveAPIObjects.Approval();
        approval.role = '';
        try
        {
            // Code to test
            ESignLiveValidation.validate(approval);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null field
     */
    private static testmethod void validateField()
    {
        ESignLiveAPIObjects.Field f = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(f);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null height field
     */
    private static testmethod void validateNullHeightField()
    {
        ESignLiveAPIObjects.Field f = new ESignLiveAPIObjects.Field();
        f.width = 10;
        f.type = 'type';
        f.top = 100;
        f.subtype = 'subType';
        f.page = 1;
        f.left = 1;
        f.height = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(f);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }

    /**
     * Method to validate a null decimal
     */
    private static testmethod void validateDecimal()
    {
        // Set parameters
        String nameOfDecimal = 'variableName';
        Decimal value = null;
        try
        {
            // Code to test
            ESignLiveValidation.validate(nameOfDecimal, value);
        }
        catch(Exception e)
        {
            // Verify result
            System.assertEquals('ESignLiveValidation.ESignLiveValidationException', e.getTypeName());
        }
    }
}