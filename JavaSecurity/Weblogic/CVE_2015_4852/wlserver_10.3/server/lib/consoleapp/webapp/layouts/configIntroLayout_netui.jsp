<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0"
    xmlns:html="http://struts.apache.org/tags-html"
    xmlns:wl="/WEB-INF/console-html.tld">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for simple pages that just have text
  Use when you want:
  configAreaIntroduction
-->

<div class="contenttable">
  <div class="introText">
    <template:includeSection name="configAreaIntroduction"/>
  </div>
</div>
</jsp:root>
