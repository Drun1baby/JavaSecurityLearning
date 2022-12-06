/*
  Functions to support forms handling

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

// new code should go in this block
(function(ns) {

  //
  // FileChooser support
  //
  ns.fcUpdatePath = function(rb, tfid) {
    var pathInput;
    if (rb.checked) {
      pathInput = document.getElementById(tfid);
      if (pathInput) {
        pathInput.value = rb.value;
      }
    }
  };

  //
  // Warn user about unsaved changes in a form support
  // All this assumes there is a single form whose changes are to be checked
  // before unloading.
  //
  var isSubmitting = false;
  var isDirty = false;

  // doingSubmit is used in combination with the form unload checking
  // call doingSubmit before submitting a form
  ns.doingSubmit = function() {
    isSubmitting = true;
  };

  ns.setDirty = function(dirty) {
    isDirty = dirty;
  };

  ns.warnOnUnsavedChanges = function(form, saveMsg) {
    window.onbeforeunload = function() {
      if (isSubmitting) {
        return;
      }
      if (checkDirty(form)) {
        return saveMsg;
      }
    };
  };

  // use this when a different form is submitting
  // return true if the submit should be canceled
  ns.checkForUnsavedChanges = function(form, saveMsg) {
      if (checkDirty(form)) {
        return !confirm(saveMsg);
      }
      return false;
  };

  function checkDirty(form) {
    var control;
    if (isDirty) {
      return true;
    }
    if (!form.elements) {
      return false;
    }
    for(var i=0; i<form.elements.length; i++) {
      control = form.elements[i];
      if (!control.name || control.disabled) {
        continue
      } 
      if (control.type == 'submit' ||
          control.type == 'radio'  ||
          control.type == 'hidden' ||
          control.type == 'button' ||
          control.type == 'select-multiple') {
        continue;
      }
      if (getControlValue(control) != getControlDefaultValue(control)) {
        return true;
      }
    }
    return false;
  }

  function getControlValue(control) {
    var val;
    var def;
    if (control.type == 'checkbox') {
      return control.checked;
    } else if (control.type == 'select-one') {
      for(var i=0; i<control.options.length; i++) {
        if (control.options[i].selected) {
          return control.options[i].value;
        }
      }
      return null;
    } else {
      return control.value;
    }
  }

  function getControlDefaultValue(control) {
    var val;
    var def;
    if (control.type == 'checkbox') {
      return control.defaultChecked;
    } else if (control.type == 'select-one') {
      for(var i=0; i<control.options.length; i++) {
        if (control.options[i].defaultSelected) {
          return control.options[i].value;
        }
      }
      return null;
    } else {
      return control.defaultValue;
    }
  }

  //
  // Handle enter key in console forms
  // The normal browser enter key handling doesn't work when the form
  // doesn't have a normal submit button. Console uses buttons outside
  // the form to submit programmatically. So this event handler is 
  // needed to process the Enter key.
  // Call registerDefaultFormAction for each form to set the default button.
  // Note: currently there is no visual indication of which is the default button.
  //
  ns.enterHandler = function(e) {
    var target;
    var type;
    var formName;
    var f;
    if (!e) {
      e = window.event;
    }
    if (e.keyCode == 13 &&  /* 13 is Enter */
        !isSubmitting) {
      if (e.target) {
        target = e.target;
      } else if (e.srcElement) {
        target = e.srcElement;
      }
      if (target.nodeType == 3) {
        e.target = e.target.parentNode;
      }
      if (nodeName(target, "input")) {
        type = target.getAttribute("type");
        if (type == "text" || type == "checkbox" || type == "radio") {
          // get the form this control is in
          formName = target.form.name;
          f = defaultFormActions[formName];
          if (!f) {
            f = defaultFormActions.unknown;
          }
          if (f !== undefined) {
            f();
            return false;
          }
        }
      }
    }
  };

  var defaultFormActions = {}; // map from form name to function

  ns.registerDefaultFormAction = function(form, action) {
    if (!defaultFormActions[form]) {
      defaultFormActions[form] = action;
    }
  };

  function nodeName(e, name) {
    return e.nodeName && e.nodeName.toUpperCase() == name.toUpperCase();
  }

})(wls.console); 

var formPresent = true;

function Array_pop(){
  var response = this[this.length -1];
  this.length--;
  return response;
}

if (typeof(Array.prototype.pop) == "undefined"){
  Array.prototype.pop = Array_pop;
}

function Array_push(){
  var A_p = 0;
  for (A_p = 0; A_p < arguments.length; A_p++){
    this[this.length] = arguments[A_p];
  }
  return this.length;
}

if (typeof(Array.prototype.push) == "undefined"){
   Array.prototype.push = Array_push;
}

var dependencyList = {};

/**
 * declare that control c1 depens on control c2 having one of the values
 */
function dependsOn(c1, c2, values) {
    if (!dependencyList[c2]) {
        dependencyList[c2] = [];
    }
    dependencyList[c2].push(new Dependency(values, c1));
}

function Dependency(enabledValues, controlName) {
    this.enabledValues = enabledValues;
    this.controlName = controlName;
    this.doDependency = Dependency_doDependency;
}

