package lk.ijse.jspassignment.db;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

@WebListener
public class Datasource implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource ds = new BasicDataSource();
        ds.setDriverClassName("com.mysql.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost:3306/complain");
        ds.setUsername("root");
        ds.setPassword("Ijse@1234");
        ds.setInitialSize(50);
        ds.setMaxTotal(50);

        ServletContext context = sce.getServletContext();
        context.setAttribute("ds", ds);
    }
}
