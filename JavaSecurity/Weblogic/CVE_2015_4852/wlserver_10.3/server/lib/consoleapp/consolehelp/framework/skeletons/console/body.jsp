<!--
    The body skeleton file renders the HTML <body> element for the body control.
    This <body> element contains the visible Portal control elements.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="bodypc">
        <skeleton:control name="body" presentationContext="${bodypc}">
            <skeleton:children/>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
