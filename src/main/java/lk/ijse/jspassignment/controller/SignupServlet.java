package lk.ijse.jspassignment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.jspassignment.dao.SignupDAO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private SignupDAO signupDAO;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        signupDAO = new SignupDAO(ds);

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("do get wada");
        List<String> availableNicList = signupDAO.getAvailableNic();
        System.out.println("availableNicList: " + availableNicList);
        req.setAttribute("nicList",availableNicList);
        req.getRequestDispatcher("/signup.jsp").forward(req, resp);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
