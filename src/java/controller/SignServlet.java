/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Cart;
import model.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.Calendar;
import entity.User;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartDAO;
import model.ProductDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(name = "SignServlet", urlPatterns = {"/sign"})
public class SignServlet extends HttpServlet {

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
            out.println("<title>Servlet SignServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignServlet at " + request.getContextPath() + "</h1>");
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
        String service = request.getParameter("service");
        if (service == null) {
            service = "login";
        }
        if (service.equals("login")) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        if (service.equals("signup")) {
            request.getRequestDispatcher("signup.jsp").forward(request, response);
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
        String service = request.getParameter("service");
        UserDAO ud = new UserDAO();
        ProductDAO pd = new ProductDAO();
        CartDAO cd = new CartDAO();
        if (service.equals("login")) {
            String u = request.getParameter("user-name");
            String p = request.getParameter("password");

            User user = ud.check(u, p);
            if (user == null) {
                String ms = "Tài khoản hoặc mật khẩu không chính xác.";
                request.setAttribute("ms", ms);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else if (user.getRoleID() == 1) {
                HttpSession session = request.getSession();
                session.setAttribute("account", user);
                response.sendRedirect("adminpage");
            } else {
                
                //Check cart
                HttpSession session = request.getSession();
                session.setAttribute("account", user);
                ResultSet rs = ud.getData("select * from Cart where UserID=" + user.getUserID());
                try {
                    while (rs.next()) {
                        Cart cart = new Cart(rs.getInt("UserID"), pd.getProductById(rs.getInt("ProductID")), rs.getInt("Quantity"));
                        if (cart.getProduct().getUnitInStock() > 0) {
                            if (cart.getQuantity() > cart.getProduct().getUnitInStock()) {
                                cart.setQuantity(cart.getProduct().getUnitInStock());
                            }
                            String pid = String.valueOf(rs.getInt("ProductID"));
                            session.setAttribute(pid, cart);
                        }else{
                            cd.deleteCart(user.getUserID(), cart.getProduct().getProductID());
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(SignServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.sendRedirect("home");
            }
        }

        if (service.equals("signup")) {
            String ms = "";
            String name = request.getParameter("full-name");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String gmail = request.getParameter("gmail");
            String phone = request.getParameter("phone").trim();
            String address = request.getParameter("address");
            String u = request.getParameter("username");
            String p = request.getParameter("pass");
            String confirm = request.getParameter("confirm");
            if (!p.equals(confirm)) {
                ms = "Mật khẩu không trùng khớp";
                request.setAttribute("ms", ms);
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            if (ud.isExist(u)) {
                ms = "Tài khoản đã tồn tại";
                request.setAttribute("ms", ms);
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            if (p.length() < 8) {
                ms = "Mật khẩu phải nhiều hơn 8 kí tự";
                request.setAttribute("ms", ms);
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }
            User newUser = new User(name, address, phone, gender, u, p, 2, gmail);
            ud.addNewCustomer(newUser);
            newUser = ud.check(u, p);
            HttpSession session = request.getSession();
            session.setAttribute("account", newUser);
            response.sendRedirect("home");
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
