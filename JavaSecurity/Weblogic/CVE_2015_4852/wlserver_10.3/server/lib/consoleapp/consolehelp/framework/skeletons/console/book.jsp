<!--
    The book skeleton file renders a HTML <div> element for the book.  
    This <div> element contains a menu and book content.
    The book content is contained within an additional HTML <div> element.

    Console specific behavior:
    If the class is set to the special name "invisible" and there is no menu
    then no outer div, menu or content div is rendered. The children are
    simply rendered one after the other without any markup wrapping them.
    This is done to accomidate the deep nesting of console books without 
    generating extra markup.

    If the presentation class is 'console-frame' additional markup is added
    so the book can be styled with a frame border.

    If the user preference to display definition labels is true then
    extra markup is added to show the definition labels in the UI. This 
    is intended to help console extension developers locate extension points.
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <jsp:directive.page import="com.bea.console.utils.PortalUtils" />
    <skeleton:context type="bookpc">
        <!--  Console specific begin -->
        <c:set var="includeDefinitionLables" scope="page">
          <jsp:expression>PortalUtils.getDisplayDefinitionLabelsPreference(request)</jsp:expression>
        </c:set>
        <c:set var="booktype" scope="page">Book</c:set>
        <c:if test="${bookpc.likePage}">
          <c:set var="booktype" scope="page">Page</c:set>
        </c:if>
        <c:choose>
          <c:when test="${bookpc.presentationClass == 'invisible' and bookpc.menuPresentationContext == null}">
              <skeleton:children/>
          </c:when>
          <c:otherwise>
            <!--  Console specific end -->
            <skeleton:control name="div" presentationContext="${bookpc}"
                presentationClass="console-book" presentationId="${bookpc.label}"
            >
              <c:choose>
              <!-- console specific. The console-frame class needs some extra markup to style -->
              <c:when test="${bookpc.presentationClass == 'console-frame'}">
                <div class="top">
                  <div><div>&amp;nbsp;</div></div>
                </div>
                <div class="middle">
                  <div class="r">
                    <div class="c"><div class="c2">
                      <!-- make sure this stays in sync with the otherwise block -->
                      <c:if test="${includeDefinitionLables}">
                        <div class="devLabelInfo">
                          <p>${booktype}: ${bookpc.definitionLabel}</p>
                        </div>
                      </c:if>
                      <skeleton:child presentationContext="${bookpc.menuPresentationContext}"/>
                      <skeleton:control name="div" content="true" 
                          presentationContext="${bookpc}"
                          presentationClass="console-book-content"
                      >
                          <skeleton:children/>
                      </skeleton:control>
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
                <!--  Console specific begin -->
                <c:if test="${includeDefinitionLables}">
                  <div class="devLabelInfo">
                    <p>${booktype}: ${bookpc.definitionLabel}</p>
                  </div>
                </c:if>
                <!--  Console specific end -->
                <skeleton:child presentationContext="${bookpc.menuPresentationContext}"/>
                <skeleton:control name="div" content="true" 
                    presentationContext="${bookpc}"
                    presentationClass="console-book-content"
                >
                    <skeleton:children/>
                </skeleton:control>
              </c:otherwise>
              </c:choose>
            </skeleton:control>
          <!--  Console specific begin -->
          </c:otherwise>
        </c:choose>
        <!--  Console specific end -->
    </skeleton:context>
</jsp:root>
