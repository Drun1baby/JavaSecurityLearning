<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/console-html.tld" prefix="wl" %>
<%@ taglib uri="http://beehive.apache.org/netui/tags-template-1.0" prefix="beehive-template" %>

<!--
    NOTE: This layout template is deprecated. It will be removed in a future
    release. Use configBaseLayoutNoTransact.jsp instead.
-->
<%
    String beanFormHandler = "document."+(String)pageContext.findAttribute("THEBEAN")+".onsubmit();document."+(String)pageContext.findAttribute("THEBEAN")+"[1].submit();";
%>

<table width=100% border=0 cellpadding=0 cellspacing=6 class="contenttable">
    <tr>
        <!-- display a Save button -->
        <td colspan="2" nowrap="true" class="dottedlineBelow">
              <wl:button-bar>
                 <wl:button-bar-button labelid="button.save.label" onclick="<%= beanFormHandler %>"/>
              </wl:button-bar>
        </td>
    </tr>
    <tr>
        <!-- include the form here -->
        <td colspan="2">
            <beehive-template:includeSection name="form"/>
        </td>
    </tr>
    <tr>
        <!-- display a Save button -->
        <td colspan="2" nowrap="true" class="dottedlineAbove">
              <wl:button-bar>
                 <wl:button-bar-button labelid="button.save.label" onclick="<%= beanFormHandler %>"/>
              </wl:button-bar>
        </td>
    </tr>
</table>

