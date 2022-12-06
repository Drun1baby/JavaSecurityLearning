<!--
    The nolayout skeleton file renderes each placeholder with no extra markup. 
    Setting width, class, id or other styles on a placeholder will have no effect.
    To use this layout set the netuix:layout type attribute to "no"
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="layoutpc">
        <c:forEach items="${layoutpc.placeholders}" var="cell" varStatus="status">
            <skeleton:child presentationContext="${cell}"/>
        </c:forEach>
    </skeleton:context>
</jsp:root>
