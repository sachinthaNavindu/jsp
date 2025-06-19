package lk.ijse.jspassignment.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.jspassignment.dao.ComplainDAO;
import lk.ijse.jspassignment.dto.ComplainDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/complainupdate")
public class ComplaintUpdateservlet extends HttpServlet {

    private ComplainDAO complainDAO;
    private String loggedinUserNic;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        complainDAO = new ComplainDAO(ds);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String complaintId = request.getParameter("complainid");
        ComplainDTO complainDTOList = complainDAO.getComplainById(complaintId);
        loggedinUserNic = complainDTOList.getNic();

        request.setAttribute("complaint", complainDTOList);
        request.getRequestDispatcher("complainupdate.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String complaintId = request.getParameter("complaintId");
        String complainCategory = request.getParameter("complaintCategory");
        String complainContent = request.getParameter("complaintDescription");

            ComplainDTO complainDTO = new ComplainDTO(complaintId,"","","",complainContent,"",complainCategory);

            boolean isUpdated = complainDAO.updateComplain(complainDTO);

            if (isUpdated) {
                List<ComplainDTO> complaints = complainDAO.getLogedInUserComplaints(loggedinUserNic);
                request.getSession().setAttribute("complaints", complaints);
                response.sendRedirect(request.getContextPath() + "/dashboardEmployee.jsp");
            }else{
                response.sendRedirect(request.getContextPath() + "/complainupdate?error=true");
            }

    }
}
