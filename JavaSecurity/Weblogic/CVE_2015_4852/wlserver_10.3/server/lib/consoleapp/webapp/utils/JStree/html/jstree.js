/* Browser Variables */

var bV=parseInt(navigator.appVersion);
NS4=(document.layers) ? true : false;
IE4=((document.all)&&(bV>=4))?true:false;
ver4 = (NS4 || IE4) ? true : false;


/* This represents a Tree Object */

function JSTree(pluginName,docObj,startPage){
  this.root = new JSTreeNode(pluginName,"../utils/JStree/images/workflow_16.gif",startPage); 
  this.name = "JSTree";
  this.renderTree = renderTree;  
  this.renderNode = renderNode; 
  this.renderNodeInternal = renderNode;
  this.addJSTreeNode = addJSTreeNode;
  this.getRoot = getRoot;
  this.getSpacer = getSpacer;
  this.findNode = findNode;
  this.findNodeByLevel = findNodeByLevel;
  this.removeNode = removeNode;
  this.removeChildren = removeChildren;
  this.docObject = docObj;
  this.icons = new JSCollection();
  this.addIcon = addIcon; 
  this.renderTreeNS = renderTreeNS;
  this.renderNodeNS = renderNodeNS;
  this.escapeURL = escapeURL;
  this.hasURLNS = hasURLNS;
  this.getSpacerNS = getSpacerNS;
  this.setHighestLevelNS = setHighestLevelNS;
  this.highestLevel = 0;
  this.root.nodeId = "ROOT";
  this.showIcons = false;

  if (NS4)
     this.docObject = parent.NAV.document;  
}

/* This represents a TreeNode Object */

function JSTreeNode(name,iconName,url){   
    this.parent = this;
    this.level = 1;
    this.isExpanded = false;
    this.children = new Array(0);
    this.name = name;
    this.hasChildren = hasChildren;
    this.getChildren = getChildren; 
    this.addJSTreeNode = addJSTreeNode;   
    this.icon = iconName;
    this.url = url;  
    this.nodeId = ""; 
    this.deferred = false;
    this.deferredURL = "";
    this.showStatusName = showStatusName;
    this.index = 0;
}
function addJSTreeNode(name,iconName,url){      	
    var tempArray = new Array(1);
    var newNode = new JSTreeNode(name,iconName,url);
    newNode.parent = this; 
    newNode.level = this.level+1;
    newNode.nodeId = newNode.parent.nodeId+"CHILDNODE"+newNode.parent.getChildren().length*1;   
    tempArray[0] = newNode;
    this.children = this.children.concat(tempArray);         
    newNode.index = this.getChildren().length;
    return newNode;
}

function showStatusName(){
    window.status = this.name;
}

function addIcon(url){
    var im = new Image();
    im.src = url;
    this.icons.add("",im);
}


/**
 * This method expects the following parameters
 *
 * startNode - A Node to begin the search with. If this is null,
 *             the search will begin at ROOT
 * nodeName  - A String representing the name of the node you are
 *             looking for
 *
 **/
function findNode(startNode,nodeId){
    var nodeFound = false;
    var returnedElement = null;
    var elements = new JSCollection();
    var counter = 0;
    var anElement = null;

    if (startNode == null)
        startNode = this.getRoot();

    elements.add("",startNode);

    while (!nodeFound) {

         anElement = elements.get(counter);      
         
         if (anElement.nodeId == nodeId){
             returnedElement = anElement;
             nodeFound = true;
         }else{
             if (anElement.hasChildren()){
                 var temp = anElement.getChildren();
                 for (var i=0;i<temp.length;i++){
                      elements.add("",temp[i]);
                 }
             }
             counter++;
         }

         if (counter>=elements.size() || returnedElement != null)
             nodeFound = true;
    }

    return returnedElement;
}

/**
 * This method expects the following parameters
 *
 * startNode - A Node to begin the search with. If this is null,
 *             the search will begin at ROOT
 * nodeName  - A String representing the name of the node you are
 *             looking for
 *
 **/
