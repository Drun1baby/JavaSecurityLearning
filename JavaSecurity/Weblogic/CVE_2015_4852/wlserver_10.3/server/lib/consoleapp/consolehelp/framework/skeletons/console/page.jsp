<!--
    The page skeleton file renders a HTML <div> element for the page. 
    The <div> element contains all the children of the page including 
    layouts, portlets, etc.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="pagepc">
        <skeleton:control name="div" presentationContext="${pagepc}"
            presentationClass="console-page" presentationId="${pagepc.label}"
        >
            <skeleton:children/>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
