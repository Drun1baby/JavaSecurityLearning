/*
  Functions to support refreshing a portlet.

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

var interval = null;
var delay = 10000; // 10 seconds
var portletRefreshStarted = false;
var refreshers = new Array(0);
var refresherAcks = new Array(4); // refreshAcknowledgments, used to identify a problematic refresh

function RefreshRegion(region,interval,refreshedOnce){
  this.region = region;
  this.interval = interval;
  this.refreshedOnce = refreshedOnce;
}

function RefreshAck(region,id){
  this.region = region;
  this.id = id;
  this.ackd = false;
}

function findRefreshRegion(region){
  for (i = 0;i < refreshers.length;i++){
    if (refreshers[i].region == region)
      return refreshers[i];
  }
  return null;
}

function startRefreshPortlet(region,pageLabel,validate,period, extraparams, refreshDate, refreshActive, refreshInactive){

  //
  // If refresh NOT active
  //
  if (document.getElementById("refreshIcon"+region).src.indexOf("_busy.gif")==-1){
    portletRefreshStarted = true;
    document.getElementById("refreshIcon"+region).src = "images/page_lev_busy.gif";
    document.getElementById("refreshIcon"+region).alt = refreshActive;
    delay = period;
    interval = window.setInterval("autoRefresh('"+region+"','"+pageLabel+"','"+validate+"','"+extraparams+"','"+refreshDate+"')",delay);
    var rr = new RefreshRegion(region,interval);
    var tArray = new Array(1);
    tArray[0] = rr;
    refreshers = refreshers.concat(tArray);  // add to internal list

    //
    // Initialized refresherAck
    //
    refresherAcks[region] = new RefreshAck(region,Math.random());
    refresherAcks[region].ackd = false;

  } else {
    portletRefreshStarted = false;
    document.getElementById("refreshIcon"+region).src = "images/page_lev_idle.gif";
    document.getElementById("refreshIcon"+region).alt = refreshInactive;

    //
    // clear out interval when removed, search
    // for correct interval because there may
    // be mulitple refresh regions present.
    //
    for (var i=0;i<refreshers.length;i++){
      if (refreshers[i].region == region){
        window.clearInterval(refreshers[i].interval);
        refreshers.splice(i,1); // remove refresh region
      }
    }
  }
}

//
// Portlet refresh code. This code defaults to using pure AJAX, but when 
// that is not available will degrade to using IFRAME transport for 
// dynamically sending contents to and from the server.
//
var xmlObj = null;
var refreshDate;
function autoRefresh(region,pageLabel,validate,extraparams, refDate){

  if (window.ActiveXObject){
    xmlObj = new ActiveXObject("Microsoft.XMLHTTP");
  }else if (window.XMLHttpRequest){
    xmlObj = new XMLHttpRequest();
  }
  refreshDate = refDate;
  xmlObj.onreadystatechange = processRefreshPortlet;

  // set refresh acknowledgement, per region,
  // by the time this method is called, the refresh region
  // should never be null.
  var rr = findRefreshRegion(region);
  //
  // Don't do anything the first request since auto refresh
  // is 'always' called no matter what.
  //
  if (rr.refreshedOnce){
    // check to see if an ack object has been created and initialized
    if (refresherAcks[region]==null){
      // initialize a new ack object
      refresherAcks[region] = new RefreshAck(region,Math.random());
      refresherAcks[region].ackd = false;
    }else{
      // test to see if latest ack was set
      if (refresherAcks[region].ackd == false){
        // The portletrefresh.jsp hasn't got a response yet. so, return and wait for the response.
        return;
      }
      // update existing refresher ack id for next request
      refresherAcks[region].id = Math.random();
      refresherAcks[region].ackd = false;
    }
  }else{
    rr.refreshedOnce = true;
  }

  //
  // IFRAME transport, notification will be received when IFRAME is loaded
  //
  var url = contextPath + "/jsp/common/portletrefresh.jsp?pageLabel="+pageLabel+"&validate="+validate+"&refreshOnly=true&region="+region+"&dummy="+Math.random()+extraparams;
  var iFrameName = "remoteframe"+region;
  var theIFrame = frames[iFrameName];
  if (!theIFrame) {
    makeIFrame(iFrameName, url);
  } else {
    theIFrame.location.href = url;
  }
}

function makeIFrame(name, url) {
  var elem;
  var iframeElem;
  elem = document.getElementById("refresh-region");
  iframeElem = document.createElement("iframe");
  iframeElem.setAttribute("id", name);
  iframeElem.setAttribute("name", name);
  iframeElem.setAttribute("src", url);
  elem.appendChild(iframeElem);
  frames.remoteframeToolbar;
}

//
// callback function used by iframe transport. IFRAME transport
// is used by clients that do not support XMLHttpRequest transport
//
function processRefreshPortletIFRAME(doc, region, fragmentvalid, errorMsg, refDate){

  // Update acks for region
  if (refresherAcks[region] != null)
    refresherAcks[region].ackd = true;

  // Update time
  if (fragmentvalid){
    document.getElementById("lastRefreshed"+region).innerHTML = refDate;
  }else{
    // If doc is not valid then display error message and don't update current fragment
    document.getElementById("lastRefreshed"+region).innerHTML = errorMsg;
  }

  // This is the updated portlet fragment sent from the server
  var serverTable = doc.getElementById("table-refresh"+region);

  // This is the current portlet fragment that is
  // currently loaded into the browser DOM
  var browserTable = document.getElementById("table-refresh"+region);

  // Make sure both are valid before continuing
  if (serverTable != null && browserTable != null) {
    // innerHTML is the preferred way to update because it is faster.
    browserTable.innerHTML = serverTable.innerHTML;
  }

  return false;
}

function processRefreshPortlet(){

  if (xmlObj.readyState == 4){
    if (xmlObj.status == 200){

      // Update time
      document.getElementById("lastRefreshed").innerHTML = refreshDate;

      // This is the updated portlet fragment sent from the server
      var serverTable = xmlObj.responseText;

      // This is the current portlet fragment that is
      // currently loaded into the browser DOM
      var browserTable = document.getElementById("table-refresh");

      // Make sure both are valid before continuing
      if (serverTable != null && browserTable != null) {

        // It would be really nice to work with DOM here
        // but for some reason the browsers refuse to
        // accept the nodes returned from the XMLHttpRequest call.
        // But innerHTML seems to work okay for this purpose.
        browserTable.innerHTML = serverTable;
      }
    }
  }
}

//
// end test code
//
