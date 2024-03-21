package controller;

import entity.Cart;
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
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartDAO;
import model.ProductDAO;

/**
 *
 * @author Chaunam270203
 */
@WebServlet(urlPatterns = {"/cartcontroller"})
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet AddToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    public String checkBoxList[];

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
            CartDAO cd = new CartDAO();
            ProductDAO pd = new ProductDAO();
            if (service == null) {
                service = "gotocart";
            }
            if (service.equals("addtocart")) {

                int uid = ((User) session.getAttribute("account")).getUserID();
                String pid_raw = request.getParameter("pid");
                System.out.println("pid: " + pid_raw);
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                System.out.println("quantity: " + quantity);

                Cart cart = (Cart) session.getAttribute(pid_raw);
                int pid = Integer.parseInt(pid_raw);
                Product product = pd.getProductById(pid);
                if (cart == null) {
                    if (quantity > product.getUnitInStock()) {
                        quantity = product.getUnitInStock();
                    }
                    cart = new Cart(uid, product, quantity);
                    session.setAttribute(pid_raw, cart);
//                System.out.println(cart);
                    cd.AddToCart(cart);
//                    response.sendRedirect("home?service=displayproduct&pid=" + pid + "&ms=adddone");
                    PrintWriter out = response.getWriter();
                    out.println("<div id=\"toast\">\n"
                            + "                <div class=\"toast toast--success\">\n"
                            + "                    <div class=\"toast__icon\">\n"
                            + "                        <i class=\"fas fa-check-circle\"></i>\n"
                            + "                    </div>\n"
                            + "                    <div class=\"toast__body\">\n"
                            + "                        <h3 class=\"toast__title\">Thông báo</h3>\n"
                            + "                        <p class=\"toast__msg\">Thêm vào giỏ hàng thành công</p>\n"
                            + "                        <!--Đặt hàng thành công!-->\n"
                            + "                        <p class=\"toast__msg\">Mời bạn tiếp tục mua sắm</p>\n"
                            + "                        <!--Đơn hàng sẽ được vận chuyển trong thời gian sớm nhất-->\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "            </div>");

                    out.println("##DELIMITER##");

                    java.util.Enumeration em = session.getAttributeNames();
                    int totalInCart = Collections.list(em).size();

                    User user = (User) session.getAttribute("account");
                    DecimalFormat df = new DecimalFormat("###,###");
                    df.setMaximumFractionDigits(8);
                    out.println("<a href=\"cartcontroller?service=gotocart\">\n"
                            + "                            <i class=\"fa-solid fa-cart-arrow-down\"></i>\n"
                            + "                            Giỏ hàng</a>");
                    if (user != null) {
                        out.println("<div id=\"numberItems\" style=\"position: absolute;\n"
                                + "                             padding: 3px 6px;\n"
                                + "                             color: #fff;\n"
                                + "                             border: none;\n"
                                + "                             border-radius: 15px;\n"
                                + "                             background-color: var(--main-color-2);\n"
                                + "                             top: -3px;\n"
                                + "                             left: 19px;\n"
                                + "                             font-size: 8px;\">" + (totalInCart - 1) + "\n"
                                + "                        </div>");
                    }
                    out.println("<div id=\"cart-show\">");
                    if (user == null || totalInCart - 1 == 0) {
                        out.println("<div style=\"color: #111\" >Chưa có sản phẩm nào</div>\n"
                                + "                            <style>\n"
                                + "                                #cart-show{\n"
                                + "                                    position: absolute;\n"
                                + "                                    z-index: 200;\n"
                                + "                                    background: white;\n"
                                + "                                    display: none;\n"
                                + "                                    flex-direction: column;\n"
                                + "                                    width: 400px;\n"
                                + "                                    font-family: arial;\n"
                                + "                                    padding: 10px;\n"
                                + "                                    box-shadow: 0.5px 0.5px 2px;\n"
                                + "                                    top: 30px;\n"
                                + "                                    right: 0;\n"
                                + "                                    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);\n"
                                + "                                    transition: all ease-in 1s;\n"
                                + "                                }\n"
                                + "                                #cart:hover #cart-show{\n"
                                + "                                    display: flex;\n"
                                + "                                    flex-direction: column;\n"
                                + "                                    transition: .5s;\n"
                                + "                                }\n"
                                + "                            </style>");
                    } else if (totalInCart != 0) {
                        out.println("<p style=\"color: #111;\n"
                                + "                               font-size: 16px;\n"
                                + "                               font-weight: 600;\n"
                                + "                               margin: 8px 16px;\n"
                                + "                               \">Sản phẩm mới thêm</p>");
                        em = session.getAttributeNames();
                        while (em.hasMoreElements()) {
                            String id = em.nextElement().toString(); //get key
//                                    System.out.println(id);
                            if (!id.equals("account") && !id.equals("jakarta.servlet.jsp.jstl.fmt.request.charset") && !id.equals("admin")) {
                                Cart newcart = (Cart) session.getAttribute(id);
                                out.println("<a href=\"home?service=displayproduct&pid=" + newcart.getProduct().getProductID() + "\" class=\"cart-product\">\n"
                                        + "                                <div style=\"display: flex; align-items: center\">\n"
                                        + "                                    <img class=\"cart-product-image\" src=\"image/product/" + newcart.getProduct().getProductID() + "/1.png\">\n"
                                        + "                                    <p style=\"padding-left:20px;font-size: 14px;\">" + newcart.getProduct().getProductName() +"   ("+cart.getQuantity()+")"+ "</p>\n"
                                        + "                                </div>\n"
                                        + "                                <div>\n"
                                        + "                                    <p style=\"padding-left:20px; color: var(--main-color-2);font-weight: 600;\">₫" + df.format(newcart.getProduct().getUnitPrice() * (1 - newcart.getProduct().getDiscount() / 100)) + "</p>\n"
                                        + "\n"
                                        + "                                </div>\n"
                                        + "                            </a>");
                            }
                        }
                        out.println("<a id=\"viewcart\" href=\"cartcontroller\">Xem giỏ hàng (" + (totalInCart - 1) + ")</a>\n"
                                + "                            <style>\n"
                                + "                                #viewcart{\n"
                                + "                                    text-align: center;\n"
                                + "                                    text-decoration: none;\n"
                                + "                                    color: white;\n"
                                + "                                    background-color:#c32424;\n"
                                + "                                    display: flex;\n"
                                + "                                    justify-content: center;\n"
                                + "                                    align-items: center;\n"
                                + "                                    padding: 10px 0px;\n"
                                + "                                    width: 40%;\n"
                                + "                                    transition: .5s;\n"
                                + "                                    border-radius: 8px;\n"
                                + "                                    margin: 20px;\n"
                                + "                                }\n"
                                + "                                #viewcart:hover{\n"
                                + "                                    background-color: var(--main-color-2);\n"
                                + "                                }\n"
                                + "                                #cart-show{\n"
                                + "                                    position: absolute;\n"
                                + "                                    z-index: 100000;\n"
                                + "                                    background: white;\n"
                                + "                                    display: flex;\n"
                                + "                                    flex-direction: column;\n"
                                + "                                    width: 400px;\n"
                                + "                                    font-family: arial;\n"
                                + "                                    top: 30px;\n"
                                + "                                    right: 0;\n"
                                + "                                    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);\n"
                                + "                                    transition: 0.2s;\n"
                                + "                                    height: 0;\n"
                                + "                                    overflow-y: scroll;\n"
                                + "                                }\n"
                                + "                                #cart:hover #cart-show{\n"
                                + "                                    transition: 0.2s;\n"
                                + "                                    height: 400px;\n"
                                + "                                }\n"
                                + "                                .cart-product:hover{\n"
                                + "                                    box-shadow: 0 0 2px 0 rgba(0, 0, 0, .75);\n"
                                + "                                    transition: .4s;\n"
                                + "                                }\n"
                                + "                                .cart-product{\n"
                                + "                                    display: flex;\n"
                                + "                                    align-items: center;\n"
                                + "                                    height: 56px;\n"
                                + "                                    text-decoration: none;\n"
                                + "                                    color: #111;\n"
                                + "                                    padding: 4px;\n"
                                + "                                    transition: .4s;\n"
                                + "                                    margin: 0 8px 8px 8px;\n"
                                + "                                    justify-content: space-between;\n"
                                + "                                }\n"
                                + "                                .cart-product-image{\n"
                                + "                                    height: 46px;\n"
                                + "                                }\n"
                                + "                            </style>");
                    }
                    out.println("</div>");
                } else {
                    if (cart.getQuantity() + quantity > product.getUnitInStock()) {
                        cart = new Cart(uid, product, product.getUnitInStock());
                    } else {
                        cart = new Cart(uid, product, cart.getQuantity() + quantity);
                    }
                    session.setAttribute(pid_raw, cart);
                    cd.UpdateCart(cart);

                    PrintWriter out = response.getWriter();
                    out.println("<div id=\"toast\">\n"
                            + "                <div class=\"toast toast--success\">\n"
                            + "                    <div class=\"toast__icon\">\n"
                            + "                        <i class=\"fas fa-check-circle\"></i>\n"
                            + "                    </div>\n"
                            + "                    <div class=\"toast__body\">\n"
                            + "                        <h3 class=\"toast__title\">Thông báo</h3>\n"
                            + "                        <p class=\"toast__msg\">Thêm vào giỏ hàng thành công</p>\n"
                            + "                        <!--Đặt hàng thành công!-->\n"
                            + "                        <p class=\"toast__msg\">Mời bạn tiếp tục mua sắm</p>\n"
                            + "                        <!--Đơn hàng sẽ được vận chuyển trong thời gian sớm nhất-->\n"
                            + "                    </div>\n"
                            + "                </div>\n"
                            + "            </div>");

                    out.println("##DELIMITER##");

                    java.util.Enumeration em = session.getAttributeNames();
                    int totalInCart = Collections.list(em).size();

                    User user = (User) session.getAttribute("account");
                    DecimalFormat df = new DecimalFormat("###,###");
                    df.setMaximumFractionDigits(8);
                    out.println("<a href=\"cartcontroller?service=gotocart\">\n"
                            + "                            <i class=\"fa-solid fa-cart-arrow-down\"></i>\n"
                            + "                            Giỏ hàng</a>");
                    if (user != null) {
                        out.println("<div id=\"numberItems\" style=\"position: absolute;\n"
                                + "                             padding: 3px 6px;\n"
                                + "                             color: #fff;\n"
                                + "                             border: none;\n"
                                + "                             border-radius: 15px;\n"
                                + "                             background-color: var(--main-color-2);\n"
                                + "                             top: -3px;\n"
                                + "                             left: 19px;\n"
                                + "                             font-size: 8px;\">" + (totalInCart - 1) + "\n"
                                + "                        </div>");
                    }
                    out.println("<div id=\"cart-show\">");
                    if (user == null || totalInCart - 1 == 0) {
                        out.println("<div style=\"color: #111\" >Chưa có sản phẩm nào</div>\n"
                                + "                            <style>\n"
                                + "                                #cart-show{\n"
                                + "                                    position: absolute;\n"
                                + "                                    z-index: 200;\n"
                                + "                                    background: white;\n"
                                + "                                    display: none;\n"
                                + "                                    flex-direction: column;\n"
                                + "                                    width: 400px;\n"
                                + "                                    font-family: arial;\n"
                                + "                                    padding: 10px;\n"
                                + "                                    box-shadow: 0.5px 0.5px 2px;\n"
                                + "                                    top: 30px;\n"
                                + "                                    right: 0;\n"
                                + "                                    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);\n"
                                + "                                    transition: all ease-in 1s;\n"
                                + "                                }\n"
                                + "                                #cart:hover #cart-show{\n"
                                + "                                    display: flex;\n"
                                + "                                    flex-direction: column;\n"
                                + "                                    transition: .5s;\n"
                                + "                                }\n"
                                + "                            </style>");
                    } else if (totalInCart != 0) {
                        out.println("<p style=\"color: #111;\n"
                                + "                               font-size: 16px;\n"
                                + "                               font-weight: 600;\n"
                                + "                               margin: 8px 16px;\n"
                                + "                               \">Sản phẩm mới thêm</p>");
                        em = session.getAttributeNames();
                        while (em.hasMoreElements()) {
                            String id = em.nextElement().toString(); //get key
//                                    System.out.println(id);
                            if (!id.equals("account") && !id.equals("jakarta.servlet.jsp.jstl.fmt.request.charset") && !id.equals("admin")) {
                                Cart newcart = (Cart) session.getAttribute(id);
                                out.println("<a href=\"home?service=displayproduct&pid=" + newcart.getProduct().getProductID() + "\" class=\"cart-product\">\n"
                                        + "                                <div style=\"display: flex; align-items: center\">\n"
                                        + "                                    <img class=\"cart-product-image\" src=\"image/product/" + newcart.getProduct().getProductID() + "/1.png\">\n"
                                        + "                                    <p style=\"padding-left:20px;font-size: 14px;\">" + newcart.getProduct().getProductName() +"   ("+cart.getQuantity()+")"+ "</p>\n"
                                        + "                                </div>\n"
                                        + "                                <div>\n"
                                        + "                                    <p style=\"padding-left:20px; color: var(--main-color-2);font-weight: 600;\">₫" + df.format(newcart.getProduct().getUnitPrice() * (1 - newcart.getProduct().getDiscount() / 100)) + "</p>\n"
                                        + "\n"
                                        + "                                </div>\n"
                                        + "                            </a>");
                            }
                        }
                        out.println("<a id=\"viewcart\" href=\"cartcontroller\">Xem giỏ hàng (" + (totalInCart - 1) + ")</a>\n"
                                + "                            <style>\n"
                                + "                                #viewcart{\n"
                                + "                                    text-align: center;\n"
                                + "                                    text-decoration: none;\n"
                                + "                                    color: white;\n"
                                + "                                    background-color:#c32424;\n"
                                + "                                    display: flex;\n"
                                + "                                    justify-content: center;\n"
                                + "                                    align-items: center;\n"
                                + "                                    padding: 10px 0px;\n"
                                + "                                    width: 40%;\n"
                                + "                                    transition: .5s;\n"
                                + "                                    border-radius: 8px;\n"
                                + "                                    margin: 20px;\n"
                                + "                                }\n"
                                + "                                #viewcart:hover{\n"
                                + "                                    background-color: var(--main-color-2);\n"
                                + "                                }\n"
                                + "                                #cart-show{\n"
                                + "                                    position: absolute;\n"
                                + "                                    z-index: 100000;\n"
                                + "                                    background: white;\n"
                                + "                                    display: flex;\n"
                                + "                                    flex-direction: column;\n"
                                + "                                    width: 400px;\n"
                                + "                                    font-family: arial;\n"
                                + "                                    top: 30px;\n"
                                + "                                    right: 0;\n"
                                + "                                    box-shadow: 0 0 6px 0 rgba(0, 0, 0, .75);\n"
                                + "                                    transition: 0.2s;\n"
                                + "                                    height: 0;\n"
                                + "                                    overflow-y: scroll;\n"
                                + "                                }\n"
                                + "                                #cart:hover #cart-show{\n"
                                + "                                    transition: 0.2s;\n"
                                + "                                    height: 400px;\n"
                                + "                                }\n"
                                + "                                .cart-product:hover{\n"
                                + "                                    box-shadow: 0 0 2px 0 rgba(0, 0, 0, .75);\n"
                                + "                                    transition: .4s;\n"
                                + "                                }\n"
                                + "                                .cart-product{\n"
                                + "                                    display: flex;\n"
                                + "                                    align-items: center;\n"
                                + "                                    height: 56px;\n"
                                + "                                    text-decoration: none;\n"
                                + "                                    color: #111;\n"
                                + "                                    padding: 4px;\n"
                                + "                                    transition: .4s;\n"
                                + "                                    margin: 0 8px 8px 8px;\n"
                                + "                                    justify-content: space-between;\n"
                                + "                                }\n"
                                + "                                .cart-product-image{\n"
                                + "                                    height: 46px;\n"
                                + "                                }\n"
                                + "                            </style>");
                    }
                    out.println("</div>");
//                request.setAttribute("pid", pid);
//                    response.sendRedirect("home?service=displayproduct&pid=" + pid + "&ms=adddone");
                }
            }

            if (service.equals("gotocart")) {
                String scroll_position = request.getParameter("scroll-position");
                request.setAttribute("pos", scroll_position);
                java.util.Enumeration em = session.getAttributeNames();
                int totalInCart = Collections.list(em).size();

                request.setAttribute("totalInCart", totalInCart);
                request.getRequestDispatcher("showcart.jsp").forward(request, response);
            }

            if (service.equals("deletemany")) {
                int uid = ((User) session.getAttribute("account")).getUserID();
                //Get checked box
                checkBoxList = request.getParameterValues("option-delete");
                java.util.Enumeration em = session.getAttributeNames();
                while (em.hasMoreElements()) {
                    String id = em.nextElement().toString(); //get key
                    for (String pid : checkBoxList) {
                        if (id.equals(pid)) {
                            session.removeAttribute(pid);
                            cd.deleteCart(uid, Integer.parseInt(pid));
                        }
                    }
                }
                response.sendRedirect("cartcontroller");
            }

            if (service.equals("deletecart")) {
                int pid = Integer.parseInt(request.getParameter("id"));
                int uid = ((User) session.getAttribute("account")).getUserID();
                cd.deleteCart(uid, pid);
                session.removeAttribute(request.getParameter("id"));
                response.sendRedirect("cartcontroller");
            }

            if (service.equals("updatecart")) {
                String scroll_position = request.getParameter("scroll-position");
                System.out.println("scroll_position: " + scroll_position);
                String pid_raw = request.getParameter("pid");
                int quantity = Integer.parseInt(request.getParameter("update-quantity"));
                int pid = Integer.parseInt(pid_raw);
                int uid = ((User) session.getAttribute("account")).getUserID();
                Product product = pd.getProductById(pid);
                Cart cart = new Cart(uid, product, quantity);
                session.setAttribute(pid_raw, cart);
                cd.UpdateCart(cart);
                response.sendRedirect("cartcontroller?pos=" + scroll_position);
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
