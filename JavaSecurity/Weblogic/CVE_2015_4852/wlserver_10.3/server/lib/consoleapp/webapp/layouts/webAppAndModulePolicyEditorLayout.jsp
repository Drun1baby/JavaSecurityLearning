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
  Template used for web app policy editing screens. Similar to policyEditorLayout
  but with the addition of a url pattern area

  Use when you want:
  Fixed Save button
  introduction - a piece of introductory text describing the particular policy editor
  urlpatternseparator - label for the url pattern  separator
  urlpatternLabel - label for the url pattern
  urlpatternIntroText - a piece of introductory text describing the particular field
  providerseparator
  providersIntroText
  providersLabel - drop down select for providers
  methodseparator - label for the method separator
  methodsIntroText - like above, but the intro text for the field
  providersLabel - drop down select for methods
  conditionsseparator - label for the policy conditions separator
  conditionsIntroText - filedintrotext for the given policy conditions.
  buttonBar
  Fixed policy editor
  buttonBar
  Fixed Save button
  inheritedPolicyLabel
  Fixed policy editor for inherited policy  

  The caller must localize the label text.
-->

<jsp:scriptlet><![CDATA[
  PageFlowController pfc = PageFlowUtils.getCurrentPageFlow(request);

  String onMethodChange = "nextAction('" + pfc.getModulePath() + "/changeMethod');";
  String onAtzProviderChange = "nextAction('" + pfc.getModulePath() + "/changeAuthorizerProvider');";

  String providerChangedStr = (String)request.getAttribute("defaultauthorizerchanged");

  if (providerChangedStr != null && providerChangedStr.equals("true"))  {
]]></jsp:scriptlet>

   <jsp:include  page="/jsp/security/AuthorizerChanged.jsp"/>

<jsp:scriptlet> } else { </jsp:scriptlet>

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
      <!-- URL pattern area -->
      <c:set var="urlpatternseparator" scope="page"><template:includeSection name="urlpatternseparator"/></c:set>
      <separator label="${urlpatternseparator}"/>

      <div class="introText">
        <template:includeSection name="urlpatternIntroText"/>
      </div>
      <row>
        <c:set var="urlpatternLabel" scope="page"><template:includeSection name="urlpatternLabel"/></c:set>
        <fieldlabel value="${urlpatternLabel}"/>
        <inputfield readOnly="true"><input name="urlPattern" value="${policyEditorForm.urlPattern}" /></inputfield>
      </row>

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

      <!-- Methods area -->
      <c:set var="methodseparator" scope="page"><template:includeSection name="methodseparator"/></c:set>
      <separator label="${methodseparator}"/>
  
      <div class="introText">
        <template:includeSection name="methodsIntroText"/>
      </div>
      <c:set var="methodsLabel" scope="page"><template:includeSection name="methodsLabel"/></c:set>
      <wl:select labelText="${methodsLabel}" onchange="${onMethodChange}" property="resourceID" inlineHelpId=" " singlechange="false">
        <wl:optionsCollection property="resourceList" label="label" value="value" />
      </wl:select>

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

<jsp:scriptlet> } </jsp:scriptlet>

</jsp:root>
