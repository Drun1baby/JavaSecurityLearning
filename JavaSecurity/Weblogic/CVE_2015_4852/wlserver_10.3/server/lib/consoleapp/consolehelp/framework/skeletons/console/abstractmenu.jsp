<!--
    The abstractmenu helper file renders a HTML <ul> for the menu. 
    Each page is rendered as a HTML <li> element with the title. 
    For inactive pages the title is in a HTML <a> element

    When specified, page images are rendered in place of page titles.  
    Rollover images cause two images to be rendered within the <li> element. 
    Skins are expected to manage the dynamic visibility of the images and
    ensure that both images are not simultaneously visible.

    Note: The current console style does not use images on tabs.

    For multi-level menus, this helper file is executed recursively for 
    each page.  Each page <li> element that corresponds to a book will contain
    nested <ul> menus for the book.

    Note: The current console style does not make use of multi level menus

    Additional Console specific menu processing:
    
    1) A number of Console pages require a handle parameter on the page URL.
    See the handleParam variable.
    
    2) For 508 Accessability menu tabs have a title (tooltip) that identifies
    the link as a tab and if it is selected. For nested menus this contains
    the parents as well
    
    3) The menu titles are localized here with PortalUtil.getTitle which uses
    the right bundle for extensions when they use the skeleton-resource-bundle
    metadata.
    
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:render="http://www.bea.com/servers/portal/tags/netuix/render"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />

    <!--  Console specific begin -->
    <jsp:directive.page import="com.bea.help.utils.PortalUtils"/>
    <jsp:directive.page import="com.bea.netuix.servlets.controls.page.PagePresentationContext" />
    <jsp:directive.page import="com.bea.netuix.servlets.controls.page.MenuPresentationContext" />
  
    <wl:setBundle basename="HelpViewerResources" var="current_bundle" scope="page" />
    <fmt:message key="tab.accessibility.appends.selected.label" bundle="${current_bundle}"
            var="tabAccessbilitySelectedLabel" scope="page" />
    <fmt:message key="tab.accessibility.appends.label" bundle="${current_bundle}"
            var="tabAccessbilityLabel" scope="page" />
    <!--  Console specific end -->
    <ul>
        <c:forEach items="${bookpc.entitledPagePresentationContexts}" var="pagepc">
            <c:if test="${!pagepc.hidden and pagepc.visible}">

                <!--  Console specific begin -->
                <jsp:scriptlet>
                  <![CDATA[
                  PagePresentationContext pagepc = (PagePresentationContext)pageContext.getAttribute("pagepc");
                  // get the handle if any to append to the URL
                  String handleString = PortalUtils.getPortletHandleString(request, pagepc);
                  if (handleString == null) {
                    handleString = "";
                  } else {
                    handleString = "&amp;" + handleString;
                  }

                  // get the localized title and tooltip strings. 
                  // the title is always from this page context
                  String title = pagepc.getTitle();
                  if (title != null && title.indexOf(".") != -1) {
                    title = PortalUtils.getTitle(pagepc, pageContext);
                  }
                  
                  // The tooltip can include parents. To know how many parent levels
                  // to go up check the presentation class.
                  int level = 1;
                  MenuPresentationContext menupc = (MenuPresentationContext)pageContext.findAttribute("menupc");
                  String pc = menupc.getPresentationClass();
                  if (pc != null)
                  {
                    if (pc.equals("menu-level1")) {
                      level = 2;
                    } else if (pc.equals("menu-level2")) {
                      level = 3;
                    }
                  }
                  String tooltip = "";
                  String accessbility = "";
                  PagePresentationContext curPagepc = pagepc;
                  for (int i = 0; i < level; i++) {
                    String curTitle = curPagepc.getTitle();
                    if (curTitle != null && curTitle.indexOf(".") != -1) {
                      curTitle = PortalUtils.getTitle(curPagepc, pageContext);
                    }
                    if (i > 0) {
                      tooltip = curTitle + " - " + tooltip;
                    } else {
                      tooltip = curTitle;
                    }
                    curPagepc = curPagepc.getParentPagePresentationContext();
                  }
                  if (pagepc.isDisplayed()) {
                    accessbility = (String) pageContext.findAttribute("tabAccessbilitySelectedLabel");
                  } else {
                    accessbility = (String) pageContext.findAttribute("tabAccessbilityLabel");
                  }
                  tooltip += accessbility;
                  ]]>
                </jsp:scriptlet>
                <c:set var="handleParam" scope="page"><jsp:expression>handleString</jsp:expression></c:set>
                <c:set var="title" scope="page"><jsp:expression>title</jsp:expression></c:set>
                <c:set var="tooltip" scope="page"><jsp:expression>tooltip</jsp:expression></c:set>
                <c:set var="accessbility" scope="page"><jsp:expression>accessbility</jsp:expression></c:set>
                <!--  Console specific end -->

                <li class="${pagepc.displayed ? 'console-menu-active' : ''}" title="${tooltip}">
                    <c:choose>
                        <!-- Active page -->
                        <c:when test="${pagepc.displayed}">
                            <div><span class="tab"><span>
                                <c:choose>
                                    <c:when test="${! empty pagepc.activeImage}">
                                        <c:if test="${! empty pagepc.rolloverImage}">
                                            <c:set var="imageclass" value="console-image-nonrollover"/>
                                            <html:img src="${pagepc.rolloverImage}" alt="${title} " title="${title}" styleClass="console-image-rollover"/>
                                        </c:if>
                                        <html:img src="${pagepc.activeImage}" alt="${title} " title="${title}" styleClass="${imageclass}"/>
                                        <c:remove var="imageclass"/>
                                    </c:when>
                                    <c:otherwise>
                                        <jsp:text>${title}</jsp:text><span class='screenReadersOnly'>${accessbility}</span>
                                    </c:otherwise>
                                </c:choose>
                            </span></span></div>
                        </c:when>
                        <!-- Inactive page -->
                        <c:otherwise>
                            <render:pageUrl forcedAmpForm='true' pageLabel="${pagepc.label}" var="pageUrl"/>
                            <a href="${pageUrl}${handleParam}" title="${tooltip}"><span class="tab"><span>
                                <c:choose>
                                    <c:when test="${! empty pagepc.inactiveImage}">
                                        <c:if test="${! empty pagepc.rolloverImage}">
                                            <c:set var="imageclass" value="console-image-nonrollover"/>
                                            <html:img src="${pagepc.rolloverImage}" alt="${title} " title="${title}" styleClass="console-image-rollover"/>
                                        </c:if>
                                        <html:img src="${pagepc.inactiveImage}" alt="${title} " title="${title}" styleClass="${imageclass}"/>
                                        <c:remove var="imageclass"/>
                                    </c:when>
                                    <c:otherwise>
                                        <jsp:text>${title}</jsp:text>
                                    </c:otherwise>
                                </c:choose>
                            </span></span></a>
                        </c:otherwise>
                    </c:choose>
                    <!-- Recursively call this menu file for each book in a multi-level menu. -->
                    <c:if test="${pagepc.tagName == 'page:book' and param.type == 'multi'}">
                        <c:set var="bookpc" value="${pagepc}" scope="request"/>
                        <jsp:include page="abstractmenu.jsp"/>
                    </c:if>
                </li>
            </c:if>
        </c:forEach>
    </ul>
</jsp:root>
