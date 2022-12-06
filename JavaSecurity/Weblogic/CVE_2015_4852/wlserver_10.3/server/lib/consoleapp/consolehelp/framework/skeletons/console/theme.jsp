<!--
    The theme skeleton file renders an HTML <div> element for the theme.
    This <div> element contains all themed elements (e.g a page and all of its
    portlets).

    Note: console does not use any themes
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="themepc">
        <skeleton:control name="div" presentationContext="${themepc}"
            presentationClass="console-theme console-theme-${themepc.name}"
        >
            <skeleton:children/>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
