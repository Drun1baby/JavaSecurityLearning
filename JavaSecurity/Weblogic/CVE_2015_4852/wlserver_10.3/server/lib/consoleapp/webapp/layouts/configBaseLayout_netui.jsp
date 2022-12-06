<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0"
    xmlns:wl="/WEB-INF/console-html.tld">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all "normal" configuration form jsp in the console
  Use when you want:
  Fixed: save button or need lock message when not read only
  configAreaIntroduction
  form
  Fixed: save button or need lock message when not read only
-->

<wl:change-center id="chgctr"/>

<div class="contenttable">

    <c:if test="${not formInstance.readOnly}">
        <!-- display a Save button or help on how to get the lock -->
        <c:choose>
        <c:when test="${chgctr.lockOwner &amp;&amp; not chgctr.activateInProgress}">
            <div class="upperButtonBar">
              <wl:button-bar>
                 <wl:button-bar-button labelid="button.save.label" onclick="doSaveButton(document.${THEBEAN});"/>
              </wl:button-bar>
            </div>
        </c:when>
        <c:otherwise>
            <jsp:include page="/jsp/changemgmt/needlockConfig.jsp"/>
            <div class="upperButtonBar">
              <wl:button-bar>
                 <wl:button-bar-button labelid="button.save.label" readOnly="true"/>
              </wl:button-bar>
            </div>
        </c:otherwise>
        </c:choose>
    </c:if>

    <!-- include the intro text here -->
    <div class="introText">
        <template:includeSection name="configAreaIntroduction"/>
    </div>

    <!-- include any action messages here -->
    <jsp:include page="/jsp/common/ActionMessages.jsp"/>    

    <!-- include the form here -->
    <template:includeSection name="form"/>

    <c:if test="${not formInstance.readOnly}">
        <!-- display a Save button or help on how to get the lock -->
        <c:choose>
        <c:when test="${chgctr.lockOwner &amp;&amp; not chgctr.activateInProgress}">
            <div class="lowerButtonBar">
              <wl:button-bar>
                 <wl:button-bar-button labelid="button.save.label" onclick="doSaveButton(document.${THEBEAN});"/>
              </wl:button-bar>
            </div>
        </c:when>
        <c:otherwise>
            <div class="upperButtonBar">
              <wl:button-bar>
                 <wl:button-bar-button labelid="button.save.label" readOnly="true"/>
              </wl:button-bar>
            </div>
            <jsp:include page="/jsp/changemgmt/needlockConfig.jsp"/>            
        </c:otherwise>
        </c:choose>
    </c:if>

</div>
</jsp:root>
