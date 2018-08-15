/**
 * Class Name: OneSpanServiceMock
 *
 * Mock class used for testing OneSpan callouts
 */

global class OneSpanServiceMock implements HttpCalloutMock
{
    //Variables that will be set in the HTTP request
    private String body;
    private Integer statusCode;
    private String status;
    private Blob reqBlob;
    
    /**
     * Constructor
     */
    global OneSpanServiceMock(String passedBody)
    {
        this.body = passedBody;
        this.statusCode = 200;
    }

    /**
     * Constructor
     */
    global OneSpanServiceMock(String passedBody, Integer statusCode)
    {
        this.body = passedBody;
        this.statusCode = statusCode;
    }

    /**
     * Constructor
     */
    global OneSpanServiceMock(String passedBody, Integer statusCode, String status)
    {
        this.body = passedBody;
        this.statusCode = statusCode;
        this.status = status;
    }

    /**
     * Constructor
     */
    global OneSpanServiceMock(String passedBody, Integer statusCode, Blob passedBlob)
    {
        this.body = passedBody;
        this.statusCode = statusCode;
        this.reqBlob = passedBlob;
    }

    /**
     * Method to return HttpResponse
     */
    global HTTPResponse respond(HTTPRequest req) 
    {   
        // Create a fake HttpResponse
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(body);
        res.setStatusCode(statusCode);
        if(reqBlob != null)
        {
            res.setBodyAsBlob(reqBlob);
        }
        if(status != null)
        {
             res.setStatus(status);
        }
        return res;    
    }
}