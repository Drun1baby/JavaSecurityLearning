/*
 * This function parses &-separated name=value 
 * argument pairs from the query string of the URL. 
 * It stores the name=value pairs in 
 * properties of an object and then returns that object
 */

function getArgs(fullQuery) {
    var args = new Object();

    // Get Query String (go past ? in first char)
    var query = fullQuery.substring(1); 

    // Split query at the &
    var pairs = query.split("&"); 
    
    // Begin loop through the querystring
    for(var i = 0; i < pairs.length; i++)
    {

        // Look for "name=value"
        var pos = pairs[i].indexOf('='); 
        // if not found, skip to next
        if (pos == -1) continue; 
        // Extract the name
        var argname = pairs[i].substring(0,pos); 
        
        // Extract the value
        var value = pairs[i].substring(pos+1); 
        // Store as a property
        args[argname] = unescape(value); 
    }
    return args; // Return the Object
}

function cookiesAccepted()
{
    var retval = false;

    var testCookieSet = new Cookie(document, "test", 0.01, "/");
    testCookieSet.testStr = "cookie test";
    testCookieSet.store();

    var testCookieGet = new Cookie(document, "test");
    if (testCookieGet.load())
    {
        if (testCookieGet.testStr.indexOf("cookie test") != -1)
        {
            retval = true;
            testCookieGet.remove();
        }
    }

    return retval;
}

function displayContent()
{

    var queryString = document.location.search;
    var args = getArgs(queryString);
    var url;
    var newURL;


    // if there is a 'skipReload' parameter in the query string, let the
    // topic display.  Otherwise, read the destContent cookie to see
    // what topic should be displayed and set skipReload when issuing
    // the URL of the desired topic.
    if (!args['skipReload'])
    {
        // First, try to read data stored in the cookie. If the cookie is not
        // defined do nothing and let the page display.
        //
        // Remove the cookie after using it because displayContent is going
        // to be called again when we load the actual topic.  The second
        var destContent = new Cookie(document, "destContent");
        if (destContent.load())
        {

            url = unescape(destContent.url);  
            if ((url != null) && (url.length > 0))
            {
                newURL = appendQuery(url, '?skipReload=true');
                debug("displayContent: adding skipReload, newURL(" + newURL.length + ")=" + newURL);
                document.location.replace(newURL);
            }

            destContent.remove();
        }
    }
    else
    {
        debug("displayContent: detected skipReload, url is: " + document.location.href);
        debug("displayContent: fragment is: " + document.location.hash);
    }
}


//
// called via onLoad from all topic pages
//
function displayInFrames()
{
    var queryString = document.location.search;
    var args = getArgs(queryString);

    // if there is a 'skipReload' parameter in the query string, 
    // just let the topic be displayed.
    // Otherwise, the browser has been sent directly to
    // a topic and we want to display the topic in the frameset
    // with the TOC properly expended.  Set cookies and display
    // index.html to make that happen.

    debug('displayInFrames: queryString: ' + queryString + '\n*******************\n\n');


    if(!args['skipReload'])
    {
      window.focus();
        if (!cookiesAccepted())
        {
            var alertStr = "{alerts.NOCOOKIES}";
            alert(alertStr);
            return;
        }


        // Create the cookie we'll use to communicate the URL of this topic
        // to content.html.
        // Since we're using the '/' path, this cookie will be accessible
        // to all web pages on the same "server" as this file.
        //
        // set two cookies, one for the content pane and one for the
        // TOC pane.  That way each pane can clear its cookie after it
        // reads it and order doesn't matter.
// Changed JW 10/10/03: It's okay to set cookies when we need to reload the frameset,
// but we don't want them to persist beyond the browser session, so I've changed
// parameter 3, the duration of the cookie in hours, from 1 to 0. This will cause the
// cookie to last only as long as the browser session.
        var destContent = new Cookie(document, "destContent", 0, "/");
        destContent.remove();


        var url = unescape(window.location.href);
 
        if(url.indexOf("?local=true") != -1)
               {
		  var fragment = url.substring(url.indexOf("#"),window.location.href.length);
                  newURL = url.substring(0, url.indexOf('?local=true'));
                  destContent.url = escape(newURL + fragment);
                  destContent.query ="local";
               }

        else
        {
            destContent.url = escape(window.location.href);
        }


// Changed JW 10/10/03: Same as above comment.
        var destTOC = new Cookie(document, "destTOC", 0, "/");

	TOCquery= unescape(window.location.search);
        if(url.indexOf("?local=true") != -1)
        {
          var fragment = url.substring(url.indexOf("#"),window.location.href.length);
          newURL = url.substring(0, url.indexOf('?local=true'));
          destTOC.url = escape(newURL + fragment);
        }
	else
	{
	   destTOC.url = escape(window.location.href);
        }

        // Store the cookie values, even if they were already stored, so that the 
        // expiration date will be reset from this most recent visit.
        destContent.store();
        destTOC.store();

        // load the index.html page, which will look up the cookie and do the
        // right thing in the TOC and content panes.
        indexLocation = document.links[0].href;



        setCookie('bannerMode', 'toc');
// Changed JW 10/4/03: I'm using javascript's replace() function to ensure the
// content page doesn't create an extra entry in the browser history list as it
// loads the frameset. Previous code caused a double entry in the history list
// (one for the content page, one for the TOC) when someone opened a content
// page directly (e.g. in Windows Explorer or by clicking on a link from one
// content page to another).
        top.document.location.replace(indexLocation);
    }    
}

