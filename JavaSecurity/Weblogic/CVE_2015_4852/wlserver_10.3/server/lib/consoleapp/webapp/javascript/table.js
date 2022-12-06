/*
  Functions used by the TableTag (wl:table)

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

var selectedTableNode = null;
var selectedTableNodeValue = "";

function editThis(cell,handle,property,editor,evt){

  var element = document.getElementById(cell.id);
  if(selectedTableNode != null)
  {
    if(selectedTableNode==element) {
      dismissEdit();
      return;
    } else {
      dismissEdit();
    }
  }

  selectedTableNode = element;

  // Save value of text field for later
  if(selectedTableNode.childNodes !=null && selectedTableNode.childNodes.length>0)
    selectedTableNodeValue = element.childNodes[0].nodeValue;

  var inputField = createInputField(element,property,handle,editor);

  if(selectedTableNode.childNodes !=null && selectedTableNode.childNodes.length>0)
    element.replaceChild(inputField, element.childNodes[0]);

  inputField.focus();
  inputField.select();

  // Keep mouse click from propagating to document
  // otherwise document event handlers will be triggered
  if (document.all) evt.cancelBubble = true;
  else evt.stopPropagation();
}

function dismissEdit(){
  if (selectedTableNode != null) {
    var text = createText(selectedTableNodeValue);
    if(selectedTableNode.childNodes !=null && selectedTableNode.childNodes.length>0)
      selectedTableNode.replaceChild(text,selectedTableNode.childNodes[0]);
  }
  //initialize these values so that they don't get propogated to the next field clicked.
  selectedTableNode = null;
  selectedTableNodeValue = "";
}

function createInputField(element,property,handle,editor){
  var node = document.createElement("INPUT");
  node.setAttribute("autocomplete", "off");
  node.setAttribute("type","TEXT");
  node.onkeypress = saveIf;
  node.setAttribute("name","DYNTEXTFIELD");
  node.style.background = "#E7EFFC";
  node.style.border = "1px solid #19355E";
  node.style.paddingBottom = "2px";
  node.setAttribute("size","16");

  if(element.childNodes ==null || element.childNodes.length==0)
    element.appendChild(createText(''));

  node.setAttribute("value",element.childNodes[0].nodeValue);

  var id = "prop("+property+")mo("+handle+")editor("+editor+")";
  node.setAttribute("id",id);
  return node;
}

function createText(value){
  var node = document.createTextNode(value);
  return node;
}

//
// Rename table item checkboxes
//
function renameCheckboxes(formObj, newName){
  var els = formObj.getElementsByTagName("input");
  for (var i=0;i<els.length;i++){
    if ((els[i].type == 'checkbox' || els[i].type == 'radio') && els[i].name != 'all'){
      els[i].name=newName;
    }
  }
}

function doNothing(){
  return false;
}

//
// Document handler for table editing
//
document.onclick = dismissEdit;

//
// Table button dependencies code
//

var tableButtonDependencies = new Object();

function addTableButtonDependency(fn, controlName) {
  tableButtonDependencies[controlName] = fn;
}

function updateTableButtons(form) {
  for (var btn in tableButtonDependencies) {
    var result = tableButtonDependencies[btn](form);
    var els = form.elements[btn];

    if (els == null)
      return;

    for (var k = 0; k < els.length; k++) {
      if (result)
        disableButton(els[k]);
      else
        enableButton(els[k]);
    }
  }
}

function initializeTableControls(form) {
  updateTableButtons(form)
  return;
}

/*
  Functions to use for table button dependency checking
  these dependency functions use inverted logic because they
  determine if something is to be *disabled*
*/
function atLeastOneSelected(form){

  for (var j=0;j<form.elements.length;j++){
    var ctl = form.elements[j];
    if (ctl.type == 'checkbox' && ctl.name != 'all' || ctl.type == 'radio'){
      if (ctl.checked){
        return false;
      }
    }
  }

  return true;
}

function exactlyOneSelected(form){

  var ctr = 0;
  for (var j=0;j<form.elements.length;j++){
    var ctl = form.elements[j];
    if (ctl.type == 'checkbox' && ctl.name != 'all' || ctl.type == 'radio'){
      if (ctl.checked){
        ctr++;
      }
    }
  }

  if (ctr == 1) return false;

  return true;
}

function atLeastOneRow(form){
  var ctr = 0, ctrNum = 0;
  if (form.elements != null){
    for (var j=0;j<form.elements.length;j++){
      var ctl = form.elements[j];
      if (ctl.type == 'checkbox' && ctl.name != 'all' || ctl.type == 'radio'){
        ctrNum++;
        if (ctl.checked){
          ctr++;
        }
      }
    }

    if (ctrNum > 0 && ctr == 0) return false; else return true;
  }
  return true;
}

function emptyTable(form) {
  var ctr = 0, ctrNum = 0;
  if (form.elements != null) {
    for (var j=0;j<form.elements.length;j++) {
      var ctl = form.elements[j];
      if (ctl.type == 'checkbox' && ctl.name != 'all' || ctl.type == 'radio') {
        ctrNum++;
        if (ctl.checked) {
          ctr++;
        }
      }
    }
    if (ctrNum == 0 && ctr == 0) return false; else return true;
  }
  return true;
}

//
// function for checking all checkboxes
//
function checkAll(cAll, form){
  var cbs = form.elements;
  if (cbs == undefined) return ; // if no rows, return
  if (typeof cbs.length == "undefined") {  // if 1 row, browser treats as non-array
    if (cAll.checked && !cbs.checked) cbs.checked = true;
    if (!cAll.checked && cbs.checked) cbs.checked = false;
    updateTableButtons(form);
    return;
  }

  for (var i=0; i < cbs.length;i++) {
    if (!cAll.checked && cbs[i].checked) cbs[i].checked = false;
    if (cAll.checked && !cbs[i].checked) cbs[i].checked = true;
  }

  // button test
  updateTableButtons(form);
}

// 
// function for unchecking "ALL" checkbox
// in the event one checkbox of a check box is unchecked
// It is smart-enough to reselect the "all" checkbox
// if you reselect the last item in a list
//
function unCheck(item, form){
  // button test
  updateTableButtons(form);
  // dump out on radio buttons
  if (item.type == 'radio') return;
  if (!item.checked) {
    form.all.checked = false;
  } else {
    var cbs = form.elements[item.name];

    for (var i=0; i < cbs.length;i++) {
      if (!cbs[i].checked) return false;
    }
    form.all.checked = true;
  }
}
