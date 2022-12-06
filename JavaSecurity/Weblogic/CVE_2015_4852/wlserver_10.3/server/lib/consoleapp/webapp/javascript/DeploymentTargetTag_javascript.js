/*
  Functions used by the DeploymentTargetTag (wl:deployment-target)

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

  var deploymentResultControl;
  var deploymentVirualHostResultControl;
  var deploymentServerList = new Array();
  var deploymentVirtualList = new Array();
  var deploymentClusterList = new Array();
  var deploymentClusterRadioArray = new Array();
  var deploymentClusterServerList = new Array();
  var submitActionList = new Array();

  function TargetControlAction() {
    this.onSubmit = TargetControlAction_onSubmit;
  }

  //
  // This function is called on submit of a form containing
  // a targetting control. This function collections all selected
  // items and sets a value on a hidden field that is then
  // parsed into selected targets on the server-side
  //
  function TargetControlAction_onSubmit (formname) {

    var targets = new Array();
    var virtualTargets = new Array();

    for (var s=0; s<deploymentServerList.length; s++) {
      var control = getControl(deploymentServerList[s]);
      if (control.checked) {
        targets.push(control.value);
      }
    }
    for (var s=0; s<deploymentVirtualList.length; s++) {
      var control = getControl(deploymentVirtualList[s]);
      if (control.checked) {
        virtualTargets.push(control.value);
      }
    }
    for (var c=0; c<deploymentClusterList.length; c++) {
      var control = getControl(deploymentClusterList[c]);
      if (control.checked) {
        control = getControl(deploymentClusterRadioArray[deploymentClusterList[c]]);
        if (control.value == 'all' && control.checked) {
            control = getControl(deploymentClusterList[c]);
            targets.push(control.value);
        } else {
          var servers = deploymentClusterServerList[deploymentClusterList[c]];
          for (var s=0; s<servers.length; s++) {
            control = getControl(servers[s]);
            if (control.checked) {
              targets.push(control.value);
            }
          }
        }
      }
    }
    var hidden = getControl(deploymentResultControl);
    for (var i=0; i<targets.length; i++) {
      hidden.value = hidden.value + targets[i];
      if (i<targets.length-1)
        hidden.value = hidden.value + "\n";
    }
   
    if (deploymentVirualHostResultControl != null) {
      hidden = getControl(deploymentVirualHostResultControl);
      for (var i=0; i<virtualTargets.length; i++) {
      hidden.value = hidden.value + virtualTargets[i];
      if (i<virtualTargets.length-1)
        hidden.value = hidden.value + "\n";
      }
    }
  } 

  submitActionList.push(new TargetControlAction());

  //
  // This function enables us to check and uncheck selections
  // based on cluster selections in the targetting tag
  //
  // @param control The Cluster Checkbox control
  // @param radioControl The Radio Button associated with this cluster
  // @param clusterControl The Cluster Checkbox control ???
  //
  function clusterMemberChanged(control,controlLiteral,radioControl,clusterControl) {
    var clusterControl = getIndexedControl(clusterControl);

    if (control.checked) {
      if (radioControl != null) {
        radioControl.checked = true;   
      }
      if (clusterControl != null) {
        clusterControl.checked = true;
      }
    }else{

      // Need to deselect everything we've done for this cluster
      var rcontrol = getControl(deploymentClusterRadioArray[controlLiteral]);    // was controlLiteral
      if (rcontrol != null) {
        var radios = eval("document."+form+".elements['" + rcontrol.name + "']");
        if (radios != null) {
          for (var d=0;d<radios.length;d++)
            radios[d].checked=false;
        }
      }
      // Loop thru the list of servers registered for this cluster
      var servers = deploymentClusterServerList[controlLiteral];   // was controlLiteral
      if (servers != null){
        for (var s=0; s<servers.length; s++) {
          control = getIndexedControl(servers[s]);
          control.checked = false;
        }
      }
    }    
  }  

  //
  // This function enables you to check or uncheck a cluster
  // control based on whether a radio button in a cluster
  // has been selected
  //
  function clusterRadioChanged(control, theControlLiteral, clusterControlLiteral) {
    var clusterControl = getIndexedControl(clusterControlLiteral);
    if (clusterControl != null) {
      clusterControl.checked = 'true';
    }
    // Need to deselect the servers in the cluster
    var rcontrol = getControl(deploymentClusterRadioArray[theControlLiteral]);
    // Loop thru the list of servers registered for this cluster
    var servers = deploymentClusterServerList[theControlLiteral]; 
    if (servers != null){
      for (var s=0; s<servers.length; s++) {
        control = getIndexedControl(servers[s]);
        control.checked = false;
      }
    }
  }

  //
  // This function returns a control based on an index
  // within a set of controls of a certain name and type
  // The index is expected to be part of the name passed in
  //
  // Note, the <code>form</code> variable is set in the DeploymentTargetTag.java
  // file when the tag renders and doStartTag() is called. This enables the name
  // of the form (based on the ActionForm, to be passed in dynamically
  //
  function getIndexedControl(controlName){
    var idx1 = controlName.indexOf('[');
    var idx2 = controlName.indexOf(']',idx1);
    var fieldNameIdx = controlName.indexOf("document."+form+".");
    var name = null;
    if (fieldNameIdx != -1){
      // The value '10' is based on the length of 'document.' plus an extra '.'
      name = controlName.substring(fieldNameIdx+form.length+10,idx1);
    }else
      name = controlName.substring(0,idx1);

    var index = controlName.substring(idx1+1,idx2);
    var control = eval("document."+form);
    var els;
    if (index >= 0 && control.elements[name].length >= 0)
      els = control.elements[name][index];
    else
      els = control.elements[name];

    return els;
  }

  function getControl(controlName) {
    var form = getFormFor(controlName);
    for(var i=0; i<form.elements.length; i++) {
      var control = form.elements[i];
      if (control.name == controlName)
        return control;
    }
    return null;
  }

  function getFormFor(controlName) {
    return eval("document."+form);
  }
      
