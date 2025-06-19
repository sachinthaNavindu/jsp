package lk.ijse.jspassignment.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.jspassignment.dao.*;
import lk.ijse.jspassignment.dto.ComplainDTO;
import lk.ijse.jspassignment.dto.CredentialDTO;
import lk.ijse.jspassignment.dto.CustomeDTO;
import org.apache.commons.dbcp2.BasicDataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/signin")
public class SigninServelet extends HttpServlet {

    private CredentialDAO credentialDAO;
    private ComplainDAO complainDAO;
    private EmployeeDAO employeeDAO;
    private QueryDAO queryDAO;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        credentialDAO = new CredentialDAO(ds);
        complainDAO = new ComplainDAO(ds);
        employeeDAO = new EmployeeDAO(ds);
        queryDAO = new QueryDAO(ds);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       CredentialDTO credentialDTO = new CredentialDTO("null","null",request.getParameter("emailInput"),request.getParameter("passwordInput"),"null");

       boolean checkCredentials = credentialDAO.checkPassword(credentialDTO);
       String nic = credentialDAO.getNic(request.getParameter("emailInput"));
       String userJobRole = employeeDAO.getJobRole(nic);


        if (checkCredentials) {

            CredentialDTO loggedInUser = credentialDAO.findByEmail(request.getParameter("emailInput"));

            if (loggedInUser != null) {

                List<ComplainDTO> complaints = complainDAO.getLogedInUserComplaints(loggedInUser.getNic());

                if (userJobRole.equals("admin")) {

                    List<ComplainDTO> complaintsPending = complainDAO.getAllComplaints("pending");
                    List<ComplainDTO> complaintsInProgress = complainDAO.getAllComplaints("In Progress");
                    List<CustomeDTO> complaintsResolved = queryDAO.getAll();

                    int pendingCompCount = complainDAO.getPendingComplainCount("pending");
                    int inProgressCount = complainDAO.getPendingComplainCount("in Progress");
                    int resolvedCount = complainDAO.getPendingComplainCount("resolved");

                    request.getSession().setAttribute("pendingCompCount", pendingCompCount);
                    request.getSession().setAttribute("inProgressCount", inProgressCount);
                    request.getSession().setAttribute("resolvedCount", resolvedCount);
                    request.getSession().setAttribute("NIC",loggedInUser.getNic());
                    request.getSession().setAttribute("name",loggedInUser.getUsername());

                    request.getSession().setAttribute("complaintsPending", complaintsPending);
                    request.getSession().setAttribute("complaintsInProgress", complaintsInProgress);
                    request.getSession().setAttribute("complaintsResolved", complaintsResolved);

                    response.sendRedirect(request.getContextPath() + "/dashboardAdmin.jsp");

                }else {

                    request.getSession().setAttribute("NIC",loggedInUser.getNic());
                    request.getSession().setAttribute("name",loggedInUser.getUsername());
                    request.getSession().setAttribute("complaints",complaints);

                    response.sendRedirect(request.getContextPath() + "/dashboardEmployee.jsp");
                }

            }else {
                response.sendRedirect(request.getContextPath() + "/signin.jsp?error=server");
            }
        }else {
            response.sendRedirect(request.getContextPath() + "/signin.jsp?error=invalid");
        }

    }
}
