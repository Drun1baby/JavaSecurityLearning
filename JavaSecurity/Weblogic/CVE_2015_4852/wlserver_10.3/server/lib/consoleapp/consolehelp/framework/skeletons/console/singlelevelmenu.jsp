<!--
    The singlelevelmenu skeleton file renders an HTML <div> element for the menu
    with a inner div to wrap the menu list.
    
    Note: console does not use the button panel so it was removed. This makes it
    possible to use a div rather than a table and greatly simplifies the style 
    needed for rendering multiple levels of singlelevelmenu as tabs.
-->
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />
    <skeleton:context type="menupc">
      <!-- skip menu if there is only one item in it (this is console specific) -->
      <c:if test="${menupc.bookPresentationContext.pageCount gt 1}">
        <skeleton:control name="div" presentationContext="${menupc}"
            presentationClass="console-menu console-menu-single"
        >
          <c:if test="${menupc.bookPresentationContext.windowMode.name == 'view'}">
              <c:set var="bookpc" value="${menupc.bookPresentationContext}" scope="request"/>
              <c:set var="menupc" value="${menupc}" scope="request"/>
              <!--
                  This and other menu skeleton files delegate to a common helper file.
              -->
              <div class="menu-wrapper">
              <jsp:include page="abstractmenu.jsp">
                  <jsp:param name="type" value="single"/>
              </jsp:include>
              </div>
              <c:remove var="bookpc" scope="request"/>
              <c:remove var="menupc" scope="request"/>
          </c:if>
        </skeleton:control>
      </c:if>
    </skeleton:context>
</jsp:root>
