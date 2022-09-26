
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>JSP 对象</title>
  </head>
  <body>
  <h3>pageContext 对象</h3>

        ${pageContext.request.queryString}

        <br/>

        <h3>Scope 对象</h3>

        <%
            pageContext.setAttribute("name","Drunkbaby_page");
            request.setAttribute("name","Drunkbaby_page");
            session.setAttribute("user","Drunkbaby_session");
            application.setAttribute("user","Drunkbaby_application");
        %>

        pageScope.name:${pageScope.name}
        </br>
        requestScope.name : ${requestScope.name}
        </br>
        sessionScope.user : ${sessionScope.user}
        </br>
        applicationScope.user : ${applicationScope.user}

        </br>
        <h3>param 对象</h3>
        <p>${param["username"]}</p>

        </br>
        <h3> header 和 headerValues 对象</h3>
        <p>${header["user-agent"]}</p>

  </body>
</html>
