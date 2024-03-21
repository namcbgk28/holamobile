/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Category;
import entity.Product;
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
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CategoryDAO;
import model.ProductDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "ProductManager", urlPatterns = {"/ProductManager"})
public class ProductManager extends HttpServlet {

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
            out.println("<title>Servlet ProductManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductManager at " + request.getContextPath() + "</h1>");
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
        //Check login
        HttpSession session = request.getSession();
        User user = ((User) session.getAttribute("account"));
        if (user == null) {
            response.sendRedirect("sign");
        } else if (user.getRoleID() != 1) {
            request.getRequestDispatcher("notfound.jsp").forward(request, response);
        } else {

            CategoryDAO cate = new CategoryDAO();
            ProductDAO pd = new ProductDAO();
            Vector<Category> vectorCate = cate.getAllData();
            String service = request.getParameter("service");
            request.setAttribute("dataCate", vectorCate);

            // Add product
            if (service.equals("addproduct")) {
                request.getRequestDispatcher("addproduct.jsp").forward(request, response);
            }

            //Update Product
            if (service.equals("updateproduct")) {
                int pid = Integer.parseInt(request.getParameter("id"));
                int cid = pd.getCategoryIdByProductId(pid);
                Product product = pd.getProductById(pid);
                request.setAttribute("product", product);
                request.setAttribute("cid", cid);
                request.getRequestDispatcher("updateproduct.jsp").forward(request, response);
            }

            //Delete Product
            if (service.equals("deleteproduct")) {
                try {
                    int pid = Integer.parseInt(request.getParameter("id"));
                    pd.delete(pid);
                    response.sendRedirect("adminpage");
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            if (service.equals("searchadmin")) {
//            System.out.println("hihi");
                //Get parameter
                String cid_raw = request.getParameter("cid");
                System.out.println("cid = " + cid_raw);
                String fromprice = request.getParameter("from");
                String toprice = request.getParameter("to");
                String sort = request.getParameter("sort");
                String page_raw = request.getParameter("page");
                String key = request.getParameter("key");
                int page;
                try {
                    page = Integer.parseInt(page_raw);
                } catch (NumberFormatException e) {
                    page = 1;
                }
                System.out.println(page);

                //Build string SQL
                String sql = "SELECT P.ProductID, P.Image,C.CategoryName,ProductName,UnitInStock,UnitPrice,Discount\n"
                        + "FROM Product P \n"
                        + "JOIN Category C ON P.CategoryID = C.CategoryID WHERE 1 = 1 ";

                //sql for count totalProduct
                String sql_count = "SELECT COUNT(*)\n"
                        + "FROM Product P \n"
                        + "JOIN Category C ON P.CategoryID = C.CategoryID WHERE 1 = 1 ";

                //cid
                int cid = 1;
                if (cid_raw != null && cid_raw != "") {
                    try {
                        cid = Integer.parseInt(cid_raw);
                    } catch (Exception e) {
                        System.out.println(e);
                    }

                    sql += " AND C.CategoryID =" + cid;
                    sql_count += " AND C.CategoryID =" + cid;
                }

                //fromprice
                if (fromprice != null && !"".equals(fromprice)) {
                    sql += " AND Unitprice >= " + fromprice;
                    sql_count += " AND Unitprice >= " + fromprice;
                }

                //toprice
                if (toprice != null && !"".equals(fromprice)) {
                    sql += " AND Unitprice <= " + toprice;
                    sql_count += " AND Unitprice <= " + toprice;
                }

                //key
                if (key != null && !"".equals(key)) {
                    int id = 0;
                    try {
                        id = Integer.parseInt(key);
                        sql += " AND ProductName LIKE '%" + key + "%' OR PRODUCTID = " + id;
                        sql_count += " AND ProductName LIKE '%" + key + "%' OR PRODUCTID = " + id;
                    } catch (NumberFormatException e) {
                        sql += " AND ProductName LIKE '%" + key + "%'";
                        sql_count += " AND ProductName LIKE '%" + key + "%'";
                    }
                }

                int totalProduct = 0;
                System.out.println(sql_count);
                ResultSet rs1 = pd.getData(sql_count);
                try {
                    if (rs1.next()) {
                        totalProduct = rs1.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Sort 
                if (sort == null || sort.equals("")) {
                    sort = "2";
                }
                sql += " ORDER BY ";
                if (sort.equals("0")) {
                    sql += " Unitprice ASC";
                } else if (sort.equals("1")) {
                    sql += " Unitprice DESC";
                } else if (sort.equals("2")) {
                    sql += " ProductID ASC ";
                } else {
                    sql += " ProductID DESC ";
                }

                //Paging
                int numberPage = 0;
                int numberPerPage = 12;
                if (totalProduct % numberPerPage == 0) {
                    numberPage = totalProduct / numberPerPage;
                } else {
                    numberPage = (totalProduct / numberPerPage) + 1;
                }
                int start = (page - 1) * numberPerPage;

                sql += " OFFSET " + start + " ROW FETCH NEXT " + numberPerPage + " ROWS ONLY";
                ResultSet rs = pd.getData(sql);
                System.out.println(sql);
                Category category = cate.getCategoryById(cid);
                request.setAttribute("page", page);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("rs", rs);
                request.setAttribute("sort", sort);
                double from = Double.parseDouble(fromprice);
                double to = Double.parseDouble(toprice);
                request.setAttribute("from", from);
                request.setAttribute("to", to);
                request.setAttribute("key", key);
                request.setAttribute("totalProduct", totalProduct);

                request.setAttribute("key", key);
                request.getRequestDispatcher("ProductManager.jsp").forward(request, response);

            }
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
        //Check login
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect("sign");
        } else {

            String service = request.getParameter("service");
            ProductDAO pd = new ProductDAO();
            CategoryDAO cate = new CategoryDAO();
            Vector<Category> vectorCate = cate.getAllData();

            // add product
            if (service.equals("addproduct")) {
                try {
                    int cid = Integer.parseInt(request.getParameter("cid"));
                    String name = request.getParameter("productname");
                    String description = request.getParameter("description");
                    int unitinstock = Integer.parseInt(request.getParameter("unitinstock"));
                    double unitprice = Double.parseDouble(request.getParameter("price"));
                    double discount = Double.parseDouble(request.getParameter("discount"));
                    int status = 0;
                    if (unitinstock > 0) {
                        status = 1;
                    }
                    int pid = pd.GetMaxId() + 1;
                    String image = "image/product/" + pid + "/" + request.getParameter("image");
                    Product newProduct = new Product(cid, name, description, unitprice, unitinstock, discount, image, status);
                    pd.addNewProduct(newProduct);
                    response.sendRedirect("adminpage");
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                System.out.println("ADDED");
            }

            // Update Product
            if (service.equals("updateproduct")) {
                int pid = Integer.parseInt(request.getParameter("id"));
                int cid = Integer.parseInt(request.getParameter("cid"));
                String name = request.getParameter("productname");
                String description = request.getParameter("description");
                int unitinstock = Integer.parseInt(request.getParameter("unitinstock"));
                double unitprice = Double.parseDouble(request.getParameter("price"));
                double discount = Double.parseDouble(request.getParameter("discount"));
                String image = "image/product/" + pid + "/" + request.getParameter("image");
                int status = 0;
                if (unitinstock > 0) {
                    status = 1;
                }
                Product newProduct = new Product(pid, cid, name, description, unitprice, unitinstock, discount, image, status);
                pd.update(newProduct, pid);
                response.sendRedirect("adminpage");
            }
        }
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