function findNodeByLevel(startNode,nodeId,level){
    var nodeFound = false;
    var returnedElement = null;
    var elements = new JSCollection();
    var counter = 0;
    var anElement = null;

    if (startNode == null)
        startNode = this.getRoot();

    elements.add("",startNode);

    while (!nodeFound) {

         anElement = elements.get(counter);      
         
         if (anElement.nodeId == nodeId && anElement.level == level){
             returnedElement = anElement;
             nodeFound = true;
         }else{
             if (anElement.hasChildren()){
                 var temp = anElement.getChildren();
                 for (var i=0;i<temp.length;i++){
                      elements.add("",temp[i]);
                 }
             }
             counter++;
         }

         if (counter>=elements.size() || returnedElement != null)
             nodeFound = true;
    }

    return returnedElement;
}

function removeChildren(nodeId){    
    var node = this.findNode(null,nodeId);
    if (node != null)
        node.children = new Array(0);
}


function removeNode(fromNode,nodeId){    
      var coll = new JSCollection();
      var children = fromNode.getChildren();
      for (var i=0;i<children.length;i++){           
           if (children[i].name != nodeId)
               coll.add("",children[i]);
      }      
      if (coll.size() > 0){
	  fromNode.children = coll.getArray();
      }
}

function hasChildren(){
     return (this.children.length > 0) ? true : false;
}
function getChildren(){
   return this.children;
}
function getRoot(){
   return this.root;
}
function getSpacer(node){ 
   var sp = "";        
   for(j=0;j<node.level;j++){   
     if (j<node.level-1){       
       sp+="<TD nowrap WIDTH='20' HEIGHT='20'>";                 
       if (node.parent.index < node.parent.parent.getChildren().length && (node.parent.index > 0 && j > 0))
          sp+="<img align='right' src='/web/utils/JStree/images/rootconnector.gif' border='0'>";
       else
          sp+="&nbsp;";
       sp+="</TD>";
     }else{
      if (node.hasChildren()){
       // Change to "node.isExpanded" from "!node.isExpanded" 7/24/2001 //
       if (node.isExpanded)
           sp+="<TD WIDTH='20' HEIGHT='20' nowrap><a href='javascript:parent.TOOLBAR.setExpanded(\""+node.nodeId+"\",\""+node.nodeId+"CHILDREN"+node.level+"\","+node.level+");'><img id='leafimg"+node.nodeId+"' src='../utils/JStree/images/leafopened.gif' align='right' border='0'/></a></TD>";
       else
           sp+="<TD WIDTH='20' HEIGHT='20' nowrap><a href='javascript:parent.TOOLBAR.setExpanded(\""+node.nodeId+"\",\""+node.nodeId+"CHILDREN"+node.level+"\","+node.level+");'><img id='leafimg"+node.nodeId+"' src='../utils/JStree/images/leafclosed.gif' align='right' border='0' align='right'/></a></TD>";
      }else{
       sp+="<TD WIDTH='20' HEIGHT='20' nowrap>";
       if (j > 0) {         
         if (node.index < node.parent.getChildren().length)
          sp+="<img align='right' src='/web/utils/JStree/images/childrenconnector.gif' border='0'>";
         else
          sp+="<img align='right' src='/web/utils/JStree/images/childrenendconnector.gif' border='0'>";
       }else
          sp+="&nbsp;";
       sp+="</TD>";
      }
     }
   }
   return sp;
}

/** 
 * Returns an appropriate argument based on browser type
 *
 **/
function getDivArg(divName){
  if (bV && !IE4) {
    return "document.getElementById(\""+divName+"\")";
  } else
    return divName;  
}

function nameFix(nodeName){    
   var newName = "";  
   if (nodeName.indexOf(' ') != -1 || nodeName.indexOf('-') != -1 || nodeName.indexOf('&') != -1){
      for (var j=0;j<nodeName.length;j++){
           if (nodeName.charAt(j) != ' ' && nodeName.charAt(j) != '-')            
               newName += nodeName.charAt(j);   
      }
   }else
      newName = nodeName;
 
   return newName;
}

/* Draw the tree on the page */

