package com.wlc.controller;

import com.wlc.dao.DAO;
import com.wlc.po.User;
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

/**
 * describe:
 *
 * @author 王立朝
 * @date 2019/10/25
 */
@WebServlet(name = "register",urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      req.setCharacterEncoding("UTF-8");
      resp.setCharacterEncoding("UTF-8");
      User user = new User();
       user.setName(req.getParameter("name"));
       user.setPassword(req.getParameter("password"));
        try {
            int result = new DAO().addUser(user);
            if(result>0){
                req.getRequestDispatcher("login.jsp").forward(req,resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error","注册失败！"+ e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req,resp);
        }


    }
}
