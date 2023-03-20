<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/10/25
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="static/css/style.css">
    <script type="text/javascript">
        function edit(){
            window.location.href="register.jsp";
        }
    </script>
</head>
<body>
<div class="workingroom">
    <div class="errorInfo">${error}</div>
    <form action="login" method="post">
        账号： <input type="text" name="name" ><br>
        密码： <input type="password" name="password" ><br>
        <br>
        <input type="submit" value="登录">
        <input type="button" value="注册" onclick="edit()">
        <br><br>
    </form>
</div>
</body>
</html>
