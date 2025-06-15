package lk.ijse.jspassignment.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.jspassignment.dao.CredentialDAO;
import lk.ijse.jspassignment.dto.CredentialDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;


@WebServlet("/signin")
public class SigninServelet extends HttpServlet {

    private CredentialDAO credentialDAO;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        credentialDAO = new CredentialDAO(ds);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       CredentialDTO credentialDTO = new CredentialDTO("null","null",request.getParameter("emailInput"),request.getParameter("passwordInput"),"null");

       boolean checkCredentials = credentialDAO.checkPassword(credentialDTO);

        if (checkCredentials) {
            CredentialDTO loggedInUser = credentialDAO.findByEmail(request.getParameter("emailInput"));
            if (loggedInUser != null) {

                System.out.println("if eka wada");

                request.getSession().setAttribute("NIC",loggedInUser.getNic());
                request.getSession().setAttribute("name",loggedInUser.getUsername());
//                request.setAttribute("jobrole",loggedInUser.getJobRole());

                response.sendRedirect(request.getContextPath() + "/dashboardEmployee.jsp");
            }else {
                response.sendRedirect(request.getContextPath() + "/signin.jsp?error=server");
            }
        }else {
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=invalid");
        }

    }
}
