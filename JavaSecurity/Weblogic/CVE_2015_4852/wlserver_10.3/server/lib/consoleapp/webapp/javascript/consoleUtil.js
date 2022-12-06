/*
  Functions used across many console portlets
  Also defines the wls.console namespace so this file
  must be included before all the other console javascript files
  and must also go in the document head.

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

// define the wls.console namespace
var wls = { console: {} };

(function(ns) {

  /*
    There should be no console.log calls in the code other than for temporary debugging
    Still, make sure that if firebug or another console log is not available that
    any console log calls don't cause an error.
  */
  if (!window.console) {
    window.console = {
      log: function(m) {
// uncomment for debugging
//      alert(m);
      }
    };
  }

  //
  // live region support
  //
  function makeRegionLive(el, value) {
    if (document.documentElement.setAttributeNS) {
      el.setAttributeNS("http://www.w3.org/2005/07/aaa", "aaa:live", value);
    }
  };

  if (window.addEventListener) {
    window.addEventListener("load", function () {
      var m = document.getElementById("asyncmessages");
      if (m) {
        makeRegionLive(m, "assertive");
      }
      // making portlet refresh regions live does not produce helpful results
      // The whole region is read which takes too long and additional stuff around
      // the table (and inline help for forms) gets read. 
      // also using refresh-region includes the time and that gets annoying to 
      // listen to and is not really useful. Using table-refreshdefaultRegion
      // gets a little closer to what is desired.
    }, false);
  }

  ns.classAdd = function(elem, name) {
    if (elem.nodeType == 1 && !ns.classHas(elem, name)) {
      elem.className += (elem.className ? " " : "") + name;
    }
  };

  ns.classRemove = function(elem, name) {
    var a, i, removeAt = null;
    if (elem.nodeType == 1) {
      a = elem.className.split(/\s+/);
      for (i = 0; i < a.length; i++) {
        if (a[i] === name) {
          removeAt = i;
          break;
        }
      }
      if (removeAt !== null) {
        a.splice(removeAt, 1);
        elem.className = a.join(" ");
      }
    }
  };

  ns.classHas = function(elem, name) {
    var i;
    var a = elem.className.split(/\s+/);
    for (i = 0; i < a.length; i++) {
      if (a[i] === name) {
        return true;
      }
    }
    return false;
  };

  ns.classToggle = function(elem, name, on) {
    addIt = on !== undefined ? on : !ns.classHas(elem, name);
    if (addIt) {
      ns.classAdd(elem, name);
    } else {
      ns.classRemove(elem, name);
    }
  };

  ns.setFocus = function(elem, tabIndex) {
    elem.tabIndex = tabIndex;
    setTimeout(function() { elem.focus(); }, 0);
  };

  // doesn't work for opacity
  // don't use with shorthand styles
  // converts to pixels
  // need to use camelCase style names
  ns.getActualStyle = function(elem, styleName) {
    var result;
    if (window.getComputedStyle) {
      result = getComputedStyle(elem, null)[styleName]; 
    } if (elem.currentStyle) {
      result = elem.currentStyle[styleName];
      // From Dean Edwards http://erik.eae.net/archives/2007/07/27/18.54.15/#comment-102291
      // If we're not dealing with a regular pixel number
      // but a number that has a weird ending, we need to convert it to pixels
      if ( !/^\d+(px)?$/i.test( result ) && /^\d/.test( result ) ) {
        // Remember the original values
        var left = elem.style.left;
        var rsLeft = elem.runtimeStyle.left;

        // Put in the new values to get a computed value out
        elem.runtimeStyle.left = elem.currentStyle.left;
        style.left = result || 0;
        result = style.pixelLeft + "px";

        // Revert the changed values
        style.left = left;
        elem.runtimeStyle.left = rsLeft;
      }
    }
    return result;
  };

  ns.getHeight = function(elem) {
    var h = elem.offsetHeight;
    // subtract borders
    h -= parseFloat(ns.getActualStyle(elem, "borderTopWidth")) || 0;
    h -= parseFloat(ns.getActualStyle(elem, "borderBottomWidth")) || 0;
    return h;
  }

})(wls.console);

var buttonTracking;

function PageButton(disabled,className) {
  this.disabled = disabled;
  this.className = className;
}

function doSaveButton(form) {
  wls.console.doingSubmit();
  form.submit();
  return true;
}

function doNextAction(form, action) {
  wls.console.doingSubmit();
  form.action = action;
  form.submit();
  return true;
}

function disableButton(btn) {
  btn.disabled = true;
  if (btn.className.indexOf("-disabled") == -1) {
    btn.className += "-disabled";
  }
}

function enableButton(btn) {
  btn.disabled = false;
  btn.className = btn.className.replace("-disabled", "");
}

function disableButtons() {
  var button, j;
  var inputButtons;
  var buttonButtons;
  inputButtons = document.getElementsByTagName("input");
  buttonButtons = document.getElementsByTagName("button");
  buttonTracking = new Array(inputButtons.length + buttonButtons.length);
  j = 0;
  for (var i=0;i<inputButtons.length;i++) {
    button = inputButtons[i];
    if (button.type == 'button'){
        buttonTracking[j] = new PageButton(button.disabled,button.className);
        j++;
        disableButton(button);
    }
  }
  for (var i=0;i<buttonButtons.length;i++) {
    button = buttonButtons[i];
    buttonTracking[j] = new PageButton(button.disabled,button.className);
    j++;
    disableButton(button);
  }
  document.body.style.cursor = 'wait';
}

function restoreButtons() {

  var button, j;
  var inputButtons;
  var buttonButtons;
  inputButtons = document.getElementsByTagName("input");
  buttonButtons = document.getElementsByTagName("button");
  j = 0;
  for (var i=0;i<inputButtons.length;i++){
    button = inputButtons[i];
    if (button.type == 'button'){
        button.disabled = buttonTracking[j].disabled;
        button.className = buttonTracking[j].className;
        j++;
    }
  }
  for (var i=0;i<buttonButtons.length;i++){
    button = buttonButtons[i];
    button.disabled = buttonTracking[j].disabled;
    button.className = buttonTracking[j].className;
    j++;
  }
  document.body.style.cursor = 'default';
}
