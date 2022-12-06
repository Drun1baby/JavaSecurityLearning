/*
 * Javascript which handles tree display and navigation
 */

//
// Variables used for defining the tree and nodes.
// If you want to change the way the tree looks and behaves, re-define
// the variables you want in your file before calling any of
// the functions in this script.
//


// Arrays for nodes and icons
var nodes             = new Array();
var openNodes         = {};       // the hashtable which stores open nodes (used in setLocal=true)
var popups            = {};       // the hashtable which stores the popups
var highlightedNodes  = null;     // the nodes that are highlighted when tree is created

var __totalNodes      = 0;

var icons	          = new Array(6);

// the event object which stores the mouse properties
var mouseEvent        = null;

// the current item on which the popup is displayed - a treeNode object
var currentNode = null;

// variable used in IE only, keeps track of spanId in which the popup which is visible
var currentSpanId = null;

var node_delimeter = "\u0007";       // a bell delimeter

// the x and y co-ordinates where popup will be displayed
var x = 0;
var y = 0;

// the id of the timer which will show the popup
var timerId = null;

// the popup element to show
var popup2show = null;

// variable which decides if a tree needs to show a popup menu
var popupVisibility = true;

// variable which decides if the tree is going to expand locally or, if it needs
// to go to the server to get the data.
var isLocal = false;

var tree_image_base = "tree_images/";

// the icon which is going to be shown as the base of the tree.
var baseIcon = tree_image_base + "base.gif";

// the icon which is shown for a leaf node
var leafIcon = tree_image_base + "page.gif";

// the timeout value in milliseconds
var timeOutvalue = 500;

//The selected node Id
var selectedNodeId = null;


// variable which indicates whether or not the taxonomy of the node will be computed or not...
var isTaxonomyComputed = true;

// the variable which defines the delimeter for the taxonomy.
// The taxonomy delimeter can be changed by the TreeHelper when it is generating nodes.
// Make sure you set that variable to what you want in the TreeNode.setTaxonomyDelimeter
// if you do not want the default
var taxonomyDelimeter = ".";

//
// functions
//


/**
 * function which starts the timer that is going to display the popup.
 * @param flag - can be 'visible' or 'hidden';
 */
function displayPopup(flag)
{
   var popupObject = null;

   // if popup is not set to be visible, we just get back
   if(!popupVisibility || popup2show == null)
   {
      return;
   }

   // check to see if the appropriate variable is defined
   try
   {
     // popupObject = document.getElementById(popup2show);
	 popupObject = getPopup(popup2show);
     if(popupObject == null)
         return;
   } catch(exception) {
     alert("Exception while trying to call displayPopup() for : " + popup2show + "\n" + exception);
     return;
   }


   popupObject.style.left = x;
   popupObject.style.top  = y;
   popupObject.style.visibility = flag;
}

// function which is going to display the popup
function startDisplayPopup(nodeId, popupShowId, event)
{
   var escapedAgainId = escapeQuotes(nodeId);

   if(document.all)
   {
      x = event.x + document.body.scrollLeft;
      y = event.y + document.body.scrollTop;
   } else {
      // try the standard
      x = event.pageX;
      y = event.pageY;
   }

   clearTimer();

   // call the mouseOverCall - just in case
   mouseOverCall(nodeId, popupShowId);

   // timerId = setTimeout("displayPopup('visible')",timeOutvalue);
   // no need to wait, just display the popup
   displayPopup('visible');

   var element = getLinkElement(escapedAgainId);
   if(selectedNodeId != nodeId)
   {
       element.style.backgroundColor = '#E0E0E0';
   }

   // since we do not want to display the context menu.
   return false;
}

// get the link represented by the id
function getLinkElement(id)
{
   var lid = "link" + id;
   var element = document.getElementById(lid);

   if(element != null)
       return element;

   // there must be a double quote in there,
   var decode = lid.replace(/&quot;/g, '"');
   element = document.getElementById(decode);
   return element;

}

// function called from the popup to hide it
function popupHide()
{
	var element = getLinkElement(currentNode.nId);
	element.style.backgroundColor = '#FFFFFF';
    clearTimer();
    timerId = setTimeout("displayPopup('hidden')", timeOutvalue);
}