function renderTree(node){  

    if (NS4) return this.renderTreeNS(node);    
  
    this.docObject.open("text/html");
    this.docObject.write("<HTML>");
    this.docObject.write("<HEAD>");
    this.docObject.write("<LINK REL=\"Stylesheet\" TYPE=\"text/css\" HREF=\"../common/stylesheet.txt\"><LINK REL=\"Stylesheet\" TYPE=\"text/css\" HREF=\"../utils/JStree/html/jstree.css\">");    
    this.docObject.write("<SCRIPT LANGUAGE=\"JavaScript\">");
    this.docObject.write("function setExpanded(realName,node,level){var index = node.indexOf(\"CHILDREN\");var nodeName = node.substring(0,index);document.images['leafimg'+nodeName].src=(document.images['leafimg'+nodeName].src.indexOf('images/leafclosed.gif')!=-1)?'images/leafopened.gif':'images/leafclosed.gif';var pluginTree = parent.TOOLBAR.adminTree;var toggledNode = pluginTree.findNodeByLevel(null,realName,level);if (toggledNode != null)toggledNode.isExpanded = (toggledNode.isExpanded) ? false : true;else alert(nodeName+' not found');}");  
    this.docObject.write("</SCRIPT>");   
    this.docObject.write("</HEAD><BODY BGCOLOR=\"#FFFFFF\" CLASS=\"nav-frame-gray\" MARGINHEIGHT=\"1\" MARGINWIDTH=\"0\" LEFTMARGIN=\"0\" TOPMARGIN=\"1\"><BR>");
    this.renderNode(this.getRoot());
    this.docObject.write("</BODY></HTML>");
    this.docObject.close();
  
}

/* This function is called recursively to render all nodes */
/* It should never be called directly. Callers should use  */
/* renderTree and pass in the rootNode of the tree         */

function renderNode(node){ 
  
     var i = 0;         
          
     this.docObject.write("<DIV CLASS=aNode ID="+node.nodeId+">"+this.getSpacer(node.level)); 
     this.docObject.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr>"+this.getSpacer(node));
     if (this.showIcons){
         this.docObject.write("<td height='20' width='20' nowrap><img id='img"+node.nodeId+"' src='"+node.icon+"' border='0'>&nbsp;</td>");
     }
     this.docObject.write("<td valign='middle'>"+hasURL(node)+"</td></tr></table>");
     
     // Removed "node.isExpanded()" from if 05/17/2001 MJ //
     if (node.hasChildren() && node.isExpanded){
         // Write out enclosing DIV //
         this.docObject.write("<DIV CLASS=aNode ID='"+node.nodeId+"CHILDREN"+node.level+"' STYLE='"+getDisplay(node)+"'>");
         var theChildren = node.getChildren();	    	   		
         for (i=0;i<theChildren.length;i++){	  
            childNode = theChildren[i];
	    if (childNode.hasChildren()){
	       this.renderNode(childNode);     	   
	    }else{	      
 	        this.docObject.write("<DIV CLASS=aNode ID="+childNode.nodeId+">"+this.getSpacer(childNode.level));                 
                this.docObject.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"><tr>"+this.getSpacer(childNode));
                if (this.showIcons) {
                    this.docObject.write("<td height='20' width='20' nowrap><img src='"+childNode.icon+"' border='0'>&nbsp;</td>");
                }
                this.docObject.write("<td valign='middle' nowrap>"+hasURL(childNode)+"</td></tr></table></DIV>");
	    }
         } 
         this.docObject.write("</DIV>");    
     }     
     this.docObject.write("</DIV>");   
}

function hasURL(node){
    return (node.url == "") ? node.name : "<a CLASS=\"dialog-info\" id=\""+node.nodeId+"\" href='"+node.url+"' target='CONTENT'>"+node.name+"</a>";
}
function getNodeState(node){     
     return (!node.isExpanded) ? "../utils/JStree/images/folderopen.gif" : "../utils/JStree/images/folderclosed.gif";
}

function getDisplay(node){             
     var nodeName = node;
     //var selectedTab = parent.TOOLBAR.tabs.getCurrentTab().index;      
     //var pluginTree = parent.TOP.objManager.get(selectedTab);
     var pluginTree = parent.TOOLBAR.adminTree;
     var toggledNode = pluginTree.findNode(null,nodeName);
     //if (toggledNode != null)
     //    toggledNode.isExpanded = (toggledNode.isExpanded) ? false : true;
     //return (node.isExpanded) ? "display:none;" : "display:''";
     return (node.isExpanded) ? "display:''" : "display:none;";
}

