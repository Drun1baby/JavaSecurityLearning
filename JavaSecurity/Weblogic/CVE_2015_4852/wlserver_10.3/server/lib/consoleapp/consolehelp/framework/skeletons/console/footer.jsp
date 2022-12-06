<!--
    The footer skeleton file renders a HTML <div> element for the footer.  
    The children are replaced with custom Console markup
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
>
    <jsp:directive.page import="weblogic.version"/>
    <jsp:directive.page session="false" />
    <jsp:directive.page isELIgnored="false" />

    <wl:setBundle basename="HelpViewerResources" var="current_bundle" scope="page"/>

    <skeleton:context type="footerpc">
        <skeleton:control name="div" presentationContext="${footerpc}" 
        presentationClass="console-footer">
          <div id="console-footer">
            <div class="info">
            <!-- Get short version string - just the numbers -->
            <c:set var="ver" scope="page">
              <jsp:expression>weblogic.version.getReleaseBuildVersion()</jsp:expression>
            </c:set>
            <p id="footerVersion"><fmt:message key='weblogic.version' bundle="${current_bundle}" />: ${ver}</p>
            <!-- 
            Note: The QA view test use this string to indicate the page has fully
            loaded. This is because the copyright is displayed at the bottom of every
            page. Keep this in mind when changing this string.
            -->
            <p id="copyright"><fmt:message key='console.copyright' bundle="${current_bundle}" /></p>
            <p id="trademark"><fmt:message key='console.trademark' bundle="${current_bundle}" /></p>
            </div>
			<skeleton:children />
          </div>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
