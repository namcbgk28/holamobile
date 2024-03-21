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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.Product;
import entity.Shipper;
import entity.Status;
import entity.User;
import jakarta.servlet.http.HttpSession;
import model.OrderDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "AdminPage", urlPatterns = {"/adminpage"})
public class AdminPage extends HttpServlet {

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
            out.println("<title>Servlet AdminPage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminPage at " + request.getContextPath() + "</h1>");
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
            
            if (service.equals("usermanager")) {
                //Get total Product
                ResultSet rs1 = pd.getData("SELECT COUNT(*) FROM [User]");
                int totalUser = 0;
                try {
                    if (rs1.next()) {
                        totalUser = rs1.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Paging
                int numberPerPage = 6;
                int numberPage;
                
                if (totalUser % numberPerPage == 0) {
                    numberPage = totalUser / numberPerPage;
                } else {
                    numberPage = (totalUser / numberPerPage) + 1;
                }
                String page_raw = request.getParameter("page");
                int page;
                try {
                    page = Integer.parseInt(page_raw);
                } catch (NumberFormatException e) {
                    page = 1;
                }
                int start = (page - 1) * numberPerPage;

                // Get all data of user
                String sql = "select u.userID,u.FullName,u.UserName,u.Phone,CAST([address] AS NVARCHAR(4000)) [address],u.Email,[dateadd], count(OrderID) as TotalOrder\n"
                        + "from [User] u\n"
                        + "LEFT JOIN [Order] o on u.UserID = o.UserID\n"
                        + "WHERE 1 = 1  \n"
                        + "group by u.userID,u.FullName,u.UserName,u.Phone,CAST([address] AS NVARCHAR(4000)),u.Email,[dateadd]\n"
                        + " ORDER BY  DateAdd\n"
                        + " ASC OFFSET 0 ROW FETCH NEXT 6 ROWS ONLY";
                ResultSet rs = pd.getData(sql);
                
                request.setAttribute("totalUser", totalUser);
                request.setAttribute("rs", rs);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("page", page);
                request.setAttribute("start", start);
                request.getRequestDispatcher("UserManager.jsp").forward(request, response);
            }
            
            if (service.equals("ordermanager")) {
                //Get total Product
                ResultSet rs1 = pd.getData("SELECT COUNT(*) FROM [Order]");
                int totalOrder = 0;
                try {
                    if (rs1.next()) {
                        totalOrder = rs1.getInt(1);
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
                request.setAttribute("end", end);

                // Get all data of order
                ResultSet rs = pd.getData("select *,o.Phone as DeliverPhone from [Order] o\n"
                        + "join [User] u on o.UserID = u.UserID\n"
                        + "join [Status] s on s.StatusID = o.StatusID\n"
                        + "Order By o.OrderID\n"
                        + "OFFSET " + start + " ROW FETCH NEXT " + numberPerPage + " ROWS ONLY");
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
                
                request.setAttribute("vectorShipper", vectorShipper);
                request.setAttribute("vectorStatus", vectorStatus);
                request.setAttribute("totalOrder", totalOrder);
                request.setAttribute("rs", rs);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("page", page);
                request.setAttribute("start", start);
                request.getRequestDispatcher("OrderManager.jsp").forward(request, response);
            }

//            //===============================STATISTIC=================================
            if (service.equals("statistic")) {

                //Total Income
                double totalIncome = 0;
                String sql = "select sum(TotalPrice)\n"
                        + "from [Order]\n"
                        + "where ShippedDate >= '01/01/2023' AND ShippedDate < '01/01/2024'";
                ResultSet rs = pd.getData(sql);
                try {
                    if (rs.next()) {
                        totalIncome = rs.getDouble(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }

                //Income in each month
                double m1 = od.GetIncomeByMonth(1);
                double m2 = od.GetIncomeByMonth(2);
                double m3 = od.GetIncomeByMonth(3);
                double m4 = od.GetIncomeByMonth(4);
                double m5 = od.GetIncomeByMonth(5);
                double m6 = od.GetIncomeByMonth(6);
                double m7 = od.GetIncomeByMonth(7);
                double m8 = od.GetIncomeByMonth(8);
                double m9 = od.GetIncomeByMonth(9);
                double m10 = od.GetIncomeByMonth(10);
                double m11 = od.GetIncomeByMonth(11);
                double m12 = od.GetIncomeByMonth(12);

                //total Order
                int totalOrder = 0;
                ResultSet rs1 = pd.getData("SELECT COUNT(*) FROM [ORDER]");
                try {
                    if (rs1.next()) {
                        totalOrder = rs1.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("totalOrder", totalOrder);

                //number order done, wait, process
                int numberDone = od.getNumberOrderByStatus(3);
                int numberWait = od.getNumberOrderByStatus(1);
                int numberProcess = od.getNumberOrderByStatus(2);
                
                request.setAttribute("numberDone", numberDone);
                request.setAttribute("numberWait", numberWait);
                request.setAttribute("numberProcess", numberProcess);

                //total user
                ResultSet rsUser = pd.getData("SELECT COUNT(*) FROM [USER]");
                int totalUser = 0;
                try {
                    if (rsUser.next()) {
                        totalUser = rsUser.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("totalUser", totalUser);

                //Male
                ResultSet rsMale = pd.getData("SELECT COUNT(*) FROM [USER]\n"
                        + "WHERE Gender = 1");
                int totalMale = 0;
                try {
                    if (rsMale.next()) {
                        totalMale = rsMale.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("totalMale", totalMale);

                //Female
                ResultSet rsFemale = pd.getData("SELECT COUNT(*) FROM [USER]\n"
                        + "WHERE Gender = 0");
                int totalFemale = 0;
                try {
                    if (rsFemale.next()) {
                        totalFemale = rsFemale.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("totalFemale", totalFemale);

                //Newbie
                ResultSet rsNew = pd.getData("SELECT COUNT(*) FROM [USER]\n"
                        + "WHERE DATEDIFF(DAY,DateAdd,GETDATE())<3");
                int totalNew = 0;
                try {
                    if (rsNew.next()) {
                        totalNew = rsNew.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("totalNew", totalNew);
                
                request.setAttribute("totalIncome", totalIncome);
                request.setAttribute("m1", m1);
                request.setAttribute("m2", m2);
                request.setAttribute("m3", m3);
                request.setAttribute("m4", m4);
                request.setAttribute("m5", m5);
                request.setAttribute("m6", m6);
                request.setAttribute("m7", m7);
                request.setAttribute("m8", m8);
                request.setAttribute("m9", m9);
                request.setAttribute("m10", m10);
                request.setAttribute("m11", m11);
                request.setAttribute("m12", m12);
                
                ResultSet rsPro = pd.getData("SELECT C.CategoryID,CategoryName,SUM(Quantity)AS TOTAL\n"
                        + "FROM Product P\n"
                        + "JOIN Category C ON P.CategoryID = C.CategoryID\n"
                        + "JOIN OrderDetail OD ON OD.ProductID = P.ProductID\n"
                        + "GROUP BY C.CategoryID,CategoryName\n"
                        + "ORDER BY CategoryID");
                int totalProduct = 0;
                ResultSet rsTotalProduct = pd.getData("SELECT SUM(QUANTITY) FROM OrderDetail");
                try {
                    if(rsTotalProduct.next()){
                        totalProduct = rsTotalProduct.getInt(1);
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(AdminPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("totalProduct", totalProduct);
                request.setAttribute("rsPro", rsPro);
                
                request.getRequestDispatcher("statistic.jsp").forward(request, response);
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
