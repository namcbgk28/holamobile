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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.Category;
import entity.Product;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "ProductController", urlPatterns = {"/productcontroller"})
public class ProductController extends HttpServlet {

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
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
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
        Vector<Category> vectorCate = cate.getAllData();
        String service = request.getParameter("service");
        request.setAttribute("dataCate", vectorCate);

        //Show all product for user
        if (service.equals("showproduct")) {
            //Get parameter
            int cid = Integer.parseInt(request.getParameter("cid"));
            double max = 0;
            ResultSet maxPrice = pd.getData("SELECT MAX(UnitPrice)\n"
                    + "FROM Product\n"
                    + "WHERE CategoryID = "+cid);
            try {
                if(maxPrice.next()){
                    max = maxPrice.getDouble(1);
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
            String page_raw = request.getParameter("page");
            int page;
            try {
                page = Integer.parseInt(page_raw);
            } catch (NumberFormatException e) {
                page = 1;
            }

            //Build string SQL
            String sql = "SELECT *\n"
                    + "FROM Product P\n"
                    + "JOIN Category C ON P.CategoryID = C.CategoryID\n"
                    + "WHere C.CategoryID = " + cid + "\n"
                    + "ORDER BY UnitPrice ASC\n";

            String sql_count = "SELECT count(*) as totalProduct FROM "
                    + "Product WHERE CategoryID = " + cid;//sql for count totalProduct
            int totalProduct = 0;
            ResultSet rs1 = pd.getData(sql_count);
            try {
                if (rs1.next()) {
                    totalProduct = rs1.getInt("totalProduct");
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
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
            System.out.println(sql);
            System.out.println(sql_count);
            ResultSet rs = pd.getData(sql);
            Category c = cate.getCategoryById(cid);
            request.setAttribute("max", max);
            request.setAttribute("cate", c);
            request.setAttribute("page", page);
            request.setAttribute("cid", cid);
            request.setAttribute("numberPage", numberPage);
            request.setAttribute("rs", rs);
//            request.setAttribute("data", vector);
            request.setAttribute("dataCate", vectorCate);
            request.getRequestDispatcher("listallproduct.jsp").forward(request, response);
        }

        //Search product
        if (service.equals("listProduct")) {
//            System.out.println("hihi");
            //Get parameter
            String cid_raw = request.getParameter("cid");
            System.out.println("cid = " + cid_raw);
            double max = 0;
            ResultSet maxPrice = pd.getData("SELECT MAX(UnitPrice)\n"
                    + "FROM Product\n"
                    + "WHERE CategoryID = "+cid_raw);
            try {
                if(maxPrice.next()){
                    max = maxPrice.getDouble(1);
                }
            } catch (SQLException ex) {
                Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
            }
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
                } catch (NumberFormatException e) {
                    System.out.println(e);
                }

                sql += " AND C.CategoryID =" + cid;
                sql_count += " AND C.CategoryID =" + cid;
            }

            //fromprice
            if (fromprice != null && !"".equals(fromprice)) {
                sql += " AND UnitPrice*(1-Discount/100) >= " + fromprice;
                sql_count += " AND UnitPrice*(1-Discount/100) >= " + fromprice;
            }

            //toprice
            if (toprice != null && !"".equals(fromprice)) {
                sql += " AND UnitPrice*(1-Discount/100) <= " + toprice;
                sql_count += " AND UnitPrice*(1-Discount/100) <= " + toprice;
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
                sort = "0";
            }
            sql += " ORDER BY ";
            if (sort.equals("0")) {
                sql += " Unitprice ASC";
            } else if (sort.equals("1")) {
                sql += " Unitprice DESC";
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
            request.setAttribute("max", max);
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
//                Vector<Product> vector = pd.getProduct(sql);
            request.setAttribute("cid", cid);
            request.setAttribute("dataCate", vectorCate);
            request.setAttribute("cate", category);
            request.getRequestDispatcher("listallproduct.jsp").forward(request, response);
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
