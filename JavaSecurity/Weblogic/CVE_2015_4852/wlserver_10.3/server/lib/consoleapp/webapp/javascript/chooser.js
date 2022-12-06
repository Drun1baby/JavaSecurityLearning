/*
  Functions used by the DynChooserTag and OrderingTag.
  Copyright (c) 2003,2009, Oracle and/or its affiliates. All rights reserved.
*/
/*global wls,window,disableButton,enableButton */
(function(ns) {

var VK_SPACE = 32,
    VK_PAGE_UP = 33,
    VK_PAGE_DOWN = 34,
    VK_LEFT = 37,
    VK_UP = 38,
    VK_RIGHT = 39,
    VK_DOWN = 40;

var clsFocus = "focus";
var clsSelected = "selected";

var selectIgnoreFocus = false;
var msData = {}; // map multi-select control id to data

// begin utility functions
function forEachNextSiblingNode(start, fn) {
  var el = start.nextSibling;
  var ret;
  var i = 0;
  while (el) {
    if (el.nodeType == 1) {
      ret = fn(i, el);
      if (ret === false) {
        return;
      }
      i += 1;
    }
    el = el.nextSibling;
  }
}

function forEachNode(el, tag, fn) {
  var ret;
  var i, els;
  els = el.getElementsByTagName(tag);
  for (i = 0; i < els.length; i++) {
    ret = fn(i, els[i]);
    if (ret === false) {
      return;
    }
  }
}

function cloneEachNode(nodes) {
  var clones = [];
  var i, lbl, cb, c;
  for (i = 0; i < nodes.length; i++) {
    c = nodes[i].cloneNode(true);
    cb = c.getElementsByTagName("input")[0];
    cb.id = cb.id + "c";
    lbl = c.getElementsByTagName("label")[0];
    lbl.htmlFor = lbl.htmlFor + "c";
    clones.push(c);
  }
  return clones;
}

function isVisible(el) {
  var display = ns.getActualStyle(el, "display");
  return display != "none";
}

function scrollIntoView(el, container) {
  var elOffsetTop = el.offsetTop - container.offsetTop;
  var elOffsetBottom = elOffsetTop + el.scrollHeight + 2;
  var top = container.scrollTop;
  var bottom = container.scrollTop + container.clientHeight;
  if (top > elOffsetTop) {
    container.scrollTop = elOffsetTop;
  } else if (bottom < elOffsetBottom) {
    container.scrollTop = elOffsetBottom - container.clientHeight;
  }
}
// end utility functions

function getMultiSelectCtrl(elem) {
  var e = elem;
  while (e && e.nodeName != "FIELDSET" && !ns.classHas(e, "multiSelect")) {
    e = e.parentNode;
  }
  return e;
}

// for each multi-select control need to keep track of the last focused option (li)
// and the function to call when there is a change
function msGetCtrlData(ctrl) {
  var data = msData[ctrl.id];
  if (!data) {
    data = { lastFocus: null, onchange: null };
    msData[ctrl.id] = data;
  }
  return data;
}

function getMultiSelectCtrlData(elem) {
  var ctrl = getMultiSelectCtrl(elem);
  return msGetCtrlData(ctrl);
}

function getChooserCtrl(elem) {
  var e = elem;
  while (e && e.nodeName != "FIELDSET" && !ns.classHas(e, "chooser")) {
    e = e.parentNode;
  }
  return e;
}

function getSelectedCtrl(elem) {
  var chooser = getChooserCtrl(elem);
  var selCtrl = null;
  forEachNode(chooser, "fieldset", function(i, el) {
    if (ns.classHas(el, "multiSelect")) {
      selCtrl = el; // its always the last one
    }
  });
  return selCtrl;
}

function getAvailableCtrl(elem) {
  var chooser = getChooserCtrl(elem);
  var availCtrl = null;
  forEachNode(chooser, "fieldset", function(i, el) {
    if (ns.classHas(el, "multiSelect")) {
      if (availCtrl === null) {
        availCtrl = el; // its always the first one
      }
    }
  });
  return availCtrl;
}

function index(a, item) {
  var i;
  for (i = 0; i < a.length; i++) {
    if (a[i] === item) {
      return i;
    }
  }
  return -1;
}

function getPreviousSiblingNode(start, count) {
  count = count || 1;
  var el = start.previousSibling;
  var i = 0;
  while (el) {
    if (el.nodeType == 1) {
      i += 1;
      if (i >= count) {
        return el;
      }
    }
    el = el.previousSibling;
  }
  return null;
}

function getNextSiblingNode(start, count) {
  count = count || 1;
  var el = start.nextSibling;
  var i = 0;
  while (el) {
    if (el.nodeType == 1) {
      i += 1;
      if (i >= count) {
        return el;
      }
    }
    el = el.nextSibling;
  }
  return null;
}

function getVisibleOptions(ctrl) {
  var items = [];
  forEachNode(ctrl, "LI", function(i, el) {
    if (isVisible(el)) {
      items.push(el);
    }
  });
  return items;
}

function addMultiSelectOptionHandlers(items) {
  var i, item;
  for (i = 0; i < items.length; i++) {
    item = items[i];
    item.onfocus = ns.chooserFocus;
    item.onblur = ns.chooserBlur;
    item.getElementsByTagName("input")[0].onclick = ns.chooserClick;
  }
}

ns.chooserKeyDown = function(e) {
  var target = e.target || e.srcElement;

  var offset = null;
  var select = false;
  var data, items, cb, li, ul;
  var i, cur, next, checked = null, lh, page, start, end;

  if (e.altKey || e.ctrlKey) {
    return;
  }
  if (e.keyCode == VK_PAGE_UP || e.keyCode == VK_PAGE_DOWN) {
    ul = this.getElementsByTagName("ul")[0];
    lh = ns.getHeight(ul.getElementsByTagName("li")[0]);
    if (!lh || lh <= 0) {
      lh = 24; 
    }
    page = (ns.getHeight(ul) / lh).toFixed() - 1;
  }
  select = e.shiftKey;
  if (e.keyCode == VK_UP || e.keyCode == VK_LEFT) {
    offset = -1;
  } else if (e.keyCode == VK_DOWN || e.keyCode == VK_RIGHT) {
    offset = 1;
  } else if (e.keyCode == VK_PAGE_UP) {
    offset = -page;
  } else if (e.keyCode == VK_PAGE_DOWN) {
    offset = page;
  } else if (e.keyCode == VK_SPACE) {
    offset = 0;
    select = true;
  }
  if (offset !== null) {
    items = getVisibleOptions(this);
    data = getMultiSelectCtrlData(this);
    cur = index(items, data.lastFocus);

    if (select && offset !== 0) {
      li = items[cur];
      cb = li.getElementsByTagName("input")[0]; // expect just one checkbox input
      checked = cb.checked;
    }

    next = cur + offset;
    if (select && (cur === 0 && next < cur || cur === items.length - 1 && next > cur)) {
      return false;
    }
    if (next < 0) {
      next = 0;
    } else if (next >= items.length) {
      next = items.length - 1;
    }
    if (next != cur) {
      li = items[next];
      ns.setFocus(li, 0);
    }
    if (select) {
      if (next == cur) {
        li = items[next];
        cb = li.getElementsByTagName("input")[0]; // expect just one checkbox input
        checked = !cb.checked;
        cb.checked = checked;
        ns.classToggle(li, clsSelected, checked);
      } else {
        if (cur > next) {
          start = next;
          end = cur;
        } else {
          start = cur;
          end = next;
        }
        for (i = start; i <= end; i++) {
          li = items[i];
          cb = li.getElementsByTagName("input")[0]; // expect just one checkbox input
          cb.checked = checked;
          ns.classToggle(li, clsSelected, checked);
        }
      }
      if (data.onchange) {
        data.onchange(this);
      }
    }
    return false;
  }
  return;
};

ns.chooserMouseDown = function(e) {
  var target = e.target || e.srcElement;
  var item = target;
  var data, ul;
  var updateCB = true;
  var rightClick;
  
  if (e.which) {
    rightClick = (e.which == 3);
  } else if (e.button) {
    rightClick = (e.button == 2);
  }
  if (rightClick) {
    return;
  }

  if (target.tagName !== "LI") {
    // could be input or label either way the parent is what we want
    item = item.parentNode;
    if (item.tagName !== "LI") {
      return; // mouse event not on an item. Perhaps on scrollbar
    }
    updateCB = false; // because it will get its own click event
  }
  ul = item.parentNode;
  data = getMultiSelectCtrlData(this);
  selectIgnoreFocus = data.lastFocus !== item && target.tagName === "LABEL";

  var cb = item.getElementsByTagName("input")[0]; // expect just one checkbox
  var checked = !cb.checked;
  var items, start, end, i;
  if (e.shiftKey) {
    items = getVisibleOptions(this);
    start = index(items, item);
    end = index(items, data.lastFocus);
    if (end >= 0 && start >= 0 && start != end) {
      if (end < start) {
        start -= 1; // don't include item
        i = start;
        start = end;
        end = i;
      } else {
        start += 1; // don't include item
      }
      for (i = start; i <= end; i++) {
        ns.classToggle(items[i], clsSelected, checked);
        items[i].getElementsByTagName("input")[0].checked = checked;
      }
    }
  }
  ns.classToggle(item, clsSelected, checked);
  if (updateCB) {
    cb.checked = checked;
  }
  ns.setFocus(item, 0);
  if (data.onchange && updateCB) {
    data.onchange(this);
  }
  return false;
};

ns.chooserMouseUp = function(evt) {
  // keep IE8 from showing a selection
  if (document.selection) {
    document.selection.empty();
  }
};

ns.chooserClick = function(evt) {
  var li = this.parentNode;
  var ctrl = getMultiSelectCtrl(this);
  var data = msGetCtrlData(ctrl);

  ns.setFocus(li, 0);
  if (data.onchange) {
    data.onchange(ctrl);
  }
};

ns.chooserFocus = function(evt) {
  var e = evt || window.event;
  var ul = this.parentNode;
  var i, items, data;

  if (selectIgnoreFocus) {
    selectIgnoreFocus = false;
    return;
  }
  data = getMultiSelectCtrlData(this);
  selectIgnoreFocus = false;
  // remove tabindex from all the others
  items = ul.getElementsByTagName("li");
  for (i = 0; i < items.length; i++) {
    items[i].tabIndex = -1;
  }
  this.tabIndex = 0;
  ns.classAdd(this, clsFocus);
  data.lastFocus = this;
};

ns.chooserBlur = function(evt) {
  var e = evt || window.event;
  ns.classRemove(this, clsFocus);
};

function setMultiSelectBestTabIndex(ctrl, start) {
  var i, els, li, data;
  // remove previous tabindex if any
  els = ctrl.getElementsByTagName("li");
  for (i = 0; i < els.length; i++) {
    els[i].tabIndex = -1;
  }

  if (start) {
    // first try to find first selected after i
    forEachNextSiblingNode(start, function(i, el) {
      if (el.nodeName == "LI" && ns.classHas(el, clsSelected) && isVisible(el)) {
        li = el;
        return false;
      }
    });

    if (!li) {
      // settle for first visible after i
      forEachNextSiblingNode(start, function(i, el) {
        if (el.nodeName == "LI" && isVisible(el)) {
          li = el;
          return false;
        }
      });
    }
  }
  if (!li) {
    // try to find first selected
    forEachNode(ctrl, "LI", function(i, el) {
      if (ns.classHas(el, clsSelected) && isVisible(el)) {
        li = el;
        return false;
      }
    });

    if (!li) {
      // settle for first visible
      forEachNode(ctrl, "LI", function(i, el) {
        if (isVisible(el)) {
          li = el;
          return false;
        }
      });
    }
  }

  if (li) {
    data = getMultiSelectCtrlData(ctrl);
    li.tabIndex = 0;
    data.lastFocus = li;
  }
}

function centerButtonsVertically(ctrl, selCtrl) {
  var bh, pad, h, lh = 20;

  h = ns.getHeight(selCtrl) + 6; // 6 is for margin and borders
  forEachNode(ctrl, "span", function(i, el) {
    if (el.className == "likeLabel") {
      lh = ns.getHeight(el.parentNode);
      return false;
    }
  });
  forEachNode(ctrl, "div", function(i, el) {
    if (el.className == "chooserBtns" || el.className == "orderBtns") {
      bh = ns.getHeight(el);
      pad = ((h - bh) / 2) + lh;
      el.style.paddingTop = pad + "px";
      pad -= lh - 3; // 3 is for margin and borders
      el.style.paddingBottom = pad + "px"; // pad bottom for better wrapping
    }
  });
}

function buttonDisable(btn, disable) {
  if (disable) {
    disableButton(btn);
  } else {
    enableButton(btn);
  }
}

//
// MultiSelect operations
//
function msGetSelectedCount(ctrl) {
  var count = 0;
  forEachNode(ctrl, "INPUT", function(i, el) {
    if (el.checked && isVisible(el.parentNode)) {
      count += 1;
    }
  });
  return count;
}

function msGetCount(ctrl) {
  var count = 0;
  forEachNode(ctrl, "LI", function(i, el) {
    if (isVisible(el)) {
      count += 1;
    }
  });
  return count;
}

function msGetSelected(ctrl) {
  var items = [];
  forEachNode(ctrl, "INPUT", function(i, el) {
    if (el.checked && isVisible(el.parentNode)) {
      items.push(el.parentNode);
    }
  });
  return items;
}

function msGetAll(ctrl) {
  return getVisibleOptions(ctrl);
}

function msTriggerChange(ctrl) {
  var data = msGetCtrlData(ctrl);
  if (data.onchange) {
     data.onchange(ctrl);
  }
}

function msAdd(ctrl, items) {
  var i, item;
  var ul = ctrl.getElementsByTagName("UL")[0];
  for (i = 0; i < items.length; i++) {
    item = items[i];
    ns.classRemove(item, clsSelected);
    item.getElementsByTagName("INPUT")[0].checked = false;
    ul.appendChild(items[i]);
  }
  addMultiSelectOptionHandlers(items);
  ns.setFocus(items[0], 0);
  msTriggerChange(ctrl);
}

function msRestore(ctrl, items) {
  var values = {};
  var first;
  var i, item, cb;
  // create a hash by input value to match up with hidden items
  for (i = 0; i < items.length; i++) {
    item = items[i];
    values[item.getElementsByTagName("input")[0].value] = true;
  }
  forEachNode(ctrl, "LI", function(i, el) {
    if (!isVisible(el)) {
      cb = el.getElementsByTagName("input")[0];
      if (values[cb.value]) {
        if (!first) {
          first = el;
        }
        cb.disabled = false;
        el.style.display = "block";
      }
    }
  });
  if (first) {
    ns.setFocus(first, 0);
  }
  msTriggerChange(ctrl);
}

function msRemove(ctrl, items) {
  var i, item;
  for (i = 0; i < items.length; i++) {
    item = items[i];
    item.parentNode.removeChild(item);
  }
  setMultiSelectBestTabIndex(ctrl);
  msTriggerChange(ctrl);
}

function msHide(ctrl, items) {
  var i, item, cb;
  for (i = 0; i < items.length; i++) {
    item = items[i];
    cb = item.getElementsByTagName("input")[0];
    cb.checked = false;
    cb.disabled = true;
    ns.classRemove(item, clsSelected);
    item.style.display = "none";
  }
  setMultiSelectBestTabIndex(ctrl, items[items.length - 1]);
  msTriggerChange(ctrl);
}

function msMoveUp(ctrl) {
  var i, item, prev;
  var sel = msGetSelected(ctrl);
  var top;
  if (sel.length > 0) {
    top = sel[0];
  }
  for (i = 0; i < sel.length; i++) {
    item = sel[i];
    prev = getPreviousSiblingNode(item);
    if (prev) {
      item.parentNode.insertBefore(item, prev);
    }
  }
  if (top) {
    scrollIntoView(top, top.parentNode);
  }
  msTriggerChange(ctrl);
}

function msMoveTop(ctrl) {
  var i, item;
  var sel = msGetSelected(ctrl);
  var first = ctrl.getElementsByTagName("LI")[0];
  var top;
  if (sel.length > 0) {
    top = sel[0];
  }
  for (i = 0; i < sel.length; i++) {
    item = sel[i];
    item.parentNode.insertBefore(item, first);
  }
  if (top) {
    scrollIntoView(top, top.parentNode);
  }
  msTriggerChange(ctrl);
}

function msMoveDown(ctrl) {
  var i, item, next;
  var sel = msGetSelected(ctrl);
  sel.reverse();
  var bottom;
  if (sel.length > 0) {
    bottom = sel[0];
  }
  for (i = 0; i < sel.length; i++) {
    item = sel[i];
    next = getNextSiblingNode(item, 2);
    if (next) {
      item.parentNode.insertBefore(item, next);
    } else {
      item.parentNode.appendChild(item);
    }
  }
  if (bottom) {
    scrollIntoView(bottom, bottom.parentNode);
  }
  msTriggerChange(ctrl);
}

function msMoveBottom(ctrl) {
  var i, item;
  var sel = msGetSelected(ctrl);
  var bottom;
  if (sel.length > 0) {
    bottom = sel[sel.length - 1];
  }
  for (i = 0; i < sel.length; i++) {
    item = sel[i];
    item.parentNode.appendChild(item);
  }
  if (bottom) {
    scrollIntoView(bottom, bottom.parentNode);
  }
  msTriggerChange(ctrl);
}

//
// Init
//
ns.chooserInit = function(hiddenId, chooserId) {
// This init fuction is something that would normally be done on DOM ready
// but we don't have the ability to do that so instead it is called from 
// javascript rendered just after the chooser control. This works fine except
// in IE6 where the DOM isn't ready yet (or at least not layed out) so that is 
// the reason for the setTimeout
  setTimeout(function() {

  var items;
  var availCtrl = null; // stays null for reorder only
  var selCtrl = null;
  var btnMove, btnMoveAll, btnRemove, btnRemoveAll, btnTop, btnUp, btnDown, btnBottom;
  var ctrl = document.getElementById(chooserId);
  var data, disabled;
  var initialSelection = null;

  // get the one or two multi select controls
  forEachNode(ctrl, "fieldset", function(i, el) {
    if (ns.classHas(el, "multiSelect")) {
      if (!availCtrl) {
        availCtrl = el;
      } else {
        if (!selCtrl) {
          selCtrl = el;
        }
      }
    }
  });
  if (!selCtrl) {
    // must be a reorder only control
    selCtrl = availCtrl;
    availCtrl = null;
  }

  disabled = ns.classHas(selCtrl, "disabled");

  forEachNode(ctrl, "div", function(i, el) {
    var btns;
    if (el.className == "chooserBtns") {
      btns = el.getElementsByTagName("input");
      btnMove = btns[0];
      btnMoveAll = btns[1];
      btnRemove = btns[2];
      btnRemoveAll = btns[3];
    } else if (el.className == "orderBtns") {
      btns = el.getElementsByTagName("input");
      btnTop = btns[0];
      btnUp = btns[1];
      btnDown = btns[2];
      btnBottom = btns[3];
    }
  });

  centerButtonsVertically(ctrl, selCtrl);

  function availChange(ctrl) {
    var count = msGetCount(ctrl);
    var selected = msGetSelectedCount(ctrl);
    buttonDisable(btnMove, selected === 0);
    buttonDisable(btnMoveAll, count === 0);
  }

  function selChange(ctrl) {
    var count = msGetCount(ctrl);
    var selected = msGetSelectedCount(ctrl);
    var sel, resultCtrl, result, i, resultValues;
    var noup = false, nodown = false;

    if (btnRemove) {
      buttonDisable(btnRemove, selected === 0);
      buttonDisable(btnRemoveAll, count === 0);
    }

    if (btnUp) {
      sel = msGetSelected(ctrl);
      // check top/bottom most
      if (sel.length > 0 && getPreviousSiblingNode(sel[0]) === null) {
        noup = true;
      }
      if (sel.length > 0 && getNextSiblingNode(sel[sel.length - 1]) === null) {
        nodown = true;
      }
      buttonDisable(btnTop, selected === 0 || noup);
      buttonDisable(btnUp, selected === 0 || noup);
      buttonDisable(btnDown, selected === 0 || nodown);
      buttonDisable(btnBottom, selected === 0 || nodown);
    }
    // update hidden input that will contain the selected/chosen items of the chooser
    sel = msGetAll(ctrl);
    resultValues = [];
    for (i = 0; i < sel.length; i++) {
      resultValues.push(sel[i].getElementsByTagName("input")[0].value);
    }
    result = resultValues.join("\t");
    resultCtrl = document.getElementById(hiddenId);
    if (initialSelection === null) {
      initialSelection = result;
    } else {
      ns.setDirty(initialSelection !== result);
    }
    resultCtrl.value = result;
  }

  function selDataChange(ctrl) {
    selChange(ctrl);
    // help screen readers out after a DOM change. JAWS at least will update the virtual buffer when innerHTML is assigned to
    var vbUpdateDiv = ns.getVbUpdateDiv();
    if(vbUpdateDiv) {
      vbUpdateDiv.innerHTML = "x";
    }
  }

  if (!disabled) {
    items = ctrl.getElementsByTagName("li");
    addMultiSelectOptionHandlers(items);
    if (availCtrl) {
      setMultiSelectBestTabIndex(availCtrl);
      data = msGetCtrlData(availCtrl);
      data.onchange = availChange;
      availChange(availCtrl);
    }
    setMultiSelectBestTabIndex(selCtrl);
    data = msGetCtrlData(selCtrl);
    data.onchange = selDataChange;
    selChange(selCtrl);
  }

  }, 0);
};

//
// Action buttons
//
ns.chooserAdd = function(evt) {
  var e = evt || window.event;
  var availMs = getAvailableCtrl(this);
  var selMs = getSelectedCtrl(this);
  var sel = msGetSelected(availMs);
  var copy = cloneEachNode(sel);
  msHide(availMs, sel);
  msAdd(selMs, copy);
};

ns.chooserAddAll = function(evt) {
  var e = evt || window.event;
  var availMs = getAvailableCtrl(this);
  var selMs = getSelectedCtrl(this);
  var all = msGetAll(availMs);
  var copy = cloneEachNode(all);
  msHide(availMs, all);
  msAdd(selMs, copy);
};

ns.chooserRemove = function(evt) {
  var e = evt || window.event;
  var availMs = getAvailableCtrl(this);
  var selMs = getSelectedCtrl(this);
  var sel = msGetSelected(selMs);
  msRemove(selMs, sel);
  msRestore(availMs, sel);
};

ns.chooserRemoveAll = function(evt) {
  var e = evt || window.event;
  var availMs = getAvailableCtrl(this);
  var selMs = getSelectedCtrl(this);
  var all = msGetAll(selMs);
  msRemove(selMs, all);
  msRestore(availMs, all);
};

ns.chooserMoveTop = function(evt) {
  var e = evt || window.event;
  var ctrl = getSelectedCtrl(this);
  msMoveTop(ctrl);
};

ns.chooserMoveUp = function(evt) {
  var e = evt || window.event;
  var ctrl = getSelectedCtrl(this);
  msMoveUp(ctrl);
};

ns.chooserMoveDown = function(evt) {
  var e = evt || window.event;
  var ctrl = getSelectedCtrl(this);
  msMoveDown(ctrl);
};

ns.chooserMoveBottom = function(evt) {
  var e = evt || window.event;
  var ctrl = getSelectedCtrl(this);
  msMoveBottom(ctrl);
};

ns.getVbUpdateDiv = function () {
  var vbUpdateDiv = document.getElementById("vbupdate");
  if(!vbUpdateDiv) {
    vbUpdateDiv = document.createElement("div");
    vbUpdateDiv.setAttribute("style", "display:none;");
    vbUpdateDiv.setAttribute('id', "vbupdate");   
    document.body.appendChild(vbUpdateDiv);
    vbUpdateDiv = document.getElementById("vbupdate");
    vbUpdateDiv.style.display = "none"; // for IE<8
  }
  return vbUpdateDiv;    
};

})(wls.console);
