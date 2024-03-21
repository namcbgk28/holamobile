/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.CategoryDAO;
import model.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.util.Vector;
import entity.Category;
import entity.Product;
import entity.User;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        CategoryDAO cate = new CategoryDAO();
        ProductDAO pd = new ProductDAO();
        CategoryDAO cd = new CategoryDAO();
        Vector<Category> vectorCate = cate.getAllData();
        String service = request.getParameter("service");
        boolean show = Boolean.parseBoolean(request.getParameter("show"));
        if (service == null) {
            service = "home";
        }
        if (service.equals("home")) {
            // data Xiaomi
            Vector<Product> vector1 = pd.getProduct("SELECT TOP 8 * FROM PRODUCT WHERE CATEGORYID = 1");
            // data Sumsung
            Vector<Product> vector2 = pd.getProduct("SELECT TOP 8 * FROM PRODUCT WHERE CATEGORYID = 2");
            //data OPPo
            Vector<Product> vector3 = pd.getProduct("SELECT TOP 8 * FROM PRODUCT WHERE CATEGORYID = 3");

            request.setAttribute("dataCate", vectorCate);
            request.setAttribute("data1", vector1);
            request.setAttribute("data2", vector2);
            request.setAttribute("data3", vector3);
            request.setAttribute("show", show);
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
        if (service.equals("searchhome")) {
//            System.out.println("hihi");
            String key = request.getParameter("key");
            ResultSet rs = pd.getData("SELECT * FROM PRODUCT WHERE ProductName Like '%" + key + "%'");
            request.setAttribute("dataCate", vectorCate);
            request.setAttribute("rs", rs);
            request.setAttribute("key", key);
            request.getRequestDispatcher("search.jsp").forward(request, response);
        }
        if (service.equals("displayproduct")) {
            String ms = request.getParameter("ms");
            if (ms != null) {
                request.setAttribute("ms", ms);
            }
            int pid = Integer.parseInt(request.getParameter("pid"));
            Category category = cd.getCategoryById(pd.getCategoryIdByProductId(pid));
            Product product = pd.getProductById(pid);
            Vector<Product> sameProduct = pd.getProduct("select TOP 4 * from Product\n"
                    + "WHERE ProductID != " + pid + " AND CategoryID = " + pd.getCategoryIdByProductId(pid)
                    + "\n"
                    + "ORDER BY ProductID DESC\n");

            request.setAttribute("sameProduct", sameProduct);
            request.setAttribute("category", category);
            request.setAttribute("pd", pd);
            request.setAttribute("pro", product);
            request.getRequestDispatcher("product.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
