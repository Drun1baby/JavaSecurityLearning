<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0"
    xmlns:wl="/WEB-INF/console-html.tld">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for pages that contain non transactional configuration and
  up to 4 tables.
  Use when you want:
  Fixed: save button if not read only
  configAreaIntroduction
  form
  Fixed: save button if not read only
  table1Introduction (optional)
  table1 (optional)
  table2Introduction (optional)
  table2 (optional)
  table3Introduction (optional)
  table3 (optional)
  table4Introduction (optional)
  table5 (optional)
  - we can add more tables if necessary ...

  To use an optional table, the jsp needs to set a request attribute to true,
  e.g. includeTable1, plus define the intro text and table template sections
  for that table, e.g. table1Introduction and table1.
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

    <!-- include any action messages here -->
    <jsp:include page="/jsp/common/ActionMessages.jsp"/>

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

    <c:if test="${includeTable1}">
        <!-- include the table1 intro text here-->
        <div class="introText">
            <template:includeSection name="table1Introduction"/>
        </div>

        <!-- include table1 here -->
        <template:includeSection name="table1"/>
    </c:if>
    <c:if test="${includeTable2}">
        <!-- include the table2 intro text here-->
        <div class="introText">
            <template:includeSection name="table2Introduction"/>
        </div>

        <!-- include table2 here -->
        <template:includeSection name="table2"/>
    </c:if>
    <c:if test="${includeTable3}">
        <!-- include the table3 intro text here-->
        <div class="introText">
            <template:includeSection name="table3Introduction"/>
        </div>

        <!-- include table3 here -->
        <template:includeSection name="table3"/>
    </c:if>
    <c:if test="${includeTable4}">
        <!-- include the table4 intro text here-->
        <div class="introText">
            <template:includeSection name="table4Introduction"/>
        </div>

        <!-- include table4 here -->
        <template:includeSection name="table4"/>
    </c:if>

</div>
</jsp:root>
