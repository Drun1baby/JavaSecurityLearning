/*
  Functions used by the ButtonMenuTag (wl:button-menu)

  Copyright (c) 2003,2009, Oracle and/or its affiliates. All rights reserved.
*/
/*global window */
(function() {

var currentMenu = null;

function getNextSiblingNode(start) {
  var el = start.nextSibling;
  while (el) {
    if (el.nodeType == 1) {
      return el;
    }
    el = el.nextSibling;
  }
  return null;
}

function getOffsets(el) {
  var p = el;
  var style;
  var top = 0;
  var left = 0;
  var doc, rect;

  if (el.getBoundingClientRect) {
    doc = el.ownerDocument;
    rect = el.getBoundingClientRect();
    left = rect.left;
    top = rect.top;
    // Add the document scroll offsets
    left += Math.max(doc.documentElement.scrollLeft, doc.body.scrollLeft);
    top += Math.max(doc.documentElement.scrollTop,  doc.body.scrollTop);
    left -= doc.documentElement.clientLeft;
    top -= doc.documentElement.clientTop;
  } else {
    while (p) {
      top += p.offsetTop;
      left += p.offsetLeft;
      p = p.offsetParent;
    }
  }
  p = el;
  while (p)
  {
    if (window.getComputedStyle) {
      style = window.getComputedStyle(p, null);
    } else if (p.currentStyle) {
      style = p.currentStyle;
    }
    if (style.position == 'relative') {
      break;
    }
    p = p.offsetParent;
  }
  if (p) {
    // found position relative ancestor subtract its offsets
    top -= p.offsetTop;
    left -= p.offsetLeft;
  }

  return { top: top, left: left };
}

function hideMenu() {
  if (currentMenu !== null) {
    currentMenu.style.visibility = 'hidden';
  }
  currentMenu = null;
}

window.showMenu = function(button,evt,menuId) {

  if (document.all) {
    evt.cancelBubble = true;
  } else {
    evt.stopPropagation();
  }

  var menu = getNextSiblingNode(button);
  // if already showing this menu then stop
  if (currentMenu === menu) {
    hideMenu();
    return false;
  }

  // close other existing menus
  if (currentMenu !== null) {
    hideMenu();
  }

  currentMenu = menu;
  var offsets = getOffsets(button);
  menu.style.left = offsets.left + "px";
  menu.style.top = offsets.top + button.offsetHeight + "px";
  menu.style.visibility = 'visible';
  document.onclick = hideMenu;
  return false;
};

window.buttonMenuMouseOver = function(item) {
  item.className = "highlight";
};

window.buttonMenuMouseOut = function(item) {
  item.className = "";
};

})();
