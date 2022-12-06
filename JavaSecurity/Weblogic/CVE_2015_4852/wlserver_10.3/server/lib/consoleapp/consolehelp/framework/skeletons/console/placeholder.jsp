<!--
    The placeholder skeleton file performs no explicit rendering.  
    However, it is important that the children of the placeholder are rendered
    within the context of the placeholder.  Logical HTML elements rendered for
    the placeholder are handled by individual layout skeleton files.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="placeholderpc">
        <skeleton:children/>
    </skeleton:context>
</jsp:root>
