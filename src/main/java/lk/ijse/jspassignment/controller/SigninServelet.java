package lk.ijse.jspassignment.controller;


import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/signin")
public class SigninServelet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       String email = request.getParameter("emailInput");
       String password = request.getParameter("passwordInput");

       ServletContext context = getServletContext();
       BasicDataSource ds = (BasicDataSource) context.getAttribute("ds");

        try{
            Connection conn = ds.getConnection();
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM credentials WHERE email = ? AND password = ?");
                    ps.setString(1,email);
                    ps.setString(2,password);

                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        System.out.println("success");
                        response.sendRedirect(request.getContextPath() + "/signin.jsp");
                    }else{
                        response.sendRedirect(request.getContextPath() + "/signin.jsp?error=invalid");
                    }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=server");
        }
    }
}