// function called from the popup to show it, basically kills the timer meant to hide the popup.
function popupCancelhide()
{
	var element = getLinkElement(currentNode.nId);
	element.style.backgroundColor = '#E0E0E0';
	clearTimer();
}

// clear any prior timer if it exists
function clearTimer()
{
	if(timerId != null)
	{
    	   clearTimeout(timerId);
    	   timerId = null;
    	}
}


/**
 * javascript called when the mouse is over a node.
 * @param nodeId The node on which the mouse is on.
 * @popupShowId Optional parameter. If specified, it will show the
 *              popup with the specified id, else the default will
 *              be shown. Default is 'popup'
 */
function mouseOverCall(nodeId, popupShowId)
{
	var node = getNode(nodeId);

	
    // hide any earlier popup's
    displayPopup('hidden');


    if(popupShowId != null)
    {
       if(popupShowId != popup2show)
       {
          currentNode = node;
       }
       popup2show = popupShowId;
    }

	currentNode = node;

	// color the link to give the appearance of being in focus.
	var element = getLinkElement(node.nId);
  	element.style.backgroundColor = '#E0E0E0';

}

// javascript called when the mouse moves outside a node
function mouseOutCall(nodeId)
{
   popupHide();

   var escapedAgainId = escapeQuotes(nodeId);

   //This will color the link back to it's original background color, making it look out of focus
   var element = getLinkElement(escapedAgainId);
   if(selectedNodeId != nodeId)
   {
      element.style.backgroundColor = '#FFFFFF';
   }
   else
   {
      element.style.backgroundColor = '#C0DBF7';
   }
}

// Loads all icons that are used in the tree
function preloadIcons()
{
	icons[0] = new Image();
	icons[0].src = tree_image_base + "plus.gif";
	icons[1] = new Image();
	icons[1].src = tree_image_base + "plusbottom.gif";
	icons[2] = new Image();
	icons[2].src = tree_image_base + "minus.gif";
	icons[3] = new Image();
	icons[3].src = tree_image_base + "minusbottom.gif";
	icons[4] = new Image();
	icons[4].src = tree_image_base + "folder.gif";
	icons[5] = new Image();
	icons[5].src = tree_image_base + "folderopen.gif";
}


/**
 * The definition of a tree node. Used as a class object
 * @param nodeId : The id for the node, can be a string or a integer
 * @param parent : The TreeNode that represents the parent of this node
 * @param nodeName : The name of the node
 * @param nodeUrl  : The target url when the node is clicked (Optional)
 * @param iconSrcOpen  : If not specified, by default the icon used is a
 *                       folder icon (on open).
 * @param iconSrcClosed: If not specified, by default the icon used is a
 *                       folder icon (when closed),
 * @param popupId      : An optional parameter. If not specified, the node
 *                       will have the popup with id 'popup' associated with it,
 *                       otherwise it will be shown with the popup specified by popupId
 * @param altText      : Text which will be shown as a popup when the mouse hovers on the folder
 * @param isOpen       : Boolean indicating whether the node is expanded or not
 * @param hasChildren  : Indicate whether this node has children or not - it's a little bit redundant since
 *                       the children variable does contain all the children, but it's useful because we do not
 *                       for a lazily loaded tree, we do not generate the javascript for dummy nodes, yet the parent have the children                     
 */
function TreeNode(nodeId, parent, nodeName, nodeUrl, iconSrcOpen, iconSrcClosed, popupId, altText, isOpen, hasChildren)
{
    this.nodeId       = nodeId;
	this.parent       = parent;
    this.nodeName     = nodeName;
    this.nodeUrl      = nodeUrl;
	this.nId = escapeQuotes(nodeId);      // escape the quote from the nodeId
	this.children     = new Array();
	this.hasChildren  = hasChildren;

	if(parent == null || parent == 0) {
	   this.parentNodeId = null;
	} else {
	   if(parent.children != undefined) {
          this.parentNodeId = parent.nodeId;
	      parent.children.push(this);
	   } else {
	      // somebody could have passed in the parent id instead. find that id
		  var par = getNode(parent);
		  if(par != null) 
		  {
		     this.parent = par;
			 this.parentNodeId = par.nodeId;
	      }
	   }
	}

    if(iconSrcOpen == null || iconSrcClosed == null)
    {
      this.iconSrcOpen = tree_image_base + 'folderopen.gif';
      this.iconSrcClosed = tree_image_base + 'folder.gif';
    } else {
      this.iconSrcOpen = iconSrcOpen;
      this.iconSrcClosed = iconSrcClosed;
    }

    if(popupId == null)
    {
      this.popupId = 'popup';
    } else {
      this.popupId = popupId;
    }

    this.altText = altText;
	this.isOpen = isOpen;

	this.taxonomyById = '';
	this.taxonomyByName = '';

    if(isTaxonomyComputed)
       setTaxonomy(this);

	__totalNodes++;

    nodes.push(this);
	
	if(isLocal && isOpen)
		openNodes[nodeId] = "true";
}

