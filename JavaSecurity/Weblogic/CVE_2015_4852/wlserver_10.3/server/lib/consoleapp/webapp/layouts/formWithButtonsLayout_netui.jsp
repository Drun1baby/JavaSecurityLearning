<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0"
    xmlns:wl="/WEB-INF/console-html.tld">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for forms pages that need to provide a button bar but do not
  participate in the config manager locking.
  Use when you want:
  buttons
  configAreaIntroduction
  form
  buttons
-->

<div class="contenttable">
    <!-- display buttons -->
    <div class="upperButtonBar">
        <template:includeSection name="buttons"/>
    </div>

    <!-- include the intro text here -->
    <div class="introText">
        <template:includeSection name="configAreaIntroduction"/>
    </div>

    <!-- include the form here -->
    <template:includeSection name="form"/>

    <!-- display buttons -->
    <div class="lowerButtonBar">
        <template:includeSection name="buttons"/>
    </div>
</div>
</jsp:root>


