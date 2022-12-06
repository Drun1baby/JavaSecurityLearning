<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:wl="/WEB-INF/console-html.tld"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all single table pages that want to include 
  table refresh functionality
  Use when you want:
  configAreaIntroduction
  table with refresh
-->
<div class="contenttable">
    <!-- include the table intro text here-->
    <div class="introText">
        <template:includeSection name="configAreaIntroduction"/>
    </div>
    <!-- include any action messages here -->
    <jsp:include page="/jsp/common/ActionMessages.jsp"/>
    <!-- include the table here -->
    <wl:refresh-portlet>
      <template:includeSection name="table"/>
    </wl:refresh-portlet>
</div>
</jsp:root>