/** Set the taxonomy of the node */
function setTaxonomy(node)
{
    var taxonomyId = node.nodeId;
	var taxonomyName = node.nodeName;

    var parentNode = node.parent;

	while(parentNode != null)
	{
	     taxonomyId   = parentNode.nodeId + taxonomyDelimeter + taxonomyId;
		 taxonomyName = parentNode.nodeName + taxonomyDelimeter + taxonomyName;

	     // get the parent node
		 var parentNode = parentNode.parent;
    }

    node.taxonomyById   = taxonomyId;
	node.taxonomyByName = taxonomyName;
}

/**
 * The TreePopup Object which holds each popup item. These items are then copied into the popup array
 *
 * @param text The text to be displayed on the popup
 * @param url The url to be executed for the popup
 */
function TreePopup(text, url)
{
   this.text = text;
   this.url = url;
}

/**
 * sets whether the tree is going to be local or not
 * @param local Can be true or false. If true, the tree will not be generated again
 *        when a user hits on the '+' or the '-' functions. It is generated once
 *        and the entire tree is manipulated entirely on the client. If set to false
 *        it means that the client does not have the entire contents of the tree, so
 *        for each expand or collapse operation it will go to the server to figure out
 *        the new display.
 */
function setLocal(local)
{
    isLocal = local;
}

/**
 * Changes the image base where the tree icons are going to be loaded. By default the images
 * associated with the tree are loaded from the "tree_images" directory but this can be changed
 * if required.
 * @param the base directory where the images are loaded
 */
function setBaseDirectory(basedir)
{
    tree_image_base = basedir

	// the icon which is going to be shown as the base of the tree.
	baseIcon = tree_image_base + 'base.gif';

	// the icon which is shown for a leaf node
	leafIcon = tree_image_base + 'page.gif';
}

/**
 * Set the taxonomy Delimeter
 */
function setTaxonomyDelimeter(delimeter)
{
   if(delimeter != null)
      taxonomyDelimeter = delimeter;
}

/**
 * Variable to indicate whether or not to compute the taxonomy of the node
 */
function setTaxonomyComputation(compute)
{
   isTaxonomyComputed = compute;
}

/**
 * Sets the visibility of the popup. This is the popup which is going to be displayed
 * when a user right clicks on the tree. This can be turned on or off if requird.
 */
function setPopupVisibility(visibility)
{
    popupVisibility = visibility;
}

/**
 * Set the taxonomyById and taxonomyByName parameters
 */

/**
 * Store the highlighted nodes in a hashTable
 * @param This is a variable list of nodeIds which are to be highlighted
 */
function setHighlightedNodes()
{
   highlightedNodes = {};     // create the hash table
   for(i = 0; i<arguments.length; i++)
       highlightedNodes[ arguments[i] ] = 'true';
}

/**
 * Create the tree
 *
 * @param startNode   : The node which represents the start point of the tree. If not specified
 *                      The tree will start with the first node in the list.
 */
function createTree(startNode)
{
   preloadIcons();

   var node = null;
   var sId = null;

   if (startNode != null)
   {
	   node = startNode
   } else {
	   // get the first node
	   if(nodes.length > 0)
	      node = nodes[0];
   }

   if(node == null)
      return; // nothing can be displayed in the tree.

   // if setLocal=true, load all the openNodes from cookie
   retrieveOpenNodesFromCookie();

   highlightNode = false;
   if(highlightedNodes != null && highlightedNodes[node.nodeId] != null)
   {
      highlightNode = true;
   }

   writeNode(node, node.iconSrcOpen, highlightNode, null, node.nodeName);
   document.write('<br />');

  var recursedNodes = new Array();
  addNode(node, recursedNodes);
  
  setTimeout("scrollToElement()", 300);
}

