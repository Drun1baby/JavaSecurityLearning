<!--
    The borderlayout skeleton file renders a HTML <div> element for the layout.
    Each placeholder is rendered as a contained HTML <div> element. 
    Placeholder contents are rendered via the explicit use of the child tag in
    the context of each placeholder <div> element.
    
    An additional HTML <div> container is rendered around the west, center and 
    east placeholders to implement a float clearing strategy based on based on
    http://www.quirksmode.org/css/clearing.html.
    
    Note: The console does not make use of borderlayout
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="borderlayoutpc">
        <c:set scope="request" var="wlpBighornPhShouldRenderWidth">true</c:set>
        <skeleton:control name="div" presentationContext="${borderlayoutpc}"
            presentationClass="console-layout console-layout-border"
        >
            <c:if test="${! empty borderlayoutpc.north}">
                <c:if test="${! empty borderlayoutpc.north.width}">
                    <c:set var="northWidthStyle">width: ${borderlayoutpc.north.width}</c:set>
                </c:if>
                <skeleton:control name="div" presentationContext="${borderlayoutpc.north}"
                    presentationClass="console-layout-cell console-layout-border-north"
                    presentationStyle="${northWidthStyle}"
                >
                    <skeleton:child presentationContext="${borderlayoutpc.north}"/>
                </skeleton:control>
            </c:if>
            <c:if test="${! empty borderlayoutpc.west || ! empty borderlayoutpc.center || ! empty borderlayoutpc.east}">
                <div class="console-layout-border-wce-container">
                    <c:if test="${! empty borderlayoutpc.west}">
                        <c:if test="${! empty borderlayoutpc.west.width}">
                            <c:set var="westWidthStyle">width: ${borderlayoutpc.west.width}</c:set>
                        </c:if>
                        <skeleton:control name="div" presentationContext="${borderlayoutpc.west}"
                            presentationClass="console-layout-cell console-layout-border-west"
                            presentationStyle="${westWidthStyle}"
                        >
                            <skeleton:child presentationContext="${borderlayoutpc.west}"/>
                        </skeleton:control>
                    </c:if>
                    <c:if test="${! empty borderlayoutpc.center}">
                        <c:if test="${! empty borderlayoutpc.center.width}">
                            <c:set var="centerWidthStyle">width: ${borderlayoutpc.center.width}</c:set>
                        </c:if>
                        <skeleton:control name="div" presentationContext="${borderlayoutpc.center}"
                            presentationClass="console-layout-cell console-layout-border-center"
                            presentationStyle="${centerWidthStyle}"
                        >
                            <skeleton:child presentationContext="${borderlayoutpc.center}"/>
                        </skeleton:control>
                    </c:if>
                    <c:if test="${! empty borderlayoutpc.east}">
                        <c:if test="${! empty borderlayoutpc.east.width}">
                            <c:set var="eastWidthStyle">width: ${borderlayoutpc.east.width}</c:set>
                        </c:if>
                        <skeleton:control name="div" presentationContext="${borderlayoutpc.east}"
                            presentationClass="console-layout-cell console-layout-border-east"
                            presentationStyle="${eastWidthStyle}"
                        >
                            <skeleton:child presentationContext="${borderlayoutpc.east}"/>
                        </skeleton:control>
                    </c:if>
                </div>
            </c:if>
            <c:if test="${! empty borderlayoutpc.south}">
                <c:if test="${! empty borderlayoutpc.south.width}">
                    <c:set var="southWidthStyle">width: ${borderlayoutpc.south.width}</c:set>
                </c:if>
                <skeleton:control name="div" presentationContext="${borderlayoutpc.south}"
	               presentationClass="console-layout-cell console-layout-border-south"
                   presentationStyle="${southWidthStyle}"
                >
                    <skeleton:child presentationContext="${borderlayoutpc.south}"/>
                </skeleton:control>
            </c:if>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
