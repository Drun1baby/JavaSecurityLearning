<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />
<jsp:directive.page import="org.apache.beehive.netui.pageflow.PageFlowController" />
<jsp:directive.page import="org.apache.beehive.netui.pageflow.PageFlowUtils" />

<!--
    NOTE: This layout template is deprecated. It will be removed in a future
    release. Use policyEditorLayout.jsp instead.
-->
<jsp:scriptlet>
  PageFlowController pfc = PageFlowUtils.getCurrentPageFlow(request);
  String onAtzProviderChange = "disableButtons(); nextAction('" + pfc.getModulePath() + "/changeAuthorizerProvider');";
</jsp:scriptlet>
<c:set var="onAtzProviderChange" scope="page"><jsp:expression>onAtzProviderChange</jsp:expression></c:set>

<wl:form action="/begin">
<div class="contenttable">
    <!-- Save button -->
    <div class="upperButtonBar">
      <wl:button-bar>
        <wl:button-bar-button labelid="button.save.label" action="/persist" singlechange="false"/>
      </wl:button-bar>
    </div>

    <div class="introText">
        <template:includeSection name="introduction"/>
    </div>

    <fieldset class="formseparator">
      <legend><template:includeSection name="providerseparator"/></legend>

      <div class="introText">
        <template:includeSection name="providersIntroText"/>
      </div>
      <label for="policyEditor.providers"><template:includeSection name="providersLabel"/>:</label>
      <wl:select labelId="policyEditor.providers" onchange="${onAtzProviderChange}" property="selectedAuthorizerProvider" inlineHelpId=" " singlechange="false">
        <wl:optionsCollection property="authorizerProviders" label="label" value="value" />
      </wl:select>
    </fieldset>


    <fieldset class="formseparator">
      <legend><template:includeSection name="conditionsseparator"/></legend>

      <div class="introText">
        <template:includeSection name="conditionsIntroText"/>
      </div>

     <template:includeSection name="buttonBar"/>
     <wl:policy-editor name="policyEditorForm" labelId="core.server.serverpolicies.conditions.label" />
     <template:includeSection name="buttonBar"/>

      <!--  REVIEW jsnyders why not wl:hidden? -->
      <html:hidden property="handle" />
    </fieldset>

    <!-- Save button -->
    <div class="lowerButtonBar">
      <wl:button-bar>
        <wl:button-bar-button labelid="button.save.label" action="/persist" singlechange="false"/>
      </wl:button-bar>
    </div>

    <!-- Inherited Policy -->
    <span class="bold"><template:includeSection name="inheritedPolicyLabel" /></span>
    <wl:policy-editor name="policyEditorForm" displayInheritedPolicy="true" labelId="core.server.serverpolicies.conditions.label" />

</div>
</wl:form>
</jsp:root>
