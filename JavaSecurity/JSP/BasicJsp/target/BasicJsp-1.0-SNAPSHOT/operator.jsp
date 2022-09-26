<%@ page import="com.drunkbaby.basicjsp.pojo.Site" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>JSP 运算符</title>
  </head>
  <body>
  <h3>.运算符</h3>

  <%
          Site site = new Site();
          site.setName("Drunkbaby's Home");
          site.setUrl("drunkbaby.github.io");
          session.setAttribute("site", site);
      %>
      欢迎来到${site.name}，博客网址是：${site.url}

      <h3>[]运算符</h3>
  <%
          List tutorials = new ArrayList();
          tutorials.add("Java");
          tutorials.add("Python");
          session.setAttribute("tutorials", tutorials);
          HashMap siteMap = new HashMap();
          siteMap.put("one", "Drunkbaby");
          siteMap.put("two", "silly baby");
          session.setAttribute("site", siteMap);
  %>
      tutorials 中的内容：${tutorials[0]}，${tutorials[1]}
      <br> siteMap 中的内容：${site.one}，${site.two}

       <h3>empty和条件运算符</h3>
    <!-- 当 cart 变量为空时，输出购物车为空，否则输出cart -->
    <%
        String cart = null;
    %>
    ${empty cart?"购物车为空":cart}

  </body>
</html>
