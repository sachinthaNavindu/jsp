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
import java.util.List;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    private CredentialDAO credentialDAO;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        credentialDAO = new CredentialDAO(ds);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<String> availableNicList = credentialDAO.getAvailableNic();

        req.setAttribute("nicList",availableNicList);
        req.getRequestDispatcher("signup.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("nicSelect") == null || request.getParameter("usernameInput") == null || request.getParameter("passwordInput") == null || request.getParameter("gmailInput") == null) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=invalid");
        }else {
            String password = request.getParameter("passwordInput");
            String confirmPassword = request.getParameter("confirmPasswordInput");

            if (!(password.equals(confirmPassword))) {
                response.sendRedirect(request.getContextPath() + "/signup.jsp?error=invalid");
            }else{
                CredentialDTO credentialDTO = new CredentialDTO(request.getParameter("usernameInput"),request.getParameter("nicSelect"),request.getParameter("gmailInput"),password,"");
                boolean isSaved = credentialDAO.saveNewUser(credentialDTO);

                if (isSaved) {
                    response.sendRedirect(request.getContextPath() + "/signin.jsp");
                }else{
                    response.sendRedirect(request.getContextPath() + "/signup.jsp?error=invalid");
                }
            }
        }
    }
}
