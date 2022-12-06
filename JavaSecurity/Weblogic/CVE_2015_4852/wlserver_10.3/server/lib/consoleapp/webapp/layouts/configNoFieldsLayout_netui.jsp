<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all informational pages
  Use when you want:
  configAreaIntroduction
  form
-->

<div class="contenttable">

    <!-- include the intro text here -->
    <div class="introText">
        <template:includeSection name="configAreaIntroduction"/>
    </div>

    <!-- include any action messages here -->
    <jsp:include page="/jsp/common/ActionMessages.jsp"/>

    <!-- include the form here -->
    <template:includeSection name="form"/>

</div>
</jsp:root>
