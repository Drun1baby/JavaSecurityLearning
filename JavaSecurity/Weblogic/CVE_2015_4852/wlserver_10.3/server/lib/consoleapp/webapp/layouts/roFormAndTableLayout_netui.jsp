<%@ page language="java" %>
<%@ taglib uri="http://beehive.apache.org/netui/tags-template-1.0" prefix="beehive-template" %>
<%@ taglib uri="/WEB-INF/console-html.tld" prefix="wl" %>

<!--
    NOTE: This layout template is deprecated. It will be removed in a future
    release. Use configNoTransactAndTables_netui.jsp instead.
-->

<table width=100% border=0 cellpadding=0 cellspacing=6 class="contenttable">
    <tr>
        <!-- include the intro text here-->
        <td colspan="2" align="left">
          <br/>
          <table width="95%" cellpadding="0" cellspacing="0" border="0"><tr><td align="left">
            <beehive-template:includeSection name="configAreaIntroduction"/>
          </td></tr></table>
          <br/>								
        </td>
    </tr>
    <tr>
        <!-- include the form here -->
        <td colspan="2" class="dottedlineBelow">
            <beehive-template:includeSection name="form"/>
        </td>
    </tr>
    <tr>
        <!-- include the intro text here-->
        <td colspan="2" align="center">
        <br/>
        <table width="95%" cellpadding="0" cellspacing="0" border="0"><tr><td align="left">
          <beehive-template:includeSection name="tableAreaIntroduction"/>
        </td></tr></table>
        </td>
    </tr>
    <tr>
        <!-- include the table here -->
        <td colspan="2" align="center">
        <br/>
        <table width="95%" cellpadding="0" cellspacing="0" border="0"><tr><td align="left">
          <beehive-template:includeSection name="table"/>
        </td></tr></table>
        <br/>
        </td>
    </tr>
</table>

