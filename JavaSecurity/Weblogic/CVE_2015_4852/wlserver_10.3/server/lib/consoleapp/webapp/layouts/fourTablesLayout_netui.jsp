<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all table pages
  Use when you want:
  4 tables each having
  intro<n>
  table<n>
  where <n> is from 1 to 4.
-->
<div class="contenttable">
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

    <!-- include the third table intro text here-->
    <div class="introText">
        <template:includeSection name="intro3"/>
    </div>
    <!-- include the third table here -->
    <template:includeSection name="table3"/>

    <!-- include the fourth table intro text here-->
    <div class="introText">
          <template:includeSection name="intro4"/>
    </div>
    <!-- include the fourth table here -->
    <template:includeSection name="table4"/>
</div>
</jsp:root>
