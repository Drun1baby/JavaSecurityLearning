<!--
    The multilevelmenu skeleton file renders an HTML <table> element for the menu.
    This <table> contains two <td> cells in a single <tr> row corresponding to 
    the menu items and menu buttons. Menu item rendering is accomplished by
    delegating to a common helper file.
    
    Note: console does not use multilevel menus.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="menupc">
        <skeleton:control name="table" presentationContext="${menupc}"
            presentationClass="console-menu console-menu-multi"
        >
            <tr>
                <td class="console-menu-menu-panel">
                    <c:if test="${menupc.bookPresentationContext.windowMode.name == 'view'}">
                        <c:set var="bookpc" value="${menupc.bookPresentationContext}" scope="request"/>
                        <!--
                            This and other menu skeleton files delegate to a common helper file.
                        -->
                        <jsp:include page="abstractmenu.jsp">
                            <jsp:param name="type" value="multi"/>
                        </jsp:include>
                        <c:remove var="bookpc" scope="request"/>
                    </c:if>
                </td>
                <td class="console-menu-button-panel">
                    <skeleton:children/>
                </td>
            </tr>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
