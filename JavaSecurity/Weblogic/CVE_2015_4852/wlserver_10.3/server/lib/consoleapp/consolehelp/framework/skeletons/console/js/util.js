/*
    Utility function for attaching an event handler to a target element.  Note that this function is intended
    to be used by skeleton and skin developers, NOT by content developers.
*/
function wlp_bighorn_attachEventHandler(target, type, handler)
{
    var result = false;
    if (target.addEventListener)
    {
        target.addEventListener(type, handler, false);
        result = true;
    }
    else if (target.attachEvent)
    {
        result = target.attachEvent("on" + type, handler);
    }
    else
    {
        var name = "on" + type;
        var old = (target[name]) ? target[name] : function() {};
        target[name] = function(e) { old(e); handler(e) };
        return true;
    }
    return result;
}

/*
    Utility function to add a class name to a target element.  This function is intended for use by skin
    developers to help facilitate adding behaviors to elements.
*/
function wlp_bighorn_addClassName(target, name)
{
    target.className += (target.className ? ' ' : '') + name;
}

/*
    Utility function to remove a class name to a target element.  This function is intended for use by skin
    developers to help facilitate adding behaviors to elements.
*/
function wlp_bighorn_removeClassName(target, name)
{
    var regex = new RegExp(" ?" + name + "$");
	target.className = target.className.replace(regex, '');
}
