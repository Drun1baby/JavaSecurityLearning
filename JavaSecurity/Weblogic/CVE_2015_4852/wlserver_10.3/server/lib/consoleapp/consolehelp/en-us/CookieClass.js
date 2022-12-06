// This code is taken from O'Reilly's "JavaScript: The Definitive Guide"
// 4th Edition, Example 16-1 on pages 270-273.  Slightly modified.
//
// John Methot
// 3/6/2003

// The constructor function: creates a cookie object for the specified
// document, with a specified name and optional attributes.
// Arguments:
//   document: The Document object that the cookie is stored for. Required.
//   name:     A string that specifies a name for the cookie. Required.
//   hours:    An optional number that specifies the number of hours from now
//             that the cookie should expire.
//   path:     An optional string that specifies the cookie path attribute.
//   domain:   An optional string that specifies the cookie domain attribute.
//   secure:   An optional Boolean value that, if true, requests a secure cookie.
//
function Cookie(document, name, hours, path, domain, secure)
{
    // All the predefined properties of this object begin with '$'
    // to distinguish them from other properties which are the values to
    // be stored in the cookie.
    this.$document = document;
    this.$name = name;
    if (hours)
        this.$expiration = new Date((new Date()).getTime() + hours*3600000.0);
    else this.$expiration = null;
    if (path) this.$path = path; else this.$path = null;
    if (domain) this.$domain = domain; else this.$domain = null;
    if (secure) this.$secure = true; else this.$secure = false;
}

// This function is the store() method of the Cookie object.
Cookie.prototype.store = function () {
    // First, loop through the properties of the Cookie object and
    // put together the value of the cookie. Since cookies use the
    // equals sign and semicolons as separators, we'll use colons
    // and ampersands for the individual state variables we store 
    // within a single cookie value. Note that we escape the value
    // of each state variable, in case it contains punctuation or other
    // illegal characters.
    var cookieval = "";
    for(var prop in this) {
        // Ignore properties with names that begin with '$' and also methods.
        if ((prop.charAt(0) == '$') || ((typeof this[prop]) == 'function')) 
            continue;
        if (cookieval != "") cookieval += '&';
        cookieval += prop + ':' + escape(this[prop]);
    }

    // Now that we have the value of the cookie, put together the 
    // complete cookie string, which includes the name and the various
    // attributes specified when the Cookie object was created.
    var cookie = this.$name + '=' + cookieval;
    if (this.$expiration)
        cookie += '; expires=' + this.$expiration.toGMTString();
    if (this.$path) cookie += '; path=' + this.$path;
    if (this.$domain) cookie += '; domain=' + this.$domain;
    if (this.$secure) cookie += '; secure';

    // Now store the cookie by setting the magic Document.cookie property.
    this.$document.cookie = cookie;
}

// This function is the load() method of the Cookie object.
Cookie.prototype.load = function() { 
    // First, get a list of all cookies that pertain to this document.
    // We do this by reading the magic Document.cookie property.
    var allcookies = this.$document.cookie;
    if (allcookies == "") return false;

    // Now extract just the named cookie from that list.
    var start = allcookies.indexOf(this.$name + '=');
    if (start == -1) return false;   // Cookie not defined for this page.
    start += this.$name.length + 1;  // Skip name and equals sign.
    var end = allcookies.indexOf(';', start);
    if (end == -1) end = allcookies.length;
    var cookieval = allcookies.substring(start, end);

    // Now that we've extracted the value of the named cookie, we've
    // got to break that value down into individual state variable 
    // names and values. The name/value pairs are separated from each
    // other by ampersands, and the individual names and values are
    // separated from each other by colons. We use the split method
    // to parse everything.
    var a = cookieval.split('&');    // Break it into array of name/value pairs.
    for(var i=0; i < a.length; i++)  // Break each pair into an array.
        a[i] = a[i].split(':');

    // Now that we've parsed the cookie value, set all the names and values
    // of the state variables in this Cookie object. Note that we unescape()
    // the property value, because we called escape() when we stored it.
    for(var i = 0; i < a.length; i++) {
        this[a[i][0]] = unescape(a[i][1]);
    }

    // We're done, so return the success code.
    return true;
}

// This function is the remove() method of the Cookie object.
Cookie.prototype.remove = function() {

    var cookie;
    cookie = this.$name + '=';
    if (this.$path) cookie += '; path=' + this.$path;
    if (this.$domain) cookie += '; domain=' + this.$domain;
    cookie += '; expires=Fri, 02-Jan-1970 00:00:00 GMT';

    this.$document.cookie = cookie;
}

//
// utility methods that use the Cookie class to store arbitrary
// "properties" as wlw.help.<property-name> cookies.
//
function getCookie(propName)
{
  var cookie = new Cookie(document, "wlw.help." + propName);
  var retval = null;
  if (cookie.load())
  {
    retval = cookie.value;
  }
  debug("getCookie(" + propName + ") = " + retval);
  return retval;
}

//
// utility methods that use the Cookie class to store arbitrary
// "properties" as wlw.help.<property-name> cookies.
//
// function setCookie(propName, value)
// Changed JW 9/21/03 (original above)
// Added an "hours" parameter to allow the caller to specify how long the cookie
// should last. If null or 0 is passed, the cookie lasts as long as the user's
// browser session.
function setCookie(propName, value, hours)
{
  if(hours == null)
  {
      hours = 0;
  }
  debug("setCookie(" + propName + ", " + value + ")");
  var cookie = new Cookie(document, "wlw.help." + propName, hours, "/");
  cookie.value = value;
  cookie.store();
} 

///////////////////////////////////////////////////////////////////////////////
//
// Utilities supporting the Extensible Help system.
//
///////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
//
// _console and debug() provide a simple debug output system. debug()
// pops up a plain text window and directs output to it.
//

function debugDisplay(msg)
{
  if((top._console == null) || (top._console.closed))
  {
    top._console = window.open("", "console", "width=900,height=300,resizable,scrollbars");
    if (top._console != null)
    {
      top._console.document.open("text/plain");
    }
  }
  if (top._console != null)
  {
    top._console.focus();
    top._console.document.writeln(msg + "<br>");
  }
}

function debug(msg)
{
//  debugDisplay(msg);
}

// we want to append a ?query to the url if
// it isn't already there. If the URL has a #fragment,
// the #fragment has to come after the ?query, so grab
// the #fragment, append the ?query to the base URL,
// then append the #fragment back to the very end
function appendQuery(url, query)
{
  var retval = url;
  var fragment = null;
  var index;
  var newURL;

  if( url.indexOf(query) < 0 )
  {
    if( (index = url.indexOf("#")) > 0 )
    {
      fragment = url.substring(index);
      newURL = url.substring(0,index)
      newURL += query;
      newURL += fragment;
      retval = newURL;
    }

    // if there is no #fragment, just append the ?query
    else
    {
      retval = url + query;
    }
  }
  return retval;
}