// Begin Added JW 10/4/03: This function is called by all intra-content links.
// CONTENT PAGES MUST NOT CONTAIN SIMPLE LINKS TO OTHER CONTENT PAGES. THEY
// MUST CALL THIS FUNCTION.
function reloadTOC(destURL)
{
    destURL = resolveURL(document.location.href, destURL);

    var topicNumber = "0";
    topicNumber = top.findTopicNumber(destURL);

    var strTOCLocation = document.links[0].href;
    strTOCLocation = strTOCLocation.substring(0, strTOCLocation.lastIndexOf('/'));
    strTOCLocation += "/toc.html" +
        "?topicNumber=" + escape(topicNumber) +
        "&bookmarkMode=0" +
        "&tocChange=" + top.tocBehavior[2] +
        "&changeContent=" + top.tocLinks[2] +
        "&currentHistoryID=" + (top.g_lastHistoryID + 1) +
        "&ignoreCookie=1";

    if(destURL.indexOf("#") != -1)
    {
        strTOCLocation += "&contentAnchor=" +
            escape(destURL.substring(destURL.indexOf("#") + 1));
    }

    strTOCLocation += "#" + topicNumber;

    // See displayToc.js for more information about this function.
    debug("reloadTOC: toc.href='" + strTOCLocation + "'");
    top.frames["tocAndContent"].frames["myToc"].document.location.href = strTOCLocation;
}



// Added by Darren Carlton April 2004: This function is called by links from the
// WLS console help to concept topics in books.

function dynamicURLroot(wlsURL)
{ 
    window.open(top.banner.wlsURLRoot + wlsURL);
}




function resolveURL(strBaseURL, strRelativeURL)
{
    var strRetVal;

// Remove "?skipReload=true" if found
    if(strBaseURL.indexOf("?skipReload=true") != -1)
    {
        strBaseURL = strBaseURL.substring(0, strBaseURL.indexOf("?skipReload=true"));
    }
    if(strRelativeURL.indexOf("?skipReload=true") != -1)
    {
        strRelativeURL = strRelativeURL.substring(0, strRelativeURL.indexOf("?skipReload=true"));
    }

    if(strRelativeURL.substring(0, 1) != "#")
    {
        strBaseURL = strBaseURL.substring(0, strBaseURL.lastIndexOf("/"));
    }

    while(strRelativeURL.indexOf("..") != -1)
    {
        strBaseURL = strBaseURL.substring(0, strBaseURL.lastIndexOf("/"));
        strRelativeURL = strRelativeURL.substring(strRelativeURL.indexOf("..") + 3);
    }

    if(strRelativeURL.substring(0, 1) != "#")
    {
        strRetVal = strBaseURL + "/" + strRelativeURL;
    }
    else
    {
        strRetVal = strBaseURL + strRelativeURL;
    }

    return strRetVal;
}
// End Added JW 10/4/03

function popup(mylink, windowname)
{
  if (! window.focus) return true;

  var href;
  if (typeof(mylink) == 'string')
   href=mylink;
  else
   href=mylink.href;
   
  window.open(href, windowname, 'width=400,height=200,scrollbars=yes,resizable=yes');
  
  return false;
}
