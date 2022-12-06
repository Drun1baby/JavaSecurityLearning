/*
    Simple inline event handler for float buttons.  This handler allows skin developers to provide specialized
    float button behavior by defining a global function called "wlp_bighorn_float".  It is assumed that
    the float button is implemented as a HTML <A> element.
    
    If present the "wlp_bighorn_float" function will be called with the instance of the clicked float button.
    This function should return false if the default button click browser event should be suppressed.
    
    If absent, the default behavior will be to render floated windows in a new browser window via the
    HTML <A> element "target" attribute behavior.
*/
function wlp_bighorn_float_handler(button)
{
    var doAction = true;

    if (window.wlp_bighorn_float)
    {
        doAction = wlp_bighorn_float(button);
    }
    else
    {
        button.target = '_blank';
    }

    return doAction;
}

/*
    Simple inline event handler for delete buttons.  This handler allows skin developers to provide specialized
    delete button behavior by defining a global function called "wlp_bighorn_delete".  It is assumed that
    the delete button is implemented as a HTML <A> element.
    
    If present the "wlp_bighorn_delete" function will be called with the instance of the clicked delete button.
    This function should return false if the default button click browser event should be suppressed.
    
    If absent, the default behavior will be to invoke the "deletebuttondialog" feature.
*/
function wlp_bighorn_delete_handler(button)
{
    var doAction = true;

    if (window.wlp_bighorn_delete)
    {
        doAction = wlp_bighorn_delete(button);
    }
    else
    {
        doAction = wlp_deleteButtonDialog(button);
    }

    return doAction;
}
