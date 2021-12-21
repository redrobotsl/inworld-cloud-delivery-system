string secureUrl;
key urlRequestId;
key selfCheckRequestId;
key updateUrl;
string RobotCloudDNS = "";
// https://www.random.org/strings/?num=10&len=10&digits=on&unique=on&format=html&rnd=new
string SysAuth = "";
string ID;
string IAuth;
request_secure_url()
{
    llReleaseURL(secureUrl);
    secureUrl = "";
 
    urlRequestId = llRequestSecureURL();
}
 
throw_exception(string inputString)
{
    key owner = llGetOwner();
    llInstantMessage(owner, inputString);
    llResetScript();
}
 
default
{ 
    on_rez(integer start_param)
    {
        llResetScript();
    }
 
    changed(integer change)
    {
        if (change & (CHANGED_OWNER))
        {
            llReleaseURL(secureUrl);
            secureUrl = "";
 
            llResetScript();
        }
 
        if (change & (CHANGED_REGION | CHANGED_REGION_START | CHANGED_TELEPORT))
            request_secure_url();
    }
 
    state_entry()
    {
         ID = llGetObjectDesc();
        request_secure_url();
    }
 
    http_request(key id, string method, string body)
    {
        integer responseStatus = 200;
        string responseBody = "501|NOTIMPLEMENTED";
 
        if (method == URL_REQUEST_DENIED)
            throw_exception("The following error occurred while attempting to get a free URL for this device:\n \n" + body);
 
        else if (method == URL_REQUEST_GRANTED)
        {
            secureUrl = body;
            key owner = llGetOwner();
            llLoadURL(owner, "Click to visit my URL!", secureUrl);
            updateUrl = llHTTPRequest(RobotCloudDNS + "?auth=" + SysAuth + "&url=" + llEscapeURL(secureUrl) + "&purpose=" + ID, [], "");
            // check every 5 mins for dropped URL
            llSetTimerEvent(300.0);
        }
        else if (method ==  "POST")
        {
            IAuth = llJsonGetValue( body, ["auth"]);
            if(IAuth == SysAuth){
            responseStatus = 200;
            responseBody = "204|SENDING";
            string item = llBase64ToString(llJsonGetValue( body, ["item"]));
            key recipient = (key)llJsonGetValue( body, ["uuid"]);          
           
            if(llGetInventoryType(item) != INVENTORY_NONE){
                    llGiveInventory(recipient, item);
                    llInstantMessage(recipient, "You have requested delivery of this item from Red Robot.");
                      llHTTPResponse(id, responseStatus, responseBody);
                     return;
                }
                else{
                    responseStatus = 200; responseBody = "422|NOITEM";
                     llHTTPResponse(id, responseStatus, responseBody);
                     return;
                }
            }
            else{
                responseStatus = 200; responseBody = "401|BADAUTHKEY";
                  llHTTPResponse(id, responseStatus, responseBody);
                     return;
            }              
            
        }
         else if (method == "GET"){
             responseStatus = 200;
            responseBody = "200|SENDING";
             
            }
        // else if (method == "PUT") ...;
        // else if (method == "DELETE") { responseStatus = 403; responseBody = "forbidden"; }
      
        llHTTPResponse(id, responseStatus, responseBody);
    }
 
    http_response(key id, integer status, list metaData, string body)
    {
        if (id == selfCheckRequestId)
        {
            // If you're not usually doing this,
            // now is a good time to get used to doing it!
            selfCheckRequestId = NULL_KEY;
 
            if (status != 200)
                request_secure_url();
        }
        else if(id == updateUrl){
            llSay(0, body);
        }
        else if (id == NULL_KEY)
            throw_exception("Too many HTTP requests too fast!");
    }
 
    timer()
    {
        selfCheckRequestId = llHTTPRequest(secureUrl,
                                [HTTP_METHOD, "GET",
                                    HTTP_VERBOSE_THROTTLE, FALSE,
                                    HTTP_BODY_MAXLENGTH, 16384],
                                "");
    }
}
