<%--
  Created by IntelliJ IDEA.
  User: VanHurts
  Date: 2022/9/23
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>JSP 基础语法学习</title>
  </head>
  <body>
  <h1>Drunkbaby's JSP Learn</h1>
    <% out.println("Drunkbaby Hello!"); %>
    <%! String s= "Study Hard!! GOGO!"; %>
    <% out.println(s); %>

    <h2>Hello World!!!</h2>
    <p><% String name = "Drunkbaby"; %>username:<%=name%></p>
  </body>
</html>
