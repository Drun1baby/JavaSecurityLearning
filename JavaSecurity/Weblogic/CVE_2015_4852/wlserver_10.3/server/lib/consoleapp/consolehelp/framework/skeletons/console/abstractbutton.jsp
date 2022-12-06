<!--
    The abstract button helper file renders a HTML <a> element for the button. 
    The <a> element contains the button image and has an attached click handler.

    When used, rollover images cause two images to be rendered within the <a>
    element.  Skins are expected to manage the dynamic visibility of the images
    and ensure that both images are not simultaneously visible.
-->
<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:skeleton="http://www.bea.com/servers/portal/tags/netuix/skeleton"
>
    <jsp:directive.page session="false"/>
    <jsp:directive.page isELIgnored="false"/>
    <skeleton:context type="abstractbuttonpc">
        <!-- Note that "href", etc. are dynamic attributes and passed directly to the HTML output. -->
        <skeleton:control name="a" presentationContext="${abstractbuttonpc}" href="${param.href}" onclick="${param.onclick}">
            <c:if test="${! empty abstractbuttonpc.rolloverImage}">
                <c:set var="imageclass" value="console-image-nonrollover"/>
                <html:img src="${abstractbuttonpc.rolloverImageSrc}" alt="${abstractbuttonpc.altText}" title="${abstractbuttonpc.altText}" styleClass="console-image-rollover"/>
            </c:if>
            <html:img src="${abstractbuttonpc.imageSrc}" alt="${abstractbuttonpc.altText}" title="${abstractbuttonpc.altText}" styleClass="${imageclass}"/>
            <c:remove var="imageclass"/>
        </skeleton:control>
    </skeleton:context>
</jsp:root>
