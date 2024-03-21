/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CategoryDAO;
import model.OrderDAO;
import model.ProductDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "MartketingPage", urlPatterns = {"/marketingpage"})
public class MartketingPage extends HttpServlet {

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
            out.println("<title>Servlet MartketingPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MartketingPage at " + request.getContextPath() + "</h1>");
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
        User user = ((User) session.getAttribute("account"));
//        if (user == null) {
//            response.sendRedirect("sign");
//        } else if (user.getRoleID() != 1) {
//            request.getRequestDispatcher("notfound.jsp").forward(request, response);
//        } else {
        ProductDAO pd = new ProductDAO();
        CategoryDAO cd = new CategoryDAO();
        OrderDAO od = new OrderDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "productmanager";
        }
        if (service.equals("productmanager")) {
            //Get total Product
            ResultSet rs1 = pd.getData("SELECT COUNT(*) FROM Product");
            int totalProduct = 0;
            try {
                if (rs1.next()) {
                    totalProduct = rs1.getInt(1);
                }
            } catch (SQLException ex) {
                Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
            }

            //Paging
            int numberPerPage = 12;
            int numberPage;

            if (totalProduct % numberPerPage == 0) {
                numberPage = totalProduct / numberPerPage;
            } else {
                numberPage = (totalProduct / numberPerPage) + 1;
            }
            String page_raw = request.getParameter("page");
            int page;
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
                page = 1;
            }
            int start = (page - 1) * numberPerPage;

            // Get all data of product
            ResultSet rs = pd.getData("SELECT P.ProductID, P.Image,C.CategoryName,ProductName,UnitInStock,UnitPrice,Discount\n"
                    + "FROM Product P \n"
                    + "JOIN Category C ON P.CategoryID = C.CategoryID\n"
                    + "ORDER BY ProductID\n"
                    + "OFFSET " + start + " ROW FETCH NEXT " + numberPerPage + " ROWS ONLY");

            request.setAttribute("totalProduct", totalProduct);
            request.setAttribute("rs", rs);
            request.setAttribute("numberPage", numberPage);
            request.setAttribute("page", page);
            request.setAttribute("start", start);
            request.getRequestDispatcher("ProductManager.jsp").forward(request, response);
        }
//        }
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
        processRequest(request, response);
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
