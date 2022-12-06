/*
  Functions used by the help viewer window in various contexts

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

(function () {

var helpWindow;

function openHelp(url) {
  var winstate="width=1000,height=500,resizable=yes,scrollbars=yes,location=yes,menubar=yes,toolbar=yes,status=yes";

  if (!helpWindow) {
    helpWindow = {};
  }
  if (!helpWindow.closed && helpWindow.location) {
    helpWindow.location.href = url;
  } else {
    helpWindow = window.open(url, "help", winstate);
  }
  helpWindow.focus();
}

/**
 * Open a help window 
 * The help window content comes from pageHelpURL if it is set
 * or from pageHelpKey. These are properties of the wls.console
 * namespace object.
 */
wls.console.launchHelp = function () {
  // If the url has been specified, just launch the url
  // This type of URL comes from helpurlpattern metadata
  if (wls.console.pageHelpURL) {
    openHelp(wls.console.pageHelpURL);
    return false;
  }
  // otherwise use URL that comes from helpid metadata
  return wls.console.launchAttributeHelp(null);
};

/**
 * Open a help window with optional attribute key
 * The help window content comes from pageHelpKey (a property of 
 * wls.console). If the key is not null then a parameter
 * is added to the url. The key specifies a specific topic within
 * the help file given by pageHelpKey.
 */
wls.console.launchAttributeHelp = function(key) {
  var url = "/consolehelp/console-help.portal?_nfpb=true&_pageLabel=page&helpId="+ wls.console.pageHelpKey;
  if (key) {
    url += "#" + key;
  }
  if (wls.console.pageHelpKey) {
    openHelp(url);
  } else {
    // No help id assigned to this page yet
  }
  return false;
};

/**
 * Open a help window to a task topic
 * The help window content comes the task parameter
 */
wls.console.launchTaskHelp = function(task) {
  var url = "/consolehelp/console-help.portal?_nfpb=true&_pageLabel=page&helpId="+ task;
  openHelp(url);
  return false;
};

})();
