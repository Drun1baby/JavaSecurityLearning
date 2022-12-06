<!--
    The togglebutton skeleton file delegates to a common button helper file, 
    passing a URL corresponding to the togglebutton being rendered.
-->
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:render="http://www.bea.com/servers/portal/tags/netuix/render"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false"/>
    <jsp:directive.page isELIgnored="false"/>
    <skeleton:context type="togglebuttonpc">
        <render:toggleButtonUrl forcedAmpForm='true' var="buttonUrl"/>
        <!--
            This and other button skeleton files delegate to a common helper file.
        -->
        <jsp:include page="abstractbutton.jsp">
            <jsp:param name="href" value="${buttonUrl}"/>
        </jsp:include>
    </skeleton:context>
</jsp:root>
