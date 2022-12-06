<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for tree editing in assistants

  Use when you want:
  Fixed Assistant navitation buttons Back, Next, Finish, Cancel
  title - step title
  introduction
  currentRule - a label
  editRule - form controls to show and edit the rule
  expressionLabel - a label
  buttonBar - buttons in support of the policy-editor control
  expressionTree - A policy-editor control
  buttonBar
  Fixed Assistant navitation buttons Back, Next, Finish, Cancel
  
-->

<div class="contenttable">
    <!-- Save button -->
    <div class="upperButtonBar">
      <wl:button-bar>
        <wl:button-bar-button labelid="button.back.label" action="/start"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-button labelid="button.next.label" action="/configAlarm"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-separator image="images/buttonSeparator.gif"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-button labelid="button.finish.label" action="/finish"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-separator image="images/buttonSeparator.gif"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-button labelid="button.cancel.label" action="/cancel"/>
      </wl:button-bar>
    </div>

    <!-- include the step title here-->
    <div class="stepTitle">
        <template:includeSection name="title"/>
    </div>
    <!-- include the step intro text here-->
    <div class="introText">
        <template:includeSection name="introduction"/>
    </div>

    <html:xhtml/>
    <wl:template name="WEB-INF/templates/assistant.xml">
      <wl:form action="/begin" bundle="core">
        <row>
          <c:set var="label" scope="page"><template:includeSection name="currentRule"/></c:set>
          <fieldlabel value="${label}"/>
          <template:includeSection name="editRule"/>
        </row>

        <label><template:includeSection name="expressionLabel"/>:</label>

        <template:includeSection name="buttonBar"/>
        <policy-editor>
          <template:includeSection name="expressionTree"/>
        </policy-editor>
        <template:includeSection name="buttonBar"/>
        <formstate>
          <html:hidden property="handle"/>
        </formstate>
      </wl:form>
    </wl:template>

    <div class="lowerButtonBar">
      <wl:button-bar>
        <wl:button-bar-button labelid="button.back.label" action="/start"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-button labelid="button.next.label" action="/configAlarm"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-separator image="images/buttonSeparator.gif"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-button labelid="button.finish.label" action="/finish"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-separator image="images/buttonSeparator.gif"/>
        <jsp:text> </jsp:text>
        <wl:button-bar-button labelid="button.cancel.label" action="/cancel"/>
      </wl:button-bar>
    </div>

</div>
</jsp:root>
