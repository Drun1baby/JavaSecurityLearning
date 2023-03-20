package com.wlc.dao;

import com.wlc.po.User;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;


import java.sql.*;
import java.util.HashSet;
import java.util.Set;

/**
 * describe:
 *
 * @author 王立朝
 * @date 2019/10/25
 */
public class DAO {

    public DAO() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() throws SQLException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/shiro02?characterEncoding=UTF-8", "scott", "tiger");
        return connection;
    }

    /**
     * 注册用户
     **/
    public int addUser(User user) {
        int result = 0;
        try {
            Connection connection = getConnection();
            String sql = "insert into user(id,name,password,salt) values(null,?,?,?) ";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            String password = user.getPassword();
            //加盐次数
            int time = 2;
            //盐
            String salt = new SecureRandomNumberGenerator().nextBytes().toString();
            //加盐加密后的密码
            String encodePassword = new SimpleHash("md5", password, salt, 2).toString();
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, encodePassword);
            preparedStatement.setString(3,salt);
            result = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * 获取用户信息，包括数据库中的密码，盐
     **/
    public User getUser(String userName) {
        User user = new User();
        try {
            Connection connection = getConnection();
            String sql = "select * from user where name=?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                user.setName(resultSet.getString("name"));
                user.setPassword(resultSet.getString("password"));
                user.setSalt(resultSet.getString("salt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public ResultSet common(Connection connection, String sql, String userName) {
        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, userName);
            resultSet = preparedStatement.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    /**
     * 根据用户用获取角色(在DatabaseRealm 中的 授权方法中需要放入到授权对象中，
     * 需要的是Set<String> 类型的东西</String>)
     **/
    public Set<String> getRoles(String userName) {
        Set<String> setRoles = new HashSet<>();
        try {
            Connection connection = getConnection();
            String sql = "select r.name from user u left join user_role ur on ur.uid=u.id " +
                    "left join role r on ur.rid = r.id where u.name =?";
            ResultSet resultSet = common(connection, sql, userName);
            while (resultSet.next()) {
                setRoles.add(resultSet.getString(1));
            }

            /*while (resultSet.next()){
                setRoles.add(resultSet.getString(1));
            }*/

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return setRoles;
    }


    /**
     * 根据角色获取角色具有的权限信息
     **/
    public Set<String> getPermits(String userName) {
        Set<String> permitSet = new HashSet<>();
        try {
            Connection connection = getConnection();
            String sql = "select p.name from user u left join user_role ur on ur.uid=u.id left " +
                    "join role r on ur.rid = r.id left " +
                    " join role_permission rp on rp.rid = r.id left" +
                    " join permission p on rp.pid = p.id where u.name=?"
                   /* +"and p.name !=null"*/
                    ;
            ResultSet resultSet = common(connection, sql, userName);
            while (resultSet.next()) {
                permitSet.add(resultSet.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return permitSet;
    }

    public static void main(String[] args) {
        DAO dao = new DAO();
        Set<String> roleSet = dao.getRoles("张三");
        System.out.println("角色为： " + roleSet.size());
        Set<String> permitsSet = dao.getPermits("张三");
        System.out.println("权限为： " + permitsSet.size());
    }

}