/** Scroll to the selected element */
function scrollToElement()
{
  // after creating the tree, we need to go give the selected node focus
  if(selectedNodeId != null)
  {
     var sElement = getLinkElement(escapeQuotes(selectedNodeId));
	 if(sElement != null)
	 	sElement.focus();
  }
}

/**
 * Write an invidividual node out using document.write. The reason it is separated is so that
 * if someone wants to use treenodes other than a Tree (ie in a list) and still get the same
 * functionality, they can just call this method
 *
 * @param node      The TreeNode object to be written
 * @param icon      Optional - The icon source to be displayed along with the node. If icon is null, no icon
 *                  will be displayed next to the node.
 * @param highlight Optional parameter, set to true if we want the node to be highlighted
 * @param className Optional parameter, specifies the style which is to be used for the href. If not specified
 *                  the default class - 'tree_link' will be used.
 * @param accessibility  The alternate text to be used for accessibility. If not specified, a blank will be used
 */
function writeNode(node, icon, highlighted, className, accessibility )
{
   var ish = false;
   var class_name = 'tree_link';

   if(className != null)
      class_name = className;

   if(highlighted == null || highlighted == 0)
     ish = false;
   else
     ish = true;

   // highlight the open node
   if(ish)
   {
      selectedNodeId = node.nodeId;
      document.write('<span class="selectedNode">');
   }

   var mouseOverString   = ' onMouseOver="mouseOverCall(\''+ node.nId +'\', \'' +  node.popupId + '\');"  ';
   var mouseOutString    = ' onMouseOut="mouseOutCall(\'' + node.nId + '\');"  ';
   var contextMenuString = ' oncontextmenu="return startDisplayPopup(\''+ node.nId +'\', \'' +  node.popupId + '\', event);"  ';
   var titleString       = (node.altText != null ? ' title="' + escapeQuotes(node.altText) + '"' : '');
   
   // used in the href
   var altTextString     = ' title="' + (accessibility != null ? escapeQuotes(accessibility) : '') + '"';
   // alert(altTextString);
   
   if(icon != null)
   {
       document.write('<a ' + altTextString + ' href="' + escapeQuotes(node.nodeUrl) + ';">');
	   document.write('<img id="icon' + node.nId + '" src="' + icon + '" align="absbottom"  alt="" border="0" ' + mouseOverString + mouseOutString + contextMenuString + titleString + '/>');
       document.write('</a>');
   }

   // Start link - include an id for highlighting
   document.write('<a class="' + class_name  + '" id="link' + node.nId + '" href="' + escapeQuotes(node.nodeUrl) + ';"  onKeyPress="checkKeyStroke(event);" ' + mouseOverString +  mouseOutString  + contextMenuString + '/>');

   if(node._prefix != undefined)
      document.write(node._prefix);

   document.write(htmlChars(node.nodeName));

   if(node._suffix != undefined)
      document.write(node._suffix);

   // End link
   document.write('</a>');

   if(ish)
   {
      document.write('</span>');
   }

   //This span is an empty placeholder for users to do an 'innerHTML()' call on
   // to add things directly after the node (ie selection images)
   document.write('<span id="placeholder' + node.nId + '"></span>');

}

/**
 * Wrapper for writeNode method which takes in an unEscaped nodeId.
 */ 
function writeNodeWrapper(nodeId, showClosedIcon, accessibility)
{
    var node = getNode(nodeId);

	if(node == null)
		return;
	
	if(showClosedIcon)
       writeNode(node, node.iconSrcClosed, null, null, accessibility);
	else
	   writeNode(node, node.iconSrcOpen, null, null, accessibility);
}

// destroys the popup if escape pressed
function checkKeyStroke(event)
{
  if(event.keyCode == 27)
     displayPopup('hidden');
}

// Returns the node which has the specified Id
function getNode(nodeId)
{
   for (var n=0; n<nodes.length; n++)
   {
        if(nodes[n].nodeId == nodeId)
		     return nodes[n];
   }

   return null;
}

