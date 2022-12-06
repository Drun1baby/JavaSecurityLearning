<!--
    The header skeleton file renders a HTML <div> element for the header.  
    The children are custom Console markup
-->
<jsp:root version="2.0" 
    xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
	xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:render="http://www.bea.com/servers/portal/tags/netuix/render"
	xmlns:fmt="http://java.sun.com/jsp/jstl/fmt">
	<jsp:directive.page session="false" />
	<jsp:directive.page isELIgnored="false" />

	<wl:setBundle basename="HelpViewerResources" var="current_bundle" scope="page" />

	<skeleton:context type="headerpc">
		<skeleton:control name="div" presentationContext="${headerpc}"
			presentationClass="console-header">
			<div id="console-header-logo">
			    <!-- Section 508: Skip repetitive links -->
				<fmt:message key="sec508.skiplinks" bundle="${current_bundle}"
					var="skiplinks" scope="page" />
				<fmt:message key="login.wlsident" bundle="${current_bundle}"
					var="wlsident" scope="page" />
				<a href="#repetitive_links"><html:img src="images/spacer.gif" alt="${skiplinks} " /></a>
                <render:pageUrl forcedAmpForm='true' pageLabel='HomePage1' var="homeURL" scope="page"/>
                <fmt:message key='toolbar.home' bundle="${current_bundle}" var="homeTitle" scope="page"/>
				<a href="${homeURL}" title="${homeTitle}">
                  <html:img StyleId="console-title" src="framework/skins/console/images/Branding_WeblogicConsole.gif" alt="${homeTitle} " /></a>
		    </div>
            <div id="global-links">
                <fmt:message key="page.status.idle" bundle="${current_bundle}"
                  var="statusIdle" scope="page" />
                <fmt:message key="page.status.busy" bundle="${current_bundle}"
                  var="statusBusy" scope="page" />
                <span id="pageStatus">
                  <html:img styleId="pageIdle" alt="${statusIdle}" title="${statusIdle}" src="framework/skins/console/images/pageIdle.gif"/>
                  <html:img styleId="pageBusy" alt="${statusBusy}" title="${statusBusy}" src="framework/skins/console/images/pageBusy.gif"/>
                </span>
            </div>
            <div id="header-trans">
                <html:img alt="" src="framework/skins/console/images/gradient-white-none.png"/>
            </div>            
        </skeleton:control>
	</skeleton:context>
</jsp:root>
