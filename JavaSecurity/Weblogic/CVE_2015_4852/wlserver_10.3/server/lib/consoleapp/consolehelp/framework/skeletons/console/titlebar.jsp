<!--
    The titlebar skeleton file renders a HTML <div> element for the titlebar. 
    This <div> element contains up to three additional <div> elements 
    corresponding to the window icon, window title and window buttons.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="titlebarpc">
        <skeleton:control name="div" presentationContext="${titlebarpc}"
            presentationClass="console-titlebar"
        >
          <div class="float-container">
            <!-- Window icon (contained within a <DIV> element) -->
            <c:if test="${not empty titlebarpc.iconUrl}">
                <div class="console-titlebar-window-icon">
                    <html:img src="${titlebarpc.iconUrl}" alt=""/>
                    <!-- Ensures that the height of window-icon is equal to the height of title-panel -->
                    <jsp:text>&amp;#160;</jsp:text>
                </div>
            </c:if>
            <!-- Window title (contained within a <DIV> element) -->
            <div class="console-titlebar-title-panel">
                <jsp:text>${titlebarpc.parentWindowPresentationContext.title}</jsp:text>
            </div>
            <!-- Window buttons (contained within a <DIV> element) -->
            <div class="console-titlebar-button-panel">
                <!-- Ensures that the height of button-panel is equal to the height of title-panel -->
                <jsp:text>&amp;#160;</jsp:text>
                <c:forEach items="${titlebarpc.buttons}" var="button">
                    <skeleton:child presentationContext="${button}"/>
                </c:forEach>
            </div>
          </div>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
