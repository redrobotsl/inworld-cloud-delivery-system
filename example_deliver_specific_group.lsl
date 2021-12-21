string product = "W0pDU09dIEVxdWlwbWVudCBQYWNrIDIwMjEgQmFzaWMoYm94ZWQp";  //Base64 Encoded Object Name
string authkey = "";
string purpose = ""; // The Box ID, eventually, this will be optional, if not specified, it will ask each dropbox until one replies that it has it. 
default
{
   

    touch_start(integer total_number)
    {
        
        
        key AttachedNames;
        list AttachedUUIDs = llGetAttachedList(llDetectedKey(0));
        list temp = llGetObjectDetails(llList2Key(AttachedUUIDs,0),[OBJECT_GROUP]);
        AttachedNames = llList2Key(temp,0);
       
        // Jasper County Sheriff's Office Group Key
        if(AttachedNames == "32b66933-f4da-75e1-6693-49c62e2676a5"){
        llHTTPRequest("?auth=&purpose=&item=" + llEscapeURL(product) + "&uuid=" + llEscapeURL(llDetectedKey(0)), [], "");
llInstantMessage(llDetectedKey(0), "Attempting to send you the JCSO Uniform and Equipment Pack  from the magical elves in the Red Robot Cloud");
}
else{
    llSay(0, "SECURITY WARN: Please ensure you have the appropiate JCSO Group Tag on.");
    }
    }
}
