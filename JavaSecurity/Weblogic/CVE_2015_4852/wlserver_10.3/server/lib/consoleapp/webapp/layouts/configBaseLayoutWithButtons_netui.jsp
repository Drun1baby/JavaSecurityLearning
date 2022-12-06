<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0"
    xmlns:wl="/WEB-INF/console-html.tld">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all "normal" configuration form jsp in the console
  that need extra buttons in the button bar.
  Use when you want:
  Fixed: save button when not read only
  buttons
  Fixed: need lock message when needed and not read only
  configAreaIntroduction
  form
  Fixed: save button when not read only
  buttons
  Fixed: need lock message when needed and not read only
-->

<wl:change-center id="chgctr"/>

<div class="contenttable">

    <!-- include the save button (if needed) and the extra buttons here -->
    <div class="upperButtonBar">
      <wl:button-bar>
        <c:choose>
        <c:when test="${not formInstance.readOnly &amp;&amp; chgctr.lockOwner &amp;&amp; not chgctr.activateInProgress}">
          <wl:button-bar-button labelid="button.save.label" onclick="doSaveButton(document.${THEBEAN});"/>
        </c:when>
        <c:otherwise>
          <wl:button-bar-button labelid="button.save.label" readOnly="true"/>
        </c:otherwise>
        </c:choose>
        <template:includeSection name="buttons"/>
      </wl:button-bar>
    </div>

    <c:if test="${not formInstance.readOnly}">
      <c:if test="${not chgctr.lockOwner || chgctr.activateInProgress}">
        <!-- warn that the user needs to get the lock if they want to modify the contents of this page -->
        <jsp:include page="/jsp/changemgmt/needlockConfig.jsp"/>
      </c:if>
    </c:if>

    <!-- include the intro text here -->
    <div class="introText">
        <template:includeSection name="configAreaIntroduction"/>
    </div>

    <!-- include the form here -->
    <template:includeSection name="form"/>

    <!-- include the save button (if needed) and the extra buttons here -->
    <div class="lowerButtonBar">
      <wl:button-bar>
        <c:choose>
        <c:when test="${not formInstance.readOnly &amp;&amp; chgctr.lockOwner &amp;&amp; not chgctr.activateInProgress}">
          <wl:button-bar-button labelid="button.save.label" onclick="doSaveButton(document.${THEBEAN});"/>
        </c:when>
        <c:otherwise>
          <wl:button-bar-button labelid="button.save.label" readOnly="true"/>
        </c:otherwise>
        </c:choose>
        <template:includeSection name="buttons"/>
      </wl:button-bar>
    </div>

    <c:if test="${not formInstance.readOnly}">
      <c:if test="${not chgctr.lockOwner || chgctr.activateInProgress}">
        <!-- warn that the user needs to get the lock if they want to modify the contents of this page -->
        <jsp:include page="/jsp/changemgmt/needlockConfig.jsp"/>
      </c:if>
    </c:if>
</div>
</jsp:root>
