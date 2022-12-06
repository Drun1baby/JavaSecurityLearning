<!--
    The buttonfloat skeleton file delegates to a common button helper file, 
    passing a URL corresponding to the float button being rendered, as well
    as a reference to a click handler.
-->
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:render="http://www.bea.com/servers/portal/tags/netuix/render"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false"/>
    <jsp:directive.page isELIgnored="false"/>
    <skeleton:context type="buttonpc">
        <render:standalonePortletUrl forcedAmpForm='true' var="buttonUrl"/>
        <!--
            This and other button skeleton files delegate to a common helper file.
        -->
        <jsp:include page="abstractbutton.jsp">
            <jsp:param name="href" value="${buttonUrl}"/>
            <jsp:param name="onclick" value="return wlp_bighorn_float_handler(this)"/>
        </jsp:include>
    </skeleton:context>
</jsp:root>
