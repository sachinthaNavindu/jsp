package lk.ijse.jspassignment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.jspassignment.dao.CredentialDAO;
import lk.ijse.jspassignment.dao.EmployeeDAO;
import lk.ijse.jspassignment.dto.EmployeeDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee")
public class EmployeeManagementServlet extends HttpServlet {

    private EmployeeDAO employeeDAO;
    private CredentialDAO credentialDAO;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        employeeDAO = new EmployeeDAO(ds);
        credentialDAO = new CredentialDAO(ds);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<EmployeeDTO> employeeList = employeeDAO.getAllEmployee();

        String loggedInUser = request.getParameter("username");
        System.out.println(loggedInUser);

        request.getSession().setAttribute("loggedInUser", loggedInUser);
        request.setAttribute("employeeList", employeeList);
        request.getRequestDispatcher("/employeemanagement.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String type = request.getParameter("type");
        EmployeeDTO employeeDTO = new EmployeeDTO(request.getParameter("nic"), request.getParameter("name"), request.getParameter("address"), request.getParameter("contact"), request.getParameter("role"));

        if (type.equals("save")) {
            boolean isSaved = employeeDAO.saveEmployee(employeeDTO);

            if (isSaved) {
                response.sendRedirect(request.getContextPath() + "/employee?username=" + request.getParameter("username"));
            }

        } else if (type.equals("update")) {
            boolean isUpdated = employeeDAO.update(employeeDTO);

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/employee");
            }
        } else if (type.equals("delete")) {

//            boolean credentialDelete = credentialDAO.delete(request.getParameter("deleteNic"));

//            if (credentialDelete) {
                boolean isDeleted = employeeDAO.delete(request.getParameter("deleteNic"));
                if (isDeleted) {
                    response.sendRedirect(request.getContextPath() + "/employee");
                }
//            }
        }
    }
}
