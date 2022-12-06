/*
  Functions to support WLST script recording within the console.

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

(function(ns){

var dialogWidth = 460;
var dialogHeight = 380;

/**
 * Called in response to some event such as a link onClick to begin the
 * Console recording *and* also used to stop recording.
 * This is done by sending an async request to the server.
 * The async request uses the remoteframeToolbar iframe.
 */
ns.startAdHocRecord = function (sField, sValue) {
  var topLeft;
  var topRight;
  var options;
  var recorder = wls.console.recordState;

  // if user preference is to prompt and the recording has not started
  if (recorder.prompt && !recorder.recordingStarted){
    // then prompt
    topLeft = ((screen.width)/2)-dialogWidth;
    topRight = ((screen.height)/2)-dialogHeight;

    options = "width=" + dialogWidth + ",height=" + dialogHeight + 
              ",resizable=yes,scrollbars=yes,location=no,menubar=no,toolbar=no,status=no,top=" +
              topRight + ",left=" + topLeft;

    // prompt for changes to basedir, filename and/or append to file
    recorder.promptWin = window.open(recorder.contextRoot + 
        "/com/bea/console/actions/preferences/wlst/promptParameters.do",
        "confirm",
        options);
    if (!recorder.promptWin.opener) {
      recorder.promptWin.opener = self;
    }
    recorder.promptWin.focus();
    // When promptWin window is done, it should get the parameters entered if overriding
    // and call wls.console.sendAdHocRecordRequest then close itself
  } else {
    // Send a request to the server to toggle the recording state.
    wls.console.sendAdHocRecordRequest(sField, sValue);
  }
  return false;
};

/**
 * Send a request to the server to toggle the recording state.
 * All 3 parameters are optional. Either all must be set or none set.
 *
 * param basedir name of the directory to put the file in
 * param filename name of the file write to
 * param append boolean true if the file should be appended to
 */
ns.sendAdHocRecordRequest = function (basedir, filename, append, sField, sValue) {
  var recorder = wls.console.recordState;
  var elem;
  var iframeElem;
  var url;
  var theFrame;
  var overrides = "";
  var secretKeys = "";

  if (arguments.length == 5) {
    // Build override list of parameters
    overrides = "?overrides=true&baseScriptDirectory=" + basedir + "&fileName=" + filename + "&appendToFile=" + append;
    secretKeys = "&"+sField+"="+sValue;
  } else if (arguments.length == 2) {
    secretKeys = "?"+arguments[0]+"="+arguments[1];
  }

  url = recorder.contextRoot + "/jsp/preferences/wlstadhocrecording.jsp" + overrides + secretKeys;
  // if the iframe doesn't exist then add it to the document.
  theFrame = frames.remoteframeToolbar;
  if (!theFrame) {
    elem = document.getElementById("ToolbarPage");
    iframeElem = document.createElement("iframe");
    iframeElem.setAttribute("id", "remoteframeToolbar");
    iframeElem.setAttribute("name", "remoteframeToolbar");
    iframeElem.setAttribute("src", url);
    elem.appendChild(iframeElem);
  } else {
    theFrame.location.href = url;
  }
};

/*
 * This is the call back handler.
 * Update the message portlet when the response comes back
 */
ns.notifyAdhocRecord = function (msgs, recordIconTitle) {
  // Get reference to parent window message region
  var localMsgs = document.getElementById("asyncmessages");
  if (localMsgs) {
    // set local|parent window message region contents to
    // remote window messages content
    var t = setTimeout(function() {
      localMsgs.innerHTML = msgs;
    }, 1);
  }

  document.getElementById("recordingIcon").title = recordIconTitle;
  document.getElementById("recordLink").title = recordIconTitle;
};

})(wls.console);
