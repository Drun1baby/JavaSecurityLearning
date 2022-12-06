<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all summary pages.
  Use when you want:
  summaryIntroduction
  summary
-->

<div class="contenttable">

    <!-- include the intro text here -->
    <div class="summaryIntroText">
        <template:includeSection name="summaryIntroduction"/>
    </div>

    <!-- include the summary here -->
    <template:includeSection name="summary"/>

</div>
</jsp:root>
