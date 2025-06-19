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
import lk.ijse.jspassignment.dto.ComplainSolutionDTO;
import lk.ijse.jspassignment.dto.CustomeDTO;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.util.List;

@WebServlet("/admincomplaintviewer")
public class AdminComplaintViewerServlet extends HttpServlet {
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
        String complaintId = request.getParameter("complaintid");
        ComplainDTO rqstdcomplaint = complainDAO.getComplainById(complaintId);

        request.setAttribute("complaint", rqstdcomplaint);
        request.getRequestDispatcher("admincomplaintViewer.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");


        if ("solved".equals(action)){

            ComplainSolutionDTO complaintSolutionDTO = new ComplainSolutionDTO(request.getParameter("complaintId"),request.getParameter("adminComments"));
            String status = "Resolved";

            boolean isComplaintSolutionSaved=false;
            boolean isComplaintSolutionUpdated=false;

            boolean isAlreadyHaveAComment = complainSolutionDAO.checkForCommentById(request.getParameter("complaintId"));


            if (isAlreadyHaveAComment){
                isComplaintSolutionUpdated = complainSolutionDAO.updateAdminComment(request.getParameter("complaintId"),request.getParameter("adminComments"));
            }else{
                 isComplaintSolutionSaved = complainSolutionDAO.saveAdminComment(complaintSolutionDTO);
            }


            if (isComplaintSolutionSaved || isComplaintSolutionUpdated) {
                boolean updateStatus = complainDAO.updateStatus(status,request.getParameter("complaintId"));

                if (updateStatus) {
                    response.sendRedirect(request.getContextPath() + "/reload");
                }
            }else {
                response.sendRedirect(request.getContextPath() + "/reload");
            }

        }else{
            ComplainSolutionDTO complaintSolutionDTO = new ComplainSolutionDTO(request.getParameter("complaintId"),request.getParameter("adminComments"));
            String status = "In Progress";

            boolean isComplaintSolutionSaved=false;
            boolean isComplaintSolutionUpdated=false;

            boolean isAlreadyHaveAComment = complainSolutionDAO.checkForCommentById(request.getParameter("complaintId"));


            if (isAlreadyHaveAComment){
                isComplaintSolutionUpdated = complainSolutionDAO.updateAdminComment(request.getParameter("complaintId"),request.getParameter("adminComments"));
            }else{
                isComplaintSolutionSaved = complainSolutionDAO.saveAdminComment(complaintSolutionDTO);
            }


            if (isComplaintSolutionSaved || isComplaintSolutionUpdated) {
                boolean updateStatus = complainDAO.updateStatus(status,request.getParameter("complaintId"));

                if (updateStatus) {
                    response.sendRedirect(request.getContextPath() + "/reload");
                }
            }else {
                response.sendRedirect(request.getContextPath() + "/reload");            }
        }
    }
}
