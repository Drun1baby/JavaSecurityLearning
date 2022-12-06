<!--
    The window skeleton file renders a HTML <div> element for the window.  
    This <div> element contains a titlebar and window content.  The window 
    content is contained within an additional HTML <div> element.  The window 
    content and its containing <div> are rendered only if the window is not 
    minimized.

    Special behavior:
    If the presentation class is 'console-frame' additional markup is added
    so the window can be styled with a frame border.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="windowpc">
        <c:if test="${windowpc.packed}">
            <c:set var="class1">console-window-packed</c:set>        
        </c:if>
        <c:if test="${windowpc.contentOnly}">
            <c:set var="class2">console-window-content-only</c:set>
        </c:if>
        <skeleton:control name="div" presentationContext="${windowpc}" 
            presentationClass="console-window ${class1} ${class2}" presentationId="${windowpc.label}"
        >
        <c:choose>
        <!-- console specific. The console-frame class needs some extra markup to style -->
        <c:when test="${windowpc.presentationClass == 'console-frame'}">
          <div class="top">
            <div><div>&amp;nbsp;</div></div>
          </div>
          <div class="middle">
            <div class="r">
              <div class="c"><div class="c2">
            <!-- make sure this stays in sync with the otherwise block -->
            <skeleton:child presentationContext="${windowpc.titlebarPresentationContext}"/>
            <c:if test="${! (windowpc.windowState.name == 'minimized')}">
                <skeleton:control name="div" content="true" presentationContext="${windowpc}"
                    presentationClass="console-window-content"
                >
                    <skeleton:children/>
                </skeleton:control>
            </c:if>
              </div></div>
            </div>
          </div>
          <div class="bottom">
            <div><div>&amp;nbsp;</div></div>
          </div>
        </c:when>
        <!-- end console specific -->
        <c:otherwise>
            <!-- make sure this stays in sync with the when block -->
            <skeleton:child presentationContext="${windowpc.titlebarPresentationContext}"/>
            <c:if test="${! (windowpc.windowState.name == 'minimized')}">
                <skeleton:control name="div" content="true" presentationContext="${windowpc}"
                    presentationClass="console-window-content"
                >
                    <skeleton:children/>
                </skeleton:control>
            </c:if>
        </c:otherwise>
        </c:choose>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
