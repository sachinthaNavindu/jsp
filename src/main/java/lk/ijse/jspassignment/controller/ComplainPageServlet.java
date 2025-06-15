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

@WebServlet("/complain")
public class ComplainPageServlet extends HttpServlet {

    private ComplainDAO complainDAO;

    public void init(){
        BasicDataSource ds = (BasicDataSource) getServletContext().getAttribute("ds");
        complainDAO = new ComplainDAO(ds);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nextComplainId = complainDAO.getNextComplainId();
        req.setAttribute("nextComplainId", nextComplainId);
        req.getRequestDispatcher("complainPage.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nic = request.getParameter("nicNumber");
        String complaintId = request.getParameter("complaintId");
        String date = request.getParameter("complaintDate");
        String time = request.getParameter("complaintTime");
        String complaintCategory = request.getParameter("complaintCategory");
        String complaintContext = request.getParameter("complaintDescription");

        ComplainDTO complainDTO = new ComplainDTO(complaintId,nic,date,time,complaintContext,"pending",complaintCategory);

        try{
            boolean isSave = complainDAO.   saveComplaint(complainDTO);

            if (isSave){
                response.sendRedirect(request.getContextPath() + "/complain?success=true");
            }else {
                response.sendRedirect(request.getContextPath() + "/complain?error=true");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
