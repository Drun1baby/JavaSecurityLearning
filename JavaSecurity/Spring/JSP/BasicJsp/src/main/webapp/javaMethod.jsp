<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>JSP 调用 Java 方法</title>
  </head>
  <body>
  <%@taglib uri="http://localhost/ELFunc" prefix="ELFunc"%>
  ${ELFunc:doSomething("Drunkbaby")}
  </body>
</html>
