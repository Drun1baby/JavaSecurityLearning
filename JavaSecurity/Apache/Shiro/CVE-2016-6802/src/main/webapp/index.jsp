<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/10/25
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--不加 下面的这个，<%--<%@ page isELIgnored="false" %> --%>  jstl 不起作用，不知道为什么，艹了-->
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="static/css/style.css">
</head>
<body>
<div class="workingroom">
  <div class="loginDiv">
      <c:if test="${empty subject.principal}">
          <a href="login.jsp">登录</a><br>
          <span>还没账号？</span><a href="register.jsp">注册一个呗</a><br>
      </c:if>
      <c:if test="${!empty subject.principal}">
          <span class="desc">你好，${subject.principal}
             ,您的角色是：${roleList}</span>
          <a href="doLogout">退出</a><br>
      </c:if>
      <a href="listProduct.jsp">查看产品</a><span>需要登录后才可以查看</span><br>
      <a href="deleteProduct.jsp">删除产品</a><span>需要登录，而且还要有 productManager 的角色才可以</span>
      <a href="deleteOrder.jsp">删除订单</a><span>需要登录，而且还要有 deletOrder 的权限才可以</span><br>

  </div>
</div>
</body>
</html>
