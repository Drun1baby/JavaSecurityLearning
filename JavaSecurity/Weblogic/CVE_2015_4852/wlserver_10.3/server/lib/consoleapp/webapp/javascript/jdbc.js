/*
  Functions used by the JDBC Data Source config jsps. Selects different 
  jdbc transaction protocols, based on the data source participaton 
  in global transactions and selection of an XA driver

  Copyright (c) 2003,2008, Oracle and/or its affiliates. All rights reserved.
*/

function setProtocols(form, globalTxCheckbox) {
  if (globalTxCheckbox.checked == false){
    for (var i = 0; i < form.elements.length; i++) {
      if(form.elements[i].value == "LoggingLastResource")
        form.elements[i].disabled = true;
      else if (form.elements[i].value == "EmulateTwoPhaseCommit")
        form.elements[i].disabled = true;
      else if (form.elements[i].value == "OnePhaseCommit")
        form.elements[i].disabled = true;
    }
  } else {
    for (var i = 0; i < form.elements.length; i++) {
      if (form.elements[i].value == "LoggingLastResource")
        form.elements[i].disabled = false;
      else if (form.elements[i].value == "EmulateTwoPhaseCommit")
        form.elements[i].disabled = false;
      else if (form.elements[i].value == "OnePhaseCommit") {
        form.elements[i].disabled = false;
        form.elements[i].checked = true;
      }
    }
  }
}

