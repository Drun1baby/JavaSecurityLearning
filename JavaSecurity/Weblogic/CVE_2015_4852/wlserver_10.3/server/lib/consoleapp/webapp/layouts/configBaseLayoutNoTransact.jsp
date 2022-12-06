<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0"
    xmlns:wl="/WEB-INF/console-html.tld">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all non-transaction configuration form jsp in the console
  Use when you want:
  Fixed: save button when not read only
  configAreaIntroduction
  form
  Fixed: save button when not read only
-->

<wl:change-center id="chgctr"/>

<div class="contenttable">

    <c:if test="${not formInstance.readOnly}">
        <!-- display a Save button -->
        <div class="upperButtonBar">
          <wl:button-bar>
             <wl:button-bar-button labelid="button.save.label" onclick="doSaveButton(document.${THEBEAN});" singlechange="false"/>
          </wl:button-bar>
        </div>
    </c:if>

    <!-- include the intro text here -->
    <div class="introText">
        <template:includeSection name="configAreaIntroduction"/>
    </div>

    <!-- include the form here -->
    <template:includeSection name="form"/>

    <c:if test="${not formInstance.readOnly}">
        <!-- display a Save button -->
        <div class="lowerButtonBar">
          <wl:button-bar>
             <wl:button-bar-button labelid="button.save.label" onclick="doSaveButton(document.${THEBEAN});" singlechange="false"/>
          </wl:button-bar>
        </div>
    </c:if>

</div>
</jsp:root>
