/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Cart;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
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
@WebServlet(name = "OrderController", urlPatterns = {"/ordercontroller"})
public class OrderController extends HttpServlet {

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
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
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
    public String checkBoxList[];

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("account") == null) {
            response.sendRedirect("sign");
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
                request.getRequestDispatcher("OrderManager.jsp").forward(request, response);
            }

            //===================CHECK OUT=========================
            if (service.equals("checkout")) {
                System.out.println("checkout");
                System.out.println("Order controller");
                //Get checked box
                checkBoxList = request.getParameterValues("option-checkout");
                for (String string : checkBoxList) {
                    System.out.println(string);
                }
                System.out.println("hihi");
                double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));

                //set attribute
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("checkBoxList", checkBoxList);
                request.setAttribute("service", service);

//                System.out.println("hehe");
                //forward
                request.getRequestDispatcher("bill.jsp").forward(request, response);
            }

            //====================BUY NOW=========================
            if (service.equals("buynow")) {
                String pid_raw = request.getParameter("pid");
                int pid = Integer.parseInt(pid_raw);
                Product product = pd.getProductById(pid);
                int quantity_buynow = Integer.parseInt(request.getParameter("quantity-buy"));
                double totalPrice = product.getUnitPrice() * (1 - product.getDiscount() / 100) * quantity_buynow;
                Cart cart = (Cart) session.getAttribute(pid_raw);
                if (cart == null) {
                    cart = new Cart(uid, product, quantity_buynow);
                    session.setAttribute(pid_raw, cart);
                } else {

                    if (cart.getQuantity() + quantity_buynow > product.getUnitInStock()) {
                        cart = new Cart(uid, product, product.getUnitInStock());
                    } else {
                        cart = new Cart(uid, product, cart.getQuantity() + quantity_buynow);
                    }
                    session.setAttribute(pid_raw, cart);
                }
                checkBoxList = request.getParameterValues("pid");
                request.setAttribute("quantity_buynow", quantity_buynow);
                request.setAttribute("service", service);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("checkBoxList", checkBoxList);
                request.getRequestDispatcher("bill.jsp").forward(request, response);
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

            //===================CHECK OUT============================
            if (service.equals("checkout")) {
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
//            System.out.println("checkout");
//            System.out.println("Order controller");
                java.util.Enumeration em = session.getAttributeNames();
                Vector<OrderDetail> listOrderDetails = new Vector<>();
//                System.out.println("checkboxlist");
//                for (String string : checkBoxList) {
//                    System.out.println(string);
//                }
                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key
                    for (int i = 0; i < checkBoxList.length; i++) {
                        if (id.equals(checkBoxList[i])) {

                            //Add cart to order detail
                            Cart cart = (Cart) session.getAttribute(id); //get value
                            OrderDetail orderDetail = new OrderDetail(cart.getProduct(), cart.getQuantity(), cart.getProduct().getUnitPrice() * (1 - cart.getProduct().getDiscount() / 100));
                            listOrderDetails.add(orderDetail);

                            // update unitInStock
                            Product updateProduct = cart.getProduct();
                            updateProduct.setUnitInStock(updateProduct.getUnitInStock() - cart.getQuantity());
                            if (updateProduct.getUnitInStock() == 0) {
                                updateProduct.setStatus(0);
                            }
                            pd.update(updateProduct);

                            //delete cart in database and session
                            int pid = Integer.parseInt(id);
                            cd.deleteCart(uid, pid);
                            session.removeAttribute(id);
                        }
                    }
                }
                Order newOrder = new Order(uid, totalPrice, 1, address, phone);
//                System.out.println(newOrder);
                od.CreateOrder(newOrder, listOrderDetails);
                response.sendRedirect("home?show=true");
            }

            //==================BUY NOW=====================
            if (service.equals("buynow")) {
                int quantity_buynow = Integer.parseInt(request.getParameter("quantity_buynow"));
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
//            System.out.println("checkout");
//            System.out.println("Order controller");
                java.util.Enumeration em = session.getAttributeNames();
                Vector<OrderDetail> listOrderDetails = new Vector<>();
                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key
                    for (int i = 0; i < checkBoxList.length; i++) {
                        if (id.equals(checkBoxList[i])) {

                            //Add cart to order detail
                            Cart cart = (Cart) session.getAttribute(id); //get value
                            OrderDetail orderDetail = new OrderDetail(cart.getProduct(), quantity_buynow, cart.getProduct().getUnitPrice() * (1 - cart.getProduct().getDiscount() / 100));
                            listOrderDetails.add(orderDetail);

                            // update unitInStock
                            Product updateProduct = cart.getProduct();
                            updateProduct.setUnitInStock(updateProduct.getUnitInStock() - quantity_buynow);
                            if (updateProduct.getUnitInStock() == 0) {
                                updateProduct.setStatus(0);
                            }
                            pd.update(updateProduct);

                            //Check to remove cart in session
                            if (quantity_buynow == cart.getQuantity()) {
                                session.removeAttribute(id);
                            } else {
                                cart = new Cart(uid, updateProduct, cart.getQuantity() - quantity_buynow);
                                session.setAttribute(id, cart);
                            }
                        }

                    }
                }
                Order newOrder = new Order(uid, totalPrice, 1, address, phone);
                System.out.println(newOrder);
                od.CreateOrder(newOrder, listOrderDetails);
                response.sendRedirect("home?show=true");
            }

            //Update shipped date and status
            if (service.equals("update")) {
                int orderID = Integer.parseInt(request.getParameter("oid"));
                String shipid_raw = request.getParameter("update-shipper");
                String statusid = request.getParameter("update-statusid");
                if (shipid_raw != null) {
                    int shipid = Integer.parseInt(shipid_raw);
                    if (shipid != 0) {
                        od.updateStatusToProcess(orderID, shipid);
                    }
                }

                if ("3".equals(statusid)) {
                    od.updateShippedDate(orderID);
                }
                if (user.getRoleID() == 1) {
                    response.sendRedirect("adminpage?service=ordermanager");
                } else {
                    response.sendRedirect("usertask?service=mypurchase");
                }
            }

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