/* method which finds the given node based on its path, and then evaluates the node url
 * it takes in a nodePath, separated by the taxonomyDelimeter character. (The default value is ".", but it is generally
 * over-ridden by most of the applications to be the "\t" character
 *
 * Note : This function is intended to be called from an unit Test and is not used by the main application.
 */
function selectNodeByPath(nodePath)
{  
   for (var n=0; n<nodes.length; n++)
   {
        if(nodes[n].taxonomyByName == nodePath)
        {
            currentNode = nodes[n];
            eval(nodes[n].nodeUrl);
            return true;
        }
   }

   // we did not find the appropriate node, so return false;
   return false;
}

/* method which finds the given node based on its path, and then returns it. It will return a null if no node is found
 * it takes in a nodePath, separated by the taxonomyDelimeter character. (The default value is ".", but it is generally
 * over-ridden by most of the applications to be the "\t" character
 *
 * Note : This function is intended to be called from an unit Test and is not used by the main application.
 */
function getNodeAtPath(nodePath)
{  
   for (var n=0; n<nodes.length; n++)
   {
        if(nodes[n].taxonomyByName == nodePath)
        {
            return currentNode;
        }
   }

   return null;
}

/*
 * This methos returns a boolean indicating whether the nodePath is present or not.
 * It takes in a nodePath, separated by the taxonomyDelimeter character. (The default value is ".", but it is generally
 * over-ridden by most of the applications to be the "\t" character
 *
 * Note : This function is intended to be called from an unit Test and is not used by the main application.
 */
function isNodePathPresent(nodePath)
{  
   for (var n=0; n<nodes.length; n++)
   {
        if(nodes[n].taxonomyByName == nodePath)
        {
            currentNode = nodes[n];
            return true;
        }
   }

   // we did not find the appropriate node, so return false
   return false;  
}

/**
 *  Expand or collapse a node identified by its nodePath (where each node is separated by the taxonomyDelimeter character)
 *  Mode can be 0 for expand, 1 for collapse action.
 *  This will return an exception if the node identified by node path is not found, or if the node does not have
 *  expand/collapse action associated with it (i.e. it is a leaf node)
 *
 *  Note : This function is intended to be called from an unit Test and is not used by the main application.
 */
function expandCollapseNodeByPath(nodePath)
{
   for (var n=0; n<nodes.length; n++)
   {
        if(nodes[n].taxonomyByName == nodePath)
        {
            currentNode = nodes[n];
            
            // find if this node can be expanded or collapsed
            if(document.getElementById("join" + nodes[n].nodeId) == null)
            	throw "The selected node path is not expandable or collapsable";
            
 
            // used only in local mode.            
            var bottom = (n == nodes[n].parent.children.length-1 ? 1 : 0);
            
            if(isLocal)
               ocLocal(nodes[n].nodeId, nodes[n].nodeName, bottom);
            else
               oc(nodes[n].nodeId, nodes[n].nodeName);

            return true;
        }
   }

   // we did not find the appropriate node, so throw an exception.
   return false;
}

// Checks if a node is highlighted
function isNodeHighlighted(nodeId)
{
   if(highlightedNodes == null || highlightedNodes[nodeId] == null)
     return false;
   else
     return true;
}

