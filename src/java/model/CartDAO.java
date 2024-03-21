/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Cart;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartDAO extends DBConnect {

    public void AddToCart(Cart cart) {
        String sql = "INSERT INTO [dbo].[Cart]\n"
                + "           ([UserID]\n"
                + "           ,[ProductID]\n"
                + "           ,[CreatedDate]\n"
                + "           ,[Quantity])\n"
                + "     VALUES\n"
                + "           (?,?,GETDATE(),?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cart.getUserID());
            st.setInt(2, cart.getProduct().getProductID());
            st.setInt(3, cart.getQuantity());
//            System.out.println(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public boolean isExist(int proid, int userid) {
        String sql = "SELECT * FROM CART WHERE PRODUCTID =" + proid + " and USERID=" + userid;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public void UpdateCart(Cart a) {
        String sql = "UPDATE [dbo].[Cart]\n"
                + "   SET [CreatedDate] = getdate()\n"
                + "      ,[Quantity] = ?\n"
                + " WHERE UserID = ? AND ProductID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, a.getQuantity());
            st.setInt(2, a.getUserID());
            st.setInt(3, a.getProduct().getProductID());
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public int deleteCart(int uid, int pid) {
        int n = 0;
        String sql = "DELETE FROM [dbo].[Cart]\n"
                + "   WHERE UserID = " + uid + " AND ProductID = " + pid;
        try {
            Statement st = connection.createStatement();
            n = st.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
    
    public static void main(String[] args) {
        CartDAO cd = new CartDAO();
//        cd.deleteCart(3, 3);
    }
}
