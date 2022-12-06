<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!-- 
  Template used for all web app role editing screens. Similar to roleEditorLayout
  but with the addition of a url pattern area

  Use when you want:
  Fixed Save button
  title
  introduction - a piece of introductory text describing the particular role editor
  urlpatternLabel - label for the url pattern
  urlpatternIntroText - a piece of introductory text describing the particular field
  methodsIntroText - Intro text for methods area
  methodsLabel - Label for resourceList[0].label
  conditionsIntroText - filedintrotext for the given policy conditions.
  conditionsLabel - label for the policy conditions field
  buttonBar
  Fixed policy editor
  buttonBar
  Fixed Save button

-->

<div class="contenttable">
    <!-- Save button -->
    <div class="upperButtonBar">
      <wl:button-bar>
        <wl:button-bar-button labelid="button.save.label" action="/persist" singlechange="false"/>
      </wl:button-bar>
    </div>

    <div class="introText">
        <template:includeSection name="title"/>
    </div>

    <div class="introText">
        <template:includeSection name="introduction"/>
    </div>

    <html:xhtml/>
    <wl:template name="WEB-INF/templates/assistant.xml">
    <wl:form action="/begin">

      <!-- URL pattern area -->
      <div class="introText">
        <template:includeSection name="urlpatternIntroText"/>
      </div>
      <row>
        <c:set var="urlpatternLabel" scope="page"><template:includeSection name="urlpatternLabel"/></c:set>
        <fieldlabel value="${urlpatternLabel}"/>
        <inputfield readOnly="true"><input name="roleName" value="${policyEditorForm.urlPattern}" /></inputfield>
      </row>
  
      <!-- Methods area -->
      <div class="introText">
        <template:includeSection name="methodsIntroText"/>
      </div>
      <row>
        <c:set var="methodsLabel" scope="page"><template:includeSection name="methodsLabel"/></c:set>
        <fieldlabel value="${methodsLabel}"/>
        <inputfield readOnly="true"><input name="roleName" value="${policyEditorForm.resourceList[0].label}" /></inputfield>
      </row>
  
      <!-- Conditions area -->
      <div class="introText">
        <template:includeSection name="conditionsIntroText"/>
      </div>

      <label><template:includeSection name="conditionsLabel"/>:</label>
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
</div>
</jsp:root>
