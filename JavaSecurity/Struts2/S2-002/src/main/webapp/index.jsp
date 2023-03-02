<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>S2-002</title>
</head>
<body>
<h2>S2-002 Demo</h2>
<s:url action="login" includeParams="all"></s:url>
<s:a href="%{url}">click</s:a>
</body>
</html>