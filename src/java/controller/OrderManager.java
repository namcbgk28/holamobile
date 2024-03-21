/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Shipper;
import entity.Status;
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
import model.CartDAO;
import model.OrderDAO;
import model.ProductDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "OrderManager", urlPatterns = {"/OrderManager"})
public class OrderManager extends HttpServlet {

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
            out.println("<title>Servlet OrderManager</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderManager at " + request.getContextPath() + "</h1>");
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
        if (user == null) {
            response.sendRedirect("sign");
        } else if (user.getRoleID() != 1) {
            request.getRequestDispatcher("notfound.jsp").forward(request, response);
        } else {
            String service = request.getParameter("service");
            int uid = ((User) session.getAttribute("account")).getUserID();
            ProductDAO pd = new ProductDAO();

            if (service == null) {
                service = "listOrder";
            }
            //=======================LIST ORDER=========================
            if (service.equals("listOrder")) {
                //Get data status
                ResultSet rsStatus = pd.getData("SELECT * FROM [Status]");
                Vector<Status> vectorStatus = new Vector<>();
                try {
                    while (rsStatus.next()) {
                        Status s = new Status(rsStatus.getInt("StatusID"), rsStatus.getString("Status"));
                        vectorStatus.add(s);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Get data shipper
                ResultSet rsShipper = pd.getData("SELECT * FROM [Shipper]");
                Vector<Shipper> vectorShipper = new Vector<>();
                try {
                    while (rsShipper.next()) {
                        Shipper sh = new Shipper(rsShipper.getInt("ShipperID"), rsShipper.getString("CompanyName"), rsShipper.getString("Phone"));
                        vectorShipper.add(sh);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Get parameter
                String sort = request.getParameter("sort");
                String key = request.getParameter("key");
                String stt = request.getParameter("stt");

                //Build string SQL
                String sql = "select *,o.Phone as DeliverPhone from [Order] o\n"
                        + "join [User] u on o.UserID = u.UserID\n"
                        + "join [Status] s on s.StatusID = o.StatusID\n"
                        + "where 1 = 1 ";

                //sql for count total
                String sql_count = "select count(*) from [Order] o\n"
                        + "join [User] u on o.UserID = u.UserID\n"
                        + "join [Status] s on s.StatusID = o.StatusID\n"
                        + "where 1 = 1 ";

                if (stt == null) {
                    stt = "0";
                }
                if (!stt.equals("0")) {
                    sql += " AND o.StatusID =" + stt;
                    sql_count += " AND o.StatusID =" + stt;
                }

                if (key != null && !"".equals(key)) {
                    sql += " AND (DELIVERADDRESS LIKE N'%" + key + "%' OR FULLNAME LIKE N'%" + key + "%') ";
                    sql_count += " AND (DELIVERADDRESS LIKE N'%" + key + "%' OR FULLNAME LIKE N'%" + key + "%') ";
                }

                //Sort 
                if (sort == null || sort.equals("")) {
                    sort = "0";
                }
                sql += " ORDER BY ";
                if (sort.equals("0")) {
                    sql += " ORDERDATE ASC";
                } else if (sort.equals("1")) {
                    sql += " FULLNAME ASC";
                } else if (sort.equals("2")) {
                    sql += " TotalPrice ASC ";
                } else {
                    sql += " ShipVia ASC ";
                }

                //Get total
                System.out.println(sql_count);
                ResultSet rsTotal = pd.getData(sql_count);
                int totalOrder = 0;
                try {
                    if (rsTotal.next()) {
                        totalOrder = rsTotal.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Paging
                int numberPerPage = 6;
                int numberPage;

                if (totalOrder % numberPerPage == 0) {
                    numberPage = totalOrder / numberPerPage;
                } else {
                    numberPage = (totalOrder / numberPerPage) + 1;
                }
                String page_raw = request.getParameter("page");
                int page;
                try {
                    page = Integer.parseInt(page_raw);
                } catch (NumberFormatException e) {
                    page = 1;
                }
                int start = (page - 1) * numberPerPage;
                int end = 0;
                if (start + numberPerPage > totalOrder) {
                    end = totalOrder;
                } else {
                    end = start + numberPerPage;
                }
                sql += " OFFSET " + start + " ROW FETCH NEXT " + numberPerPage + " ROWS ONLY";

                // Get all data of user
                System.out.println(sql);
                ResultSet rs = pd.getData(sql);

                request.setAttribute("end", end);
                request.setAttribute("vectorShipper", vectorShipper);
                request.setAttribute("vectorStatus", vectorStatus);
                request.setAttribute("totalOrder", totalOrder);
                request.setAttribute("rs", rs);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("page", page);
                request.setAttribute("start", start);
                request.setAttribute("sort", sort);
                request.setAttribute("key", key);
                request.setAttribute("stt", stt);
                request.getRequestDispatcher("OrderManager.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect("sign");
        } else {
            String service = request.getParameter("service");
            User user = (User) session.getAttribute("account");
            OrderDAO od = new OrderDAO();
            CartDAO cd = new CartDAO();
            ProductDAO pd = new ProductDAO();
            int uid = ((User) session.getAttribute("account")).getUserID();

            if (service.equals("viewdetail")) {
                String oid = request.getParameter("oid");

                String sql = "select * from [Order] o\n"
                        + "join [Status] s on o.StatusID = s.StatusID\n"
                        + "join [User] u on o.UserID = u.UserID\n"
                        + "where OrderID =" + oid;
//            System.out.println("oid : " + oid);
//            System.out.println(sql);
                ResultSet rs = od.getData(sql);
                request.setAttribute("rs", rs);

                ResultSet rsDetail = od.getData("select *,od.UnitPrice as OrderPrice from OrderDetail od \n"
                        + "join Product p on p.ProductID = od.ProductID\n"
                        + "where OrderID =  " + oid);
                request.setAttribute("rsDetail", rsDetail);
                request.setAttribute("oid", oid);
                request.getRequestDispatcher("orderdetailadmin.jsp").forward(request, response);
            }

            //Update shipped date and status
            if (service.equals("update")) {
                System.out.println("update order");
                int orderID = Integer.parseInt(request.getParameter("oid"));
                System.out.println("oid=" + orderID);
                String shipid_raw = request.getParameter("update-shipper");
                System.out.println("shipid" + shipid_raw);
                String statusid = request.getParameter("update-statusid");
                System.out.println("hihi" + statusid);
                if (shipid_raw != null) {
                    int shipid = Integer.parseInt(shipid_raw);
                    System.out.println("shipid" + shipid);
                    if (shipid != 0) {
                        od.updateStatusToProcess(orderID, shipid);
                    }
                }

                if ("3".equals(statusid)) {
                    System.out.println("hihi");
                    od.updateShippedDate(orderID);
                }
                response.sendRedirect("adminpage?service=ordermanager");
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