// Adds a new node in the tree
function addNode(parentNode, recursedNodes)
{
	for (var n=0; n<parentNode.children.length; n++)
	{
	    var node = parentNode.children[n];  // find the node

		var ls	= (n == parentNode.children.length-1 ? true : false);
		var hcn	= node.hasChildren;
		var ino = node.isOpen;
		var ish = isNodeHighlighted(node.nodeId);
			
	    // if the node is not open and setLocal=true, then let us see if that node exists in the openNodes
	    // hashTable.
	    if(!ino && isLocal)
	    {
	       if(openNodes[node.nodeId] != null)
	          ino = true;
	    }
			
		// Write out line & empty icons
		for (g=0; g<recursedNodes.length; g++)
		{
			if (recursedNodes[g] == 1)
			   document.write('<img alt="" border=0 src="' + tree_image_base + 'line.gif" align="absbottom" />');
			else
			   document.write('<img alt="" border=0 src="' + tree_image_base + 'empty.gif" align="absbottom" />');
		}

		// put in array line & empty icons

		if (ls)
		   recursedNodes.push(0);
		else
		   recursedNodes.push(1);

		// Write out join icons

		if (hcn)
		{

			// generate links based on local variable or not
			var callFunction = '';
			if(isLocal == true)
			{
			   callFunction ="ocLocal('";
			} else {
			   callFunction ="oc('";
			}

            var titleText = " node " + node.nodeName;
			if (ls)
			{
				document.write('<a href="javascript:' + callFunction + node.nId + '\',\'' + escapeQuotes(node.nodeName) + '\', 1);"><img border=0 id="join' + node.nId + '" src="');
 
				if (ino) {
				   document.write(tree_image_base + 'minus');
				   titleText = "Collapse" + titleText;
				} else {
	               document.write(tree_image_base + 'plus');
	               titleText = "Expand" + titleText;
				}

				document.write('bottom.gif" align="absbottom" title="' + titleText + '" alt="' + titleText + ' " /></a>');
			} else
			{
				document.write('<a href="javascript:' + callFunction + node.nId + '\',\'' + escapeQuotes(node.nodeName) + '\', 0);"><img border=0 id="join' + node.nId + '" src="');
				if (ino) {
					document.write(tree_image_base + 'minus');
					titleText = "Collapse" + titleText;
				} else {
					document.write(tree_image_base + 'plus');
					titleText = "Expand" + titleText;
				}

				document.write('.gif" align="absbottom" title="' + titleText + '" alt="' + titleText + ' " /></a>');
			}
		} else {
			if (ls)
			   document.write('<img alt="" border=0 src="' + tree_image_base + 'join.gif" align="absbottom" />');
			else
			   document.write('<img alt="" border=0 src="' + tree_image_base + 'joinbottom.gif" align="absbottom" />');
		}

		// Write out folder & page icons
		var imgsrc = "";
		if (hcn)
		{
		   if(ino) {
			  imgsrc = node.iconSrcOpen;
		   } else {
			  imgsrc = node.iconSrcClosed;
		   }
		} else {

		   // ok, now if the iconSrcOpen and iconSrcClosed are the same for this node,
		   // it implies that we really do not want to show the default leaf icon, but rather
		   // just show the icon for the node.
		   if(node.iconSrcOpen == node.iconSrcClosed)
			  imgsrc = node.iconSrcOpen;
		   else
			  imgsrc = leafIcon;
		}

		// write out the node alternate information for accessibility purpose
		var altInfo = "Level " + recursedNodes.length + ", ";
		if(hcn)
		{
		   if(ino)
		     altInfo += "Expanded, ";
		   else
		     altInfo += "Collapsed, ";
		}
		altInfo += node.nodeName + ", " + (n+1) + " of " + parentNode.children.length;
		
		if(ish)
		  altInfo += ", Selected";
		
		writeNode(node, imgsrc, ish, null, altInfo);
		document.write("<br />");

		// If node has children go deeper and write divs
		if (hcn)
		{
			document.write('<div id="div' + node.nId + '"');
 			if (!ino) document.write(' style="display: none;"');
			document.write('>');
			if(ino || isLocal)
				addNode(node, recursedNodes);

			document.write('</div>');
		}

		// remove last line or empty icon
		recursedNodes.pop();
	} // for
}

