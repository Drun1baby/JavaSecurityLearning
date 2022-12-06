<!--
    The head skeleton file renders the HTML <head> element for the head control. 
    This <head> element contains a HTML META Content-Type directive as well as
    implicit elements created by the Portal Framework (e.g. style
    and script elements defined in skin.xml).
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="headpc">
        <head>
            <![CDATA[<meta http-equiv="Content-Script-Type" content="text/javascript">]]>
            <skeleton:contentTypeMeta/>
            <skeleton:children/>
        </head>
    </skeleton:context>
</jsp:root>
