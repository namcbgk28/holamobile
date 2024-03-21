/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import entity.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ProductDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "UserTask", urlPatterns = {"/usertask"})
public class UserTask extends HttpServlet {

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
            out.println("<title>Servlet UserTask</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserTask at " + request.getContextPath() + "</h1>");
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
        if (session.getAttribute("account") == null) {
            response.sendRedirect("sign");
        } else {
            String service = request.getParameter("service");
            System.out.println(service);
            User user = (User) session.getAttribute("account");
            ProductDAO pd = new ProductDAO();
            if (service.equals("adminpage")) {
                response.sendRedirect("adminpage");
            }
            if (service.equals("logout")) {
                if (session.getAttribute("account") != null) {
                    session.removeAttribute("account");
                    session.invalidate();
                }
                response.sendRedirect("home");
            }
            if (service.equals("myprofile")) {

                request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            }
            if (service.equals("changepass")) {
                request.getRequestDispatcher("changepass.jsp").forward(request, response);
            }

            if (service.equals("mypurchase")) {
                String sql = "select * from [Order] o\n"
                        + "join [Status] s on o.StatusID = s.StatusID\n"
                        + "where UserID = " + user.getUserID();
                String oid = request.getParameter("oid");
                System.out.println("oid : " + oid);
                ResultSet rs = pd.getData(sql);
                request.setAttribute("rs", rs);
                boolean show = false;

                if (oid != null && !oid.equals("")) {
                    ResultSet rs1 = pd.getData("select *,od.UnitPrice as OrderPrice from OrderDetail od \n"
                            + "join Product p on p.ProductID = od.ProductID\n"
                            + "where OrderID =  " + oid);
                    request.setAttribute("rs1", rs1);
                    request.setAttribute("oid", oid);
                    show = true;
                }
                request.setAttribute("show", show);
                request.getRequestDispatcher("mypurchase.jsp").forward(request, response);
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

            User user = (User) session.getAttribute("account");
            String service = request.getParameter("service");
            UserDAO ud = new UserDAO();
            if (service.equals("myprofile")) {
                int uid = user.getUserID();
                String fullname = request.getParameter("full-name");
                String email = request.getParameter("gmail");
                String phone = request.getParameter("phone");
                Boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
                String address = request.getParameter("address");
                User newUser = new User(uid, fullname, address, phone, gender, email);
                ud.updateCustomer(newUser);
                User currUser = ud.getUser("SELECT * FROM [USER] WHERE UserID = " + uid);
                session.setAttribute("account", currUser);
                String ms = "Update successfully!";
                response.sendRedirect("usertask?service=myprofile&ms=" + ms);
            }

            if (service.equals("changepass")) {
                String old = request.getParameter("oldpass");
                String newpass = request.getParameter("newpass");
                String confirm = request.getParameter("confirm");

                User check = ud.check(user.getUsername(), old);
                String ms = "";
                if (check == null) {
                    ms = "Mật khẩu cũ không hơp lệ";
                    request.setAttribute("ms", ms);
                    request.getRequestDispatcher("changepass.jsp").forward(request, response);
                } else {
                    if (!newpass.equals(confirm)) {
                        ms = "Mật khẩu không trùng khớp";
                        request.setAttribute("ms", ms);
                        request.getRequestDispatcher("changepass.jsp").forward(request, response);
                    } else if (newpass.length() < 8) {
                        ms = "Mật khẩu phải nhiều hơn 8 kí tự";
                        request.setAttribute("ms", ms);
                        request.getRequestDispatcher("changepass.jsp").forward(request, response);
                    } else {
                        ud.changePassword(user.getUserID(), newpass);
                        User currUser = ud.getUser("SELECT * FROM [USER] WHERE UserID = " + user.getUserID());
                        session.setAttribute("account", currUser);
                        ms = "Đổi mật khẩu thành công!";
                        request.setAttribute("ms", ms);
                        request.getRequestDispatcher("changepass.jsp").forward(request, response);
                    }
                }
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