/***********************************************************/
/*                                                         */
/* Netscape 4.x specific functions                         */
/*                                                         */
/***********************************************************/

function setHighestLevelNS(level){        
      this.highestLevel = level;
      this.lastLevel = 0;
}

function getSpacerNS(node){
   var sp = "";        
   for(j=0;j<node.level;j++){   
     if (j<node.level-1)       
       sp+="<TD WIDTH='20' HEIGHT='20' nowrap><img src='../images/spacer.gif' width='10' alt='' border='0'></TD>";
     else{
      if (node.hasChildren()){
       // Change to "node.isExpanded" from "!node.isExpanded" 7/24/2001 //
       if (node.isExpanded)
           sp+="<TD WIDTH='20' HEIGHT='20' nowrap><a href='javascript:parent.TOOLBAR.setExpanded(\""+node.name+"\");'><img id='leafimg"+nameFix(node.name)+node.level+"' src='../JStree/images/leafopened.gif' border='0'/></a></TD>";
       else
           sp+="<TD WIDTH='20' HEIGHT='20' nowrap><a href='javascript:parent.TOOLBAR.setExpanded(\""+node.name+"\");'><img id='leafimg"+nameFix(node.name)+node.level+"' src='../JStree/images/leafclosed.gif' border='0'/></a></TD>";
      }else
       sp+="<TD WIDTH='20' HEIGHT='20' nowrap><img src='../images/spacer.gif' width='10' alt='' border='0'></TD>";
     }
   }
   return sp;
}

/* Draw the tree on the page */

function renderTreeNS(node){         
 
    this.docObject.open("text/html");
    this.docObject.write("<HTML><HEAD><LINK REL=\"Stylesheet\" TYPE=\"text/css\" HREF=\"../common/stylesheet.txt\"><LINK REL=\"Stylesheet\" TYPE=\"text/css\" HREF=\"../utils/JStree/html/jstree.css\"></HEAD><BODY BACKGROUND=\"images/bg_stripes.gif\" MARGINHEIGHT=\"1\" MARGINWIDTH=\"0\" LEFTMARGIN=\"0\" TOPMARGIN=\"1\">");
    this.docObject.write("<TABLE BORDER='0' CELLSPACING='0'>");
    this.renderNodeNS(node); 
    this.docObject.write("</TABLE>");
    this.docObject.write("</BODY></HTML>");
    this.docObject.close();    
}
                                
/* This function is called recursively to render all nodes */
/* It should never be called directly. Callers should use  */
/* renderTree and pass in the rootNode of the tree         */

function renderNodeNS(node){ 

     var i = 0;
     var lastLevel = 0;
     if (node.name != this.getRoot().name)      
           this.docObject.write("<TR>"+this.getSpacerNS(node)+"<TD WIDTH='20' HEIGHT='20'><img src='"+node.icon+"'></TD><TD COLSPAN='"+(this.highestLevel)+"'>"+hasURLNS(node)+"</TD></TR>");

     if (node.hasChildren()){   	     
         var theChildren = node.getChildren();	    	   		
         for (i=0;i<theChildren.length;i++){	  
            childNode = theChildren[i];	    
	    if (childNode.hasChildren() && childNode.isExpanded){
	       lastLevel = this.renderNodeNS(childNode);
	    }else{            
	       this.docObject.write("<TR>"+this.getSpacerNS(childNode)+"<TD WIDTH='20' HEIGHT='20'><img src='"+childNode.icon+"'></TD><TD COLSPAN='"+(lastLevel)+"'>"+hasURLNS(childNode)+"</TD></TR>");
            }
         }         
     }   
     return node.level;          
}

function hasURLNS(node){
    return (node.url == "") ? node.name : "<a CLASS=\"dialog-info\" href='"+escapeURL(node.url)+"' target='CONTENT'>"+node.name+"</a>";
}

function escapeURL(url){
    var part1Idx = url.indexOf("?");
    var part1 = url.substring(0,part1Idx);
    var part2 = url.substring(part1Idx+1,url.length);    
    return part1+"?"+escape(part2);
  
}


