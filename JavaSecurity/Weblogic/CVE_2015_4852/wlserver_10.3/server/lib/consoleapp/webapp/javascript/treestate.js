/*
  Functions used by the TreeTag (wl:tree)

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

var req = null;

//
// Moz/NS/FFX
//
if (window.XMLHttpRequest){
  req = new XMLHttpRequest();
}

//
// IE 5.0+/6.0+
//
if (window.ActiveXObject){
  req = new ActiveXObject("Microsoft.XMLHTTP");
}

var action = null;
var tNodes = null;
var contextPath = getContextPath();

function saveOnServer(value){
  action = "save";
  req.onreadystatechange = processReqChange;
  req.open("GET",getContextPath()+"/jsp/navtree/treestate.jsp?openNodes="+value+"&action=save&dummy="+Math.random(),true);
  req.send(null);
}

function getOnServer(){
  action = "retrieve";
  req.onreadystatechange = processReqChange;
  req.open("GET",getContextPath()+"/jsp/navtree/treestate.jsp?action=retrieve&dummy="+Math.random(),false); // 'false'
  req.send(null);
  return tNodes;
}

function processReqChange(){
  if (req.readyState == 4){
    if (req.status == 200){
      // Here we need to execute an OC locally and redraw the tree, create
      if (action == "retrieve"){
        tNodes = req.responseText;
      }
    }
  }
}

function getContextPath(){

  var tempLocation = window.location.pathname;
  var start = tempLocation.indexOf('/');
  var end = tempLocation.indexOf('/',start+1);
  if (end != -1){
    tempLocation = tempLocation.substring(0,end);
  }

  return tempLocation;
}

