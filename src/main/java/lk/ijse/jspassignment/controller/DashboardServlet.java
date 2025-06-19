package lk.ijse.jspassignment.controller;

import jakarta.servlet.ServletConfig;
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

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private ComplainDAO complainDAO;
    private String type;
    private String complaintId;

    public void init() throws ServletException {
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        complainDAO = new ComplainDAO(ds);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         type = request.getParameter("type");
         complaintId = request.getParameter("complainid");
         String userNic =request.getParameter("userNic");

        if (type.equals("reload")){
            List<ComplainDTO> complaints = complainDAO.getLogedInUserComplaints(userNic);
            request.getSession().setAttribute("complaints", complaints);
            response.sendRedirect(request.getContextPath() + "/dashboardEmployee.jsp");
        }else {
            boolean deleteDone = delete(complaintId,type);

            if (deleteDone) {
                List<ComplainDTO> complaints = complainDAO.getLogedInUserComplaints(userNic);

                request.getSession().setAttribute("complaints", complaints);
                response.sendRedirect(request.getContextPath() + "/dashboardEmployee.jsp");
            }else{
                List<ComplainDTO> complaints = complainDAO.getLogedInUserComplaints(userNic);
                request.getSession().setAttribute("complaints", complaints);
                response.sendRedirect(request.getContextPath() + "/dashboardEmployee.jsp");
            }
        }
    }

    public boolean delete(String complainid,String type) throws ServletException, IOException {
        return complainDAO.deleteComplain(complainid);
    }
}
