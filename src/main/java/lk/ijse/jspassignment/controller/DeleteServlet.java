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

@WebServlet("/delete")
public class DeleteServlet extends HttpServlet {

    private ComplainDAO complainDAO;
    private ComplainSolutionDAO complainSolutionDAO;
    private QueryDAO queryDAO;

    public void init(){
        BasicDataSource ds = (BasicDataSource)getServletContext().getAttribute("ds");
        complainDAO = new ComplainDAO(ds);
        complainSolutionDAO = new ComplainSolutionDAO(ds);
        queryDAO = new QueryDAO(ds);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("complainid");

        boolean isDeleted = complainSolutionDAO.delete(id);

        if (isDeleted){
            complainDAO.deleteComplain(id);
        }

        response.sendRedirect(request.getContextPath() + "/reload");
    }
}
