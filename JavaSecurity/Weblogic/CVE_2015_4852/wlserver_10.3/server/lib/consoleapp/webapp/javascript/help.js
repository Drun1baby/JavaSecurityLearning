/*
  Functions to handle help display and resizing

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

var isIE=(document.all != null)&&(document.getElementById != null);
var isDOM=document.getElementById&&!document.all;
var isNS4=document.layers?true:false;
var isIE6withDocType=document.documentElement && document.documentElement.clientHeight;

if (isNS4)
{
  alert("Netscape Navigator 4 is not supported. Please use Netscape 7+, IE5.5+, or Mozilla 1.0+.");
}

/* If no cookie is set for helpExpanded, set it to false. */
var helpExpanded=getCookie("helpExpanded");
if (helpExpanded=="true"){
	helpExpanded=true;
} else if (helpExpanded=="false") {
	helpExpanded=false;
} else if(helpExpanded == null) {
	setCookie("helpExpanded", "false");
	helpExpanded=false;
}


function helpChangeState(state)
{
  document.toggleHelpVisibilityForm.wlpHelp.value = state;
  if(isIE) showWaitState();
  document.toggleHelpVisibilityForm.submit();
}

function setCookie(name, value) {
  var curCookie = name + "=" + escape(value);
  document.cookie = curCookie;
}

// * return string containing value of specified cookie or null if cookie does not exist
function getCookie(name) {
  var dc = document.cookie;
  var prefix = name + "=";
  var begin = dc.indexOf("; " + prefix);
  if (begin == -1) {
	begin = dc.indexOf(prefix);
	if (begin != 0) return null;
  } else
	begin += 2;
  var end = document.cookie.indexOf(";", begin);
  if (end == -1)
	end = dc.length;
  return unescape(dc.substring(begin + prefix.length, end));
}

var isDialogDisplayed = false;
var dialogHeight = 0;
var dialogWidth = 0;
var theDialogDiv;
var oldDialogInnerHTML;

function toggleDialogBox(theId,height,width,title)
{
  theDialogDiv = document.getElementById(theId);
  dialogHeight = height;
  dialogWidth = width;
  isDialogDisplayed = !isDialogDisplayed;
  dialogBkgdDiv = document.getElementById("dialogBackgroundDiv");

  title = htmlChars(title);

  if (isDialogDisplayed) 
  {
    addDialogTitle(title);
    setDialogSizeAndPos();
  } else
  {
    theDialogDiv.innerHTML = oldDialogInnerHTML;
  }
  toggleDialogBkgd();
  var viz = isDialogDisplayed ? "visible" : "hidden";
  theDialogDiv.style.visibility = viz;

  if (isDialogDisplayed)
  {
    var keepGoing = true;
    var divElements = theDialogDiv.getElementsByTagName('INPUT');
    for (i=0; i<divElements.length && keepGoing; i++)
    {
      if (divElements[i].type=="text")
      {
        divElements[i].focus();
        divElements[i].select();
        keepGoing = false;
      }
    }

    // if there is no text type, let us select the select type....
    if(keepGoing == true)
    {
      divElements = theDialogDiv.getElementsByTagName('SELECT');
      for (i=0; i<divElements.length; i++)
      {
        divElements[i].focus();
        break;
      }
    }		
  }
}

function addDialogTitle(title)
{
	oldDialogInnerHTML = theDialogDiv.innerHTML;
	title = title ? title : "&nbsp;";
	
	var titleDiv = "<div class='table-label-bottom' ";
	titleDiv += "style='vertical-align:top;text-align:left;padding:6px;'>\n";
	titleDiv += "<span class='text_bold_12px'>" + title + "</span>\n";
	titleDiv += "</div>\n";
	titleDiv += "<div style='padding:6px;'>\n";
	theDialogDiv.innerHTML = titleDiv + oldDialogInnerHTML + "\n</div>\n";
}

function toggleDialogBkgd()
{
  var keepGoing = true;
  var dbdViz = isDialogDisplayed ? "visible" : "hidden";
  var hfdViz = isDialogDisplayed ? "none" : "block";

  var divElements = document.getElementsByTagName('SELECT');
  for (i=0; i<divElements.length; i++)
  {
    divElements[i].style.display = hfdViz;
  }

  if (isDialogDisplayed) 
  {
    divElements = theDialogDiv.getElementsByTagName('SELECT');
    for (i=0; i<divElements.length; i++)
    {
      divElements[i].style.display = "block";
    }
  }

  dialogBkgdDiv.style.visibility = dbdViz;
}

function setDialogSizeAndPos()
{
	if (isDialogDisplayed)
	{
		var base;
		
		if (isIE6withDocType)
		{
			base = document.documentElement;
		} else
		{
			base = document.body;
		}
		
		var ch = base.clientHeight;
		var sh = base.scrollHeight;
		var cw = base.clientWidth;
		var sw = base.scrollWidth;

		var theTop;
		var theLeft;
		
		if ( (ch - dialogHeight) < 0 )
		{
			theTop = base.scrollTop;
		} else {
			theTop = parseInt((ch - dialogHeight)/2) + base.scrollTop;				
		}

		if ( (cw - dialogWidth) < 0 )
		{
			theLeft = base.scrollLeft;
		} else {
			theLeft = parseInt((cw - dialogWidth)/2) + base.scrollLeft;				
		}
				
		if (isDOM)
		{
			// Appears to be Mozilla
			dialogBkgdDiv.style.height = ((ch > sh)? ch : sh) + "px";
			dialogBkgdDiv.style.width = ((cw > sw)? cw : sw) + "px";
			theDialogDiv.style.top = theTop + "px";
			theDialogDiv.style.left = theLeft + "px";
			theDialogDiv.style.height = dialogHeight + "px";
			theDialogDiv.style.width = dialogWidth + "px";
		} else
		{
			dialogBkgdDiv.style.height = (ch > sh)? ch : sh;
			dialogBkgdDiv.style.width = (cw > sw)? cw : sw;
			theDialogDiv.style.top = theTop;
			theDialogDiv.style.left = theLeft;
			theDialogDiv.style.height = dialogHeight;
			theDialogDiv.style.width = dialogWidth;
		}
	}
}

onresize=setDialogSizeAndPos;
onscroll=setDialogSizeAndPos;

function showWaitState() {
  var waitDiv = document.getElementById("waitDiv");
  if (waitDiv != null) 
  {
    waitDiv.style.visibility = "visible";
  }
}

function checkEnter(e, evalOK, evalCancel) {
  e = isIE ? window.event : e;
  var characterCode = e.keyCode;

  if(characterCode == 13)
  {
    eval(evalOK);
  } else if (characterCode == 27)
  {
    if (evalCancel != null) eval(evalCancel);
    toggleDialogBox(theDialogDiv.id);
  }
}