// Opens or closes a node
// nodeId = the escaped Node Id
function oc(nodeId, nodeName)
{
	var theDiv = document.getElementById('div' + nodeId);
	var uId = null;

	if(theDiv == null)
	{ 
	    uId = escapeQuotes(nodeId);
	    theDiv = document.getElementById('div' + uId);
    }
	
	if(theDiv == null)      // could be due to a double quote
	{
	    uId = replaceDoubleQuotes(uId);
		theDiv = document.getElementById('div' + uId);
	}

    // the image div
    var theJoin = document.getElementById('join' + nodeId);
	
	// if (theDiv.style.display == 'none') // cannot use this because the automation test fails on style attribute

	if (theJoin.src.indexOf('plus.gif') != -1 || theJoin.src.indexOf('plusbottom.gif') != -1) // node is to be opened
	{
		document.HierarchyManagementForm.action.value = 'expandNode';
		document.HierarchyManagementForm.nodeId.value = nodeId;
        document.HierarchyManagementForm.submit();
	} else  // node is closed
	{
		document.HierarchyManagementForm.action.value = 'collapseNode';
		document.HierarchyManagementForm.nodeId.value = nodeId;

        if(document.HierarchyManagementForm.nodeName != undefined)
		{
		     document.HierarchyManagementForm.nodeName.value = nodeName;
		}

        var node = getNode(nodeId);
		if(node == null)
		{
		   uId = escapeQuotes(nodeId);
		   node = getNode(uId);
		}
	
        // if a target page has been defined for the node collapse event in
        // the hierarchy management form, use it
        if(node != null && node.nodeTargetPage != undefined && document.HierarchyManagementForm.nodeTargetPage != undefined)
	    {
	         document.HierarchyManagementForm.nodeTargetPage.value = node.nodeTargetPage;
	    }

        document.HierarchyManagementForm.submit();
    }
}


// opens or closes a node locally
// nodeId = the escaped Node Id
function ocLocal(nodeId, nodeName, bottom)
{
	var theDiv  = document.getElementById('div' + nodeId);
	var theJoin = document.getElementById('join' + nodeId);
	var theIcon = document.getElementById('icon' + nodeId);
	var uId = null;

	if(theDiv == null)
	{ 
	    uId = escapeQuotes(nodeId);
	    theDiv = document.getElementById('div' + uId);
		if(theJoin == null) theJoin	= document.getElementById('join' + uId);
		if(theIcon == null) theIcon = document.getElementById('icon' + uId);
    }
	
	if(theDiv == null)      // could be due to a double quote
	{
	    uId = replaceDoubleQuotes(uId);
		theDiv = document.getElementById('div' + uId);
        if(theJoin == null) theJoin	= document.getElementById('join' + uId);
		if(theIcon == null) theIcon = document.getElementById('icon' + uId);
	}

    // if theJoin.src contains plus.gif, it means that the node is asked to be expanded
	// if theJoin.src contains minus.gif, it means that the node is asked to be collapsed
    if(theJoin.src.indexOf("plus.gif") != -1)
	   openNodes[nodeId] = "true";
	else
	   openNodes[nodeId] = null;
	     
    storeOpenNodesInCookie();
    
	// if (theDiv.style.display == 'none') // cannot use this because the automation tests fail on style attribute
	
	if (theJoin.src.indexOf('plus.gif') != -1 || theJoin.src.indexOf('plusbottom.gif') != -1) // node is to be opened
	{
		if (bottom==1) theJoin.src = icons[3].src;
		else theJoin.src = icons[2].src;
		theIcon.src = getNode(nodeId).iconSrcOpen;
		theDiv.style.display = '';
	} else
	{
		if (bottom==1) theJoin.src = icons[1].src;
		else theJoin.src = icons[0].src;
		theIcon.src = getNode(nodeId).iconSrcClosed;
		theDiv.style.display = 'none';
	}
}


// store the openNodes in the cookie
function storeOpenNodesInCookie()
{
    var cookieName = "openNodes";
    var cookieValue = "";
    
    for(var n in openNodes)
    {
       if(openNodes[n] != null)
          cookieValue += n + node_delimeter;
    }
    
    document.cookie = cookieName + "=" + escape(cookieValue);
}

// retrieve openNodes from cookie
function retrieveOpenNodesFromCookie()
{
   var arr = document.cookie.split(";");

   if(arr == null || arr.length == 0)
      return;

   for(i=0; i<arr.length; i++)
   {
      if(arr[i].indexOf("openNodes") != -1)
      {
          var j = arr[i].indexOf("=");
          if(j != -1)
          {
             var cookieValue = unescape(arr[i].substring(j+1));
             
             // now let us create an split this thing...
             var valueArray = cookieValue.split(node_delimeter);

             if(valueArray == null || valueArray.length == 0)
                return;
             
             for(k=0; k<valueArray.length; k++)
             {
                 if(valueArray[k].length > 0) {
                    openNodes[valueArray[k]] = "true";
                 }
             } // end for
          } // endif j != -1
      } // endif arr[i].indexOf(openNodes)
   } // endfor
}

