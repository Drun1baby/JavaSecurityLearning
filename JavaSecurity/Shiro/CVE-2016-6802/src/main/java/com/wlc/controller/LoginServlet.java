package com.wlc.controller;

import com.wlc.realm.DatabaseRealm;
import com.wlc.realm.SubjectAuthorizationUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

/**
 * describe:
 *
 * @author 王立朝
 * @date 2019/10/25
 */
@WebServlet(name = "loginServlet",urlPatterns = "/login")
public class LoginServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     String name = req.getParameter("name");
     String password = req.getParameter("password");
     //获取到当前对象
     Subject subject = SecurityUtils.getSubject();
        System.out.println("判断到底是啥---》" + subject.isAuthenticated());
     if(subject.isAuthenticated()){
         subject.logout();
     }
        UsernamePasswordToken token = new UsernamePasswordToken(name,password);
        try {
            subject.login(token);
            Session session = subject.getSession();
            session.setAttribute("subject",subject);
            resp.sendRedirect("index.jsp");

            Collection<String> roleList = SubjectAuthorizationUtil.getAuthorizationRoles();
            System.out.println("角色列表为： " + roleList);
            session.setAttribute("roleList",roleList);
            Collection<String> permList = SubjectAuthorizationUtil.getAuthorizationPerms();
            System.out.println("权限列表为： " + permList);
            session.setAttribute("permList",permList);

        } catch (AuthenticationException e) {
            e.printStackTrace();
            req.setAttribute("error","验证失败");
            req.getRequestDispatcher("login.jsp").forward(req,resp);
        }
    }
}
