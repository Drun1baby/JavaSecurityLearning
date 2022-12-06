<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://beehive.apache.org/netui/tags-template-1.0" prefix="beehive-template" %>
<%@ taglib uri="render.tld" prefix="render" %>

<%@ taglib uri="/WEB-INF/console-html.tld" prefix="wl" %>


<!--
    NOTE: This layout template is deprecated. It will be removed in a future
    release. Use configNoFieldsLayout_netui.jsp instead.
-->

<table width=100% border=0 cellpadding=0 cellspacing=6 class="contenttable">
    <tr>
        <!-- include the intro text here-->
        <td colspan="2" align="center">
          <table width="95%" cellpadding="0" cellspacing="0" border="0"><tr><td align="left">
            <beehive-template:includeSection name="configAreaIntroduction"/><br/>
          </td></tr></table>
        </td>
    </tr>
    <tr>
        <!-- include the form here -->
        <td colspan="2">
            <beehive-template:includeSection name="form"/>
        </td>
    </tr>
</table>
