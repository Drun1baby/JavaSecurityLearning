<!--
    The shell skeleton file renders the HTML <html> element for the shell control. 
    This <html> element contains all other Portal control elements.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="shellpc">
        <skeleton:html>
            <skeleton:children/>
        </skeleton:html>
    </skeleton:context>
</jsp:root>
