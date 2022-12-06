<!--
    The gridlayout skeleton file renderes a HTML <table> element for the layout.
    Each placeholder is rendered as an HTML <div> element within a table <td> 
    cell. Placeholder contents are rendered via the explicit use of the child
    tag in the context of each placeholder <div> element.

    Note: the console does not use gridlayout. Gridlayout should be avoided
    whenever possible because it is better to do layout with divs and css.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="gridlayoutpc">
        <!-- Note that "border", etc. are dynamic attributes and passed directly to the HTML output. -->
        <skeleton:control name="table" presentationContext="${gridlayoutpc}"
            presentationClass="console-layout console-layout-grid"
            border="0" cellspacing="0" cellpadding="0" width="100%"
        >
            <c:forEach items="${gridlayoutpc.placeholderGrid}" var="row">
                <tr>
                    <c:forEach items="${row}" var="col">
                        <c:if test="${! empty col}">
                            <td width="${col.width}">
                                <skeleton:control name="div" presentationContext="${col}"
                                    presentationClass="console-layout-cell console-layout-grid-cell"
                                >
                                    <skeleton:child presentationContext="${col}"/>
                                </skeleton:control>
                            </td>
                        </c:if>
                    </c:forEach>
                </tr>
            </c:forEach>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