//Sets what the selected node id is
function setSelectedNode(nodeId)
{
  selectedNodeId = nodeId;
}

// rollover function for the popup td
function popupRollOver(td)
{
   td.style.backgroundColor='#347EDA';
   td.style.color='#FFFFFF';
}

function popupRollOut(td)
{
   td.style.backgroundColor='#E0E0E0';
   td.style.color='#000000';
}

/** retrieve the popup element from its name */
function getPopup(name)
{
    // if the popup element already exists in the body, return that //
	var popup = document.getElementById(name);
	if(popup != null)
	   return popup;

    // the element does not exist, so let us see if it is in the popups hashtable
	popup = popups[name]
	if(popup == null)
	   return null;   // does not exist, so just return a null.

	var popupPlaceholder = document.getElementById('popupPlaceholder');

	// create the table for the popup
	var table = document.createElement('table');
	table.setAttribute('id', name);
	table.setAttribute('cellpadding', '1');
	table.setAttribute('cellspacing', '0');
	table.setAttribute('class', 'popup');
	table.setAttribute('onMouseOver', 'popupCancelhide();');
	table.setAttribute('onMouseOut', 'popupHide();');

	var tbody = document.createElement('tbody');
	
	for(var i=0; i<popup.length; i++)
	{
	    treePopup = popup[i];
		row = document.createElement('tr');
		column = document.createElement('td');
		column.setAttribute('nowrap', true);
        columnClass = (i == popup.length-1 ? 'popup_td_bottom' : 'popup_td');
		column.setAttribute('class', columnClass);
		column.setAttribute('onMouseOver', 'popupRollOver(this);');
		column.setAttribute('onMouseOut', 'popupRollOut(this);');
		column.setAttribute('onClick', treePopup.url);
		if(document.all)
		   column.setAttribute('style', 'cursor:hand;');
		else
		   column.setAttribute('style', 'cursor:pointer;');
		   
		text = document.createTextNode(treePopup.text);
		column.appendChild(text);
		row.appendChild(column);
		tbody.appendChild(row);
	}
	table.appendChild(tbody);
	if(document.all) // bug in IE requires this code.....
	   popupPlaceholder.innerHTML += table.outerHTML;
	else
	   popupPlaceholder.appendChild(table);

	return table;
}


// this method is used to add extra attributes to the HierarchyManagementForm.
// The idea is that when you expand or collapse a node, you want to pass some parameters
// To do this you have to set an ID on your form called "_HierarchyManagementForm"
function addExtraParameters(param, value)
{
   var treeForm = document.getElementById('_HierarchyManagementForm');
   if(treeForm == null || param == null || value == null || param == "" || value == "" || value == 'null') {
      return;
   }

   var hiddenNode = document.createElement('input');
   hiddenNode.setAttribute('type','hidden');
   hiddenNode.setAttribute('name',param);
   if(value.value != undefined)
       hiddenNode.setAttribute('value',value.value);        // so that users can put in text field as values
   else
	   hiddenNode.setAttribute('value',value);

   treeForm.appendChild(hiddenNode);
}

// sescape the single quotes out of the id....
function escapeQuotes(id)
{
    var n = id.replace(/'/g, '\\\u0027');
	n = escapeDoubleQuotes(n);
	return n;
}

function escapeDoubleQuotes(id)
{
    return id.replace(/"/g, '&quot;');
}

function replaceDoubleQuotes(id)
{
    return id.replace(/&quot;/g, '"');
}

function replaceQuotes(id)
{  
    var n = id.replace(/\\u0027/g, "'");
	n = n.replace(/\\u0022/g, '"');
    return n;
}

function reverseQuotesToUnicode(id)
{
    var n = id.replace(/'/g, "\\u0027");
	n = n.replace(/"/g, '\\u0022');
    return n;
}

function htmlChars(source)
{
   if(source == null)
       return source;
            
   var target = source;

   target = target.replace(/&/g, "&amp;");
   target = target.replace(/</g, "&lt;");
   target = target.replace(/>/g, "&gt;");

   return target;
}

 
// simple trim function
function strtrim()
{
    //Match spaces at beginning and end of text and replace
    //with null strings
     return this.replace(/^\s+/,'').replace(/\s+$/,'');
}
String.prototype.trim = strtrim;
