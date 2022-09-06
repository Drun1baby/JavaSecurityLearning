package tomcatShell.Listener;

import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.ContextConfig;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;
import java.util.EventListener;

// 测试 Listener
@WebListener("/listener")
public class ListenerTest implements ServletRequestListener {

    public ListenerTest(){
    }

    @Override
    public void requestDestroyed(ServletRequestEvent sre) {

    }

    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        System.out.println("Listener 初始化成功");
    }
}
