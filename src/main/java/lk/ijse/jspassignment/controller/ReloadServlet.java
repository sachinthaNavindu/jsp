package lk.ijse.jspassignment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.jspassignment.dao.ComplainDAO;
import lk.ijse.jspassignment.dao.ComplainSolutionDAO;
import lk.ijse.jspassignment.dao.QueryDAO;
import lk.ijse.jspassignment.dto.ComplainDTO;
import lk.ijse.jspassignment.dto.CustomeDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/reload")
public class ReloadServlet extends HttpServlet {

    private ComplainDAO complainDAO;
    private ComplainSolutionDAO complainSolutionDAO;
    private QueryDAO queryDAO;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        complainDAO = new ComplainDAO(ds);
        complainSolutionDAO = new ComplainSolutionDAO(ds);
        queryDAO = new QueryDAO(ds);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ComplainDTO> complaintsPending = complainDAO.getAllComplaints("pending");
        List<ComplainDTO> complaintsInProgress = complainDAO.getAllComplaints("In Progress");
        List<CustomeDTO> complaintsResolved = queryDAO.getAll();

        int pendingCompCount = complainDAO.getPendingComplainCount("pending");
        int inProgressCount = complainDAO.getPendingComplainCount("In Progress");
        int resolvedCount = complainDAO.getPendingComplainCount("resolved");

        request.getSession().setAttribute("pendingCompCount", pendingCompCount);
        request.getSession().setAttribute("inProgressCount", inProgressCount);
        request.getSession().setAttribute("resolvedCount", resolvedCount);
        request.getSession().setAttribute("complaintsPending", complaintsPending);
        request.getSession().setAttribute("complaintsInProgress", complaintsInProgress);
        request.getSession().setAttribute("complaintsResolved", complaintsResolved);

        request.getRequestDispatcher("/dashboardAdmin.jsp").forward(request, response);
    }
}