function Dependency_doDependency (selectedValue, control) {

  var enabled = false;
  var donotProcess = false; //radio button logic needs this flag.

  // if a control is disabled then all the controls that depend on it
  // must also be disabled
  if (!control.disabled) {
    for(var option=0;option < this.enabledValues.length;option++) {

      if (this.enabledValues[option] == "$any" && selectedValue !== "") {
        enabled = true;
      }
      if (selectedValue == this.enabledValues[option] && control.type != 'radio') {
        enabled = true;
      }

      //
      // Check for radio button dependencies. Radio buttons appear as arrays with the
      // same name. Process the dependency only if the current radio control's value is
      // same as the enabledValue.
      //
      if(control.type == 'radio'){
        if(selectedValue == this.enabledValues[option]) {
          if(control.checked){
            enabled = true;
          } else {
            enabled = false;
          }
        } else {
          donotProcess = true;
        }
      }
    }
  }

  //
  // Do actual state change on dependent HTML control here
  //
  var depControl = null;

  if (!donotProcess) {
    // getControl returns null when control not found so below !== null checks are OK
    depControl = getControl(this.controlName);

    if (depControl !== null) {
      depControl.disabled = !enabled;
      // the value of the control hasn't changed but its disabled state may have
      // so need to process any controls that may depend on depControl
      controlChanged(depControl);
    }
    depControl = getElement(this.controlName+"_row");
    if (depControl !== null) {
      if (enabled) {
        removeClass(depControl, "disabled");
      } else {
        addClass(depControl, "disabled");
      }
    }
  }
  return;
}

function controlChanged(control) {

  // Since we're handling checkboxes a bit
  // differently in 9.0, we can just ignore
  // hidden fields ( I hope )
  if (control.type == 'hidden') {
    return;
  }

  var controlName = control.name;
  if (!dependencyList[controlName] || dependencyList[controlName].length === 0){
    return;
  }

  var selectedValue = "";
  if (control.type == 'checkbox') {
    if (control.checked) {
      selectedValue = 'true';
    } else {
      selectedValue = 'false';
    }
  } else if (control.type == 'select-one') {
    var selected = control.selectedIndex;
    selectedValue = control.options[selected].value;
  } else if (control.type == 'hidden') {
    selectedValue = control.value;
  } else if (control.type == 'button') {
    // Special handling for buttons
    selectedValue = "function";
  } else if (control.type == 'radio') {
    selectedValue = control.value;
  } else {
    return;
  }

  // Normal dependencies
  for(var option=0;option < dependencyList[controlName].length;option++) {

    if (selectedValue != "function"){
      dependencyList[controlName][option].doDependency(selectedValue, control);
    }else{
      // Run the function assigned
      var functionName = dependencyList[controlName][option].enabledValues;
      var result = eval(functionName+"(control)");
    }
  }
}

function initializeDependentControls(form) {
  formName = form;
  var control;
  if (!form || !form.elements) {
    return;
  }
  for(var i = 0; i < form.elements.length; i++) {
    control = form.elements[i];
    controlChanged(control);
  }
}

/**
 * onclick handler for checkboxes
 * It does the dependency checking and also sets a hidden input
 * presumably to get around the issue with only checked control values going
 * to the server.
 */
function checkboxChanged(checkbox)
{
  var boxName = checkbox.name;
  controlChanged(checkbox);
  if (checkbox.type == "checkbox") {
    checkbox.form.elements[boxName][1].value = (checkbox.checked)? 'true' : 'false';
  }
}

function getElement(id){
  if (document.getElementById){
    return document.getElementById(id);
  }else if (document.all){
    return document.all[id];
  }
  return null;
}

function addClass(el, theClass) {
  var cn = el.className;
  if (cn == theClass || cn.indexOf(" " + theClass) >= 0 || cn.indexOf(theClass + " ") >= 0) {
    return;
  }
  el.className += " " + theClass;
}

function removeClass(el, theClass) {
  var cn = el.className;
  if (cn == theClass) {
     cn = "";
  }
  else {
     cn = cn.replace(new RegExp(" " + theClass), "");
     cn = cn.replace(new RegExp(theClass + " "), "");
  }
  el.className = cn;
}

function getControl(controlName){
  var form = getFormFor(controlName);
  if (!form.elements) {
    return null;
  }
  for (var i=0;i<form.elements.length;i++){
    var control = form.elements[i];
    if (control.name == controlName) {
      return control;
    }
  }
  return null;
}

function getFormFor(controlName){
    return formName;
}

function editPred(url){
  wls.console.doingSubmit();
  this.location.href = url;
  return false;
}

function setControlDefaultvalue(controlId){
  var control = document.getElementById(controlId);
  if (control){
    if (control.type == 'select-one'){
      if (control.options.length > 0){
        control.options[0].defaultSelected = true;
      }
    }
  }
}

function focusSelect(radioField, radioFieldSuffix, selectField, textField) {
  var prefix = radioField.name.substring(0, radioField.name.indexOf(radioFieldSuffix));
  var targetField = document.getElementById(prefix+textField);
  targetField.value="";
  targetField.disabled=true;
  addClass(getElement(targetField.name+"_row"), "disabled");
  document.getElementById(prefix+selectField).disabled = false;
  removeClass(getElement(prefix+selectField+"_row"), "disabled");
}

function focusText(radioField, radioFieldSuffix, textField, selectField) {
  var prefix = radioField.name.substring(0, radioField.name.indexOf(radioFieldSuffix));
  var targetField = document.getElementById(prefix+selectField);
  targetField.selectedIndex = 0;
  targetField.disabled=true;
  var taretFieldRow = getElement(targetField.name+"_row");
  addClass(taretFieldRow, "disabled");
  document.getElementById(prefix+textField).disabled=false;
  removeClass(getElement(prefix+textField+"_row"), "disabled");
}
