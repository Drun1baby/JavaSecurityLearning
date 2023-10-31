<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>禁用 EL 表达式</title>
  </head>
  <body>
  <%@ page isELIgnored="true" %>
  ${pageContext.request.queryString}
  </body>
</html>
