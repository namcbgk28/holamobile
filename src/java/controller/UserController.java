/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.User;
import model.UserDAO;
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

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "UserController", urlPatterns = {"/usercontroller"})
public class UserController extends HttpServlet {

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
            out.println("<title>Servlet UserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserController at " + request.getContextPath() + "</h1>");
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
            String service = request.getParameter("service");
            UserDAO ud = new UserDAO();
            if (service.equals("deleteuser")) {
                try {
                    int uid = Integer.parseInt(request.getParameter("uid"));
                    if (uid != 1) {
                        ud.deleteUser(uid);
                    }
                    response.sendRedirect("adminpage?service=usermanager");
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            //===========================SEARCH USER===========================
            if (service.equals("search")) {
                //Get parameter
                String sort = request.getParameter("sort");
                String key = request.getParameter("key");

                //Build string SQL
                String sql = "select u.userID,u.FullName,u.UserName,u.Phone,CAST([address] AS NVARCHAR(4000)) [address],u.Email,[dateadd], count(OrderID) as TotalOrder\n"
                        + "from [User] u\n"
                        + "LEFT JOIN [Order] o on u.UserID = o.UserID\n"
                        + "WHERE 1 = 1  ";

                //sql for count totalUser
                String sql_count = "SELECT COUNT(*)\n"
                        + "FROM [User] WHERE 1 = 1 \n";

                if (key != null && !"".equals(key)) {
                    int id = 0;
                    try {
                        id = Integer.parseInt(key);
                        sql += " AND UserID = " + id;
                        sql_count += " AND UserID = " + id;
                    } catch (NumberFormatException e) {
                        sql += " AND FullName LIKE '%" + key + "%'";
                        sql_count += " AND FullName LIKE '%" + key + "%'";
                    }
                }

                sql += "\ngroup by u.userID,u.FullName,u.UserName,u.Phone,CAST([address] AS NVARCHAR(4000)),u.Email,[dateadd]\n";

                //Sort 
                if (sort == null || sort.equals("")) {
                    sort = "0";
                }
                sql += " ORDER BY ";
                if (sort.equals("0")) {
                    sql += " DateAdd ASC";
                } else if (sort.equals("1")) {
                    sql += " DateAdd DESC";
                } else if (sort.equals("2")) {
                    sql += " FullName ASC ";
                } else if (sort.equals("3")) {
                    sql += " FullName DESC ";
                } else {
                    sql += " count(OrderID) DESC ";
                }
                sql += ", UserID ASC  \n";

                //Get total Product
                ResultSet rs1 = ud.getData(sql_count);
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
                sql += " OFFSET " + start + " ROW FETCH NEXT " + numberPerPage + " ROWS ONLY";

                // Get all data of user
                System.out.println(sql);
                ResultSet rs = ud.getData(sql);

                request.setAttribute("totalUser", totalUser);
                request.setAttribute("rs", rs);
                request.setAttribute("numberPage", numberPage);
                request.setAttribute("page", page);
                request.setAttribute("start", start);
                request.setAttribute("sort", sort);
                request.setAttribute("key", key);
                request.getRequestDispatcher("UserManager.jsp").forward(request, response);
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
