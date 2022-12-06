<!--
    The buttondelete skeleton file delegates to a common button helper file, 
    passing a URL corresponding to the delete button being rendered, as well
    as a reference to a click handler.
-->
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:render="http://www.bea.com/servers/portal/tags/netuix/render"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false"/>
    <jsp:directive.page isELIgnored="false"/>
    <skeleton:context type="buttonpc">
        <!-- Delete buttons are only applicable to portlets -->
        <c:if test="${buttonpc.parentPortlet}">
            <render:toggleButtonUrl forcedAmpForm='true' var="buttonUrl"/>
            <!--
                This and other button skeleton files delegate to a common helper file.
            -->
            <jsp:include page="abstractbutton.jsp">
                <jsp:param name="href" value="${buttonUrl}"/>
                <jsp:param name="onclick" value="return wlp_bighorn_delete_handler(this)"/>
            </jsp:include>
        </c:if>
    </skeleton:context>
</jsp:root>
