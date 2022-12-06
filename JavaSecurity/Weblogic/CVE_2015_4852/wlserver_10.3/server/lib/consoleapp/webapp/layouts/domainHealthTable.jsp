<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://beehive.apache.org/netui/tags-template-1.0" prefix="beehive-template" %>

<!--
    NOTE: This layout template is deprecated. It will be removed in a future
    release. Use filterAndTableLayout_netui.jsp instead.
-->

<table width=100% border=0 cellpadding=0 cellspacing=6 class="contenttable">
    <tr>
        <!-- include the intro text here-->
        <td colspan="2">
            <beehive-template:includeSection name="configAreaIntroduction"/>
        </td>
    </tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
      <td colspan="2">
            <beehive-template:includeSection name="healthfilterselect"/>
      </td>
    </tr>
    <tr>
        <!-- include the table here -->
        <td colspan="2">
            <beehive-template:includeSection name="table"/>
        </td>
    </tr>
</table>
