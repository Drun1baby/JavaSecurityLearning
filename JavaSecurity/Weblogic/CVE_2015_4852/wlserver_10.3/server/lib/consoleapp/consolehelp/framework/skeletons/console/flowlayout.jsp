<!--
    The flowlayout skeleton file renderes a HTML <div> element for the layout.
    Each placeholder is rendered as a contained HTML <div> element. 
    Placeholder contents are rendered via the explicit use of the child tag in
    the context of each placeholder <div> element.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="flowlayoutpc">
        <skeleton:control name="div" presentationContext="${flowlayoutpc}"
            presentationClass="console-layout console-layout-flow"
        >
            <c:forEach items="${flowlayoutpc.placeholders}" var="cell" varStatus="status">
                <c:if test="${! empty cell.width}">
                    <c:set var="widthStyle">width: ${cell.width}</c:set>
                </c:if>
                <c:choose>
                    <c:when test="${status.first}">
                        <c:set var="firstLastClass">console-layout-flow-first</c:set>
                    </c:when>
                    <c:when test="${status.last}">
                        <c:set var="firstLastClass">console-layout-flow-last</c:set>
                    </c:when>
                    <c:otherwise>
                        <c:remove var="firstLastClass"/>
                    </c:otherwise>
                </c:choose>
                <skeleton:control name="div" presentationContext="${cell}"
                    presentationClass="console-layout-cell console-layout-flow-${flowlayoutpc.orientation} ${firstLastClass}"
                    presentationStyle="${widthStyle}"
                >
                    <skeleton:child presentationContext="${cell}"/>
                </skeleton:control>
            </c:forEach>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
