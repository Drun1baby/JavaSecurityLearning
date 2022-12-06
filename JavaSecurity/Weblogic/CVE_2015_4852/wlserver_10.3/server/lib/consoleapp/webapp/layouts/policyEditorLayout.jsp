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
  Template used for all policy editing screens

  Use when you want:
  Fixed Save button
  introduction - a piece of introductory text describing the particular policy editor
  providerseparator
  providersIntroText
  drop down select for providers with label providersLabel
  methodseparator - (optional) label for the method separator
  methodsIntroText - (optional) like above, but the intro text for the field
  (optional) drop down select for resourceList with label methodsLabel
  conditionsseparator - label for the policy conditions separator
  conditionsIntroText - filedintrotext for the given policy conditions.
  buttonBar
  Fixed policy editor
  buttonBar
  Fixed Save button
  inheritedPolicyLabel
  Fixed policy editor for inherited policy  

  To use the optional methods section, the jsp needs to set a request attribute
  called "useMethods" to true.

  The caller must localize the label text.
-->

<jsp:scriptlet>
  PageFlowController pfc = PageFlowUtils.getCurrentPageFlow(request);
  String onMethodChange = "disableButtons(); nextAction('" + pfc.getModulePath() + "/changeMethod');";
  String onAtzProviderChange = "disableButtons(); nextAction('" + pfc.getModulePath() + "/changeAuthorizerProvider');";
</jsp:scriptlet>
<c:set var="onMethodChange" scope="page"><jsp:expression>onMethodChange</jsp:expression></c:set>
<c:set var="onAtzProviderChange" scope="page"><jsp:expression>onAtzProviderChange</jsp:expression></c:set>

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

    <html:xhtml/>
    <wl:template name="WEB-INF/templates/assistant.xml">
    <wl:form action="/begin">
      <!-- Providers area -->
      <c:set var="providerseparator" scope="page"><template:includeSection name="providerseparator"/></c:set>
      <separator label="${providerseparator}"/>

      <div class="introText">
        <template:includeSection name="providersIntroText"/>
      </div>
      <c:set var="providersLabel" scope="page"><template:includeSection name="providersLabel"/></c:set>
      <wl:select labelText="${providersLabel}" onchange="${onAtzProviderChange}" property="selectedAuthorizerProvider" inlineHelpId=" " singlechange="false">
        <wl:optionsCollection property="authorizerProviders" label="label" value="value" />
      </wl:select>

      <!-- Optional Methods area -->
      <c:if test="${useMethods}">
        <c:set var="methodseparator" scope="page"><template:includeSection name="methodseparator"/></c:set>
        <separator label="${methodseparator}"/>
    
        <div class="introText">
          <template:includeSection name="methodsIntroText"/>
        </div>
        <c:set var="methodsLabel" scope="page"><template:includeSection name="methodsLabel"/></c:set>
        <wl:select labelText="${methodsLabel}" onchange="${onMethodChange}" property="resourceID" inlineHelpId=" " singlechange="false">
          <wl:optionsCollection property="resourceList" label="label" value="value" />
        </wl:select>
      </c:if>

      <!-- Conditions area -->
      <c:set var="conditionsseparator" scope="page"><template:includeSection name="conditionsseparator"/></c:set>
      <separator label="${conditionsseparator}"/>

      <div class="introText">
        <template:includeSection name="conditionsIntroText"/>
      </div>

      <template:includeSection name="buttonBar"/>
      <policy-editor>
        <wl:policy-editor name="policyEditorForm" labelId="core.server.serverpolicies.conditions.label" />
      </policy-editor>
      <template:includeSection name="buttonBar"/>

      <formstate>
        <html:hidden property="handle" />
      </formstate>
    </wl:form>
    </wl:template>

    <!-- Save button -->
    <div class="lowerButtonBar">
      <wl:button-bar>
        <wl:button-bar-button labelid="button.save.label" action="/persist" singlechange="false"/>
      </wl:button-bar>
    </div>

    <!-- Inherited Policy -->
    <label><template:includeSection name="inheritedPolicyLabel" /></label>
    <wl:policy-editor name="policyEditorForm" displayInheritedPolicy="true" labelId="core.server.serverpolicies.conditions.label" />

</div>
</jsp:root>
