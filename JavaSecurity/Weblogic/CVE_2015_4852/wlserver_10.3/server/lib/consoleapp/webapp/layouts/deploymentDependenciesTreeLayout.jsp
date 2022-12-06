<%@ page language="java" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://beehive.apache.org/netui/tags-template-1.0" prefix="beehive-template" %>

<!--
    NOTE: This layout template is deprecated. It will be removed in a future
    release. A template is not needed if there is only one section and no
    meaningful style or markup to add.
-->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>        <!-- include the table here -->
        <td colspan="2" height="100%">
            <beehive-template:includeSection name="table"/>
        </td>
    </tr>
</table>
