import java.sql.*;

public class Test {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbc_url = "jdbc:mysql://127.0.0.1:3309/test?characterEncoding=UTF-8&serverTimezone=Asia/Shanghai" +
                "&autoDeserialize=true" +
                "&queryInterceptors=com.mysql.cj.jdbc.interceptors.ServerStatusDiffInterceptor";
        Connection con = DriverManager.getConnection(jdbc_url, "root", "123123");
    }
}