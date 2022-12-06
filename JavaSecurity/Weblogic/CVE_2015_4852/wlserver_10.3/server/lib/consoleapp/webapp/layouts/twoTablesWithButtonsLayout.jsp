<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for pages with two tables and a button bar
  Use when you want:
  buttons
  intro1
  table1
  intro2
  table2
  buttons

-->

<div class="contenttable">
    <!-- display buttons -->
    <div class="upperButtonBar">
        <template:includeSection name="buttons"/>
    </div>

    <!-- include the first table intro text here-->
    <div class="introText">
        <template:includeSection name="intro1"/>
    </div>
    <!-- include the first table here -->
    <template:includeSection name="table1"/>

    <!-- include the second table intro text here-->
    <div class="introText">
        <template:includeSection name="intro2"/>
    </div>
    <!-- include the second table here -->
    <template:includeSection name="table2"/>

    <!-- display buttons -->
    <div class="lowerButtonBar">
        <template:includeSection name="buttons"/>
    </div>
</div>
</jsp:root>
