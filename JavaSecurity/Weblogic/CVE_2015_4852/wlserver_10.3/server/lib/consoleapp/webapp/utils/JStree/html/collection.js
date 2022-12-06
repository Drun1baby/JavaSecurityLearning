/* This represents a Collection Object */
/* Author: Mike J */

function JSCollection(){
   this.children = new Array(0);
   this.add = add;
   this.get = get;
   this.size = size;
   this.getArray = getArray;
   this.name = "JSCollection";   
} 
function add(key,obj){       
    var tempArray = new Array(0);    
    tempArray[0] = obj;    
    this.children = this.children.concat(tempArray);      
}
function get(index){  
    return this.children[index];
}
function size(){
    return this.children.length;
}
function getArray(){
    return this.children;
}
