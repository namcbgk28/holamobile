/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import entity.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Chaunam270203
 */
public class OrderDAO extends DBConnect {

    public void CreateOrder(Order order, Vector<OrderDetail> listOrder) {
        int orderID = GetMaxId() + 1;
        String sql = "INSERT INTO [dbo].[Order]\n"
                + "           ([OrderID]\n"
                + "           ,[UserID]\n"
                + "           ,[OrderDate]\n"
                + "           ,[RequiredDate]\n"
                + "           ,[TotalPrice]\n"
                + "           ,[StatusID]\n"
                + "           ,[Phone]\n"
                + "           ,[DeliverAddress])\n"
                + "     VALUES\n"
                + "           (?,?,getdate(),getdate()+7,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            st.setInt(2, order.getUserID());
            st.setDouble(3, order.getTotalPrice());
            st.setInt(4, order.getStatusID());
            st.setString(5, order.getPhone());
            st.setString(6, order.getDeliverAddress());
            st.executeUpdate();
            CreateOrderDetails(orderID, listOrder);
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void CreateOrderDetails(int orderid, Vector<OrderDetail> listOrderDetails) {
        String sqlsuborder = "INSERT INTO [dbo].[OrderDetail]\n"
                + "           ([OrderID]\n"
                + "           ,[ProductID]\n"
                + "           ,[Quantity]\n"
                + "           ,[UnitPrice])\n"
                + "     VALUES\n"
                + "           (?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sqlsuborder);
            for (int i = 0; i < listOrderDetails.size(); i++) {
                OrderDetail a = listOrderDetails.get(i);
                st.setInt(1, orderid);
                st.setInt(2, a.getProduct().getProductID());
                st.setInt(3, a.getQuantity());
                st.setDouble(4, a.getUnitPrice());
                st.executeUpdate();
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public int GetMaxId() {
        String sql = "select top 1 OrderID from [Order] order by  OrderID desc";
        try {
            PreparedStatement a = connection.prepareStatement(sql);
            ResultSet rs = a.executeQuery();
            while (rs.next()) {
                return rs.getInt("OrderID");
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public void updateShippedDate(int orderid) {
        String sql = "UPDATE [dbo].[Order]\n"
                + "   SET [ShippedDate] =GETDATE()\n"
                + "      ,[StatusID] = 3\n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderid);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void updateStatusToProcess(int orderID, int shipid) {
        String sql = "UPDATE [dbo].[Order]\n"
                + "   SET [StatusID] = 2\n"
                + " ,[ShipVia]=?\n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, shipid);
            st.setInt(2, orderID);
            st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public double GetIncomeByMonth(int month) {
        int next = month + 1;
        String sql = "";
        if (month == 12) {
            sql = "select sum(TotalPrice)\n"
                    + "from [Order]\n"
                    + "where ShippedDate >= '12/01/2023' AND ShippedDate < '01/01/2024'";
        } else {
            sql = "select sum(TotalPrice)\n"
                    + "from [Order]\n"
                    + "where ShippedDate >= '" + month + "/01/2023' AND ShippedDate < '" + next + "/01/2023'";
        }

        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public int getNumberOrderByStatus(int status) {
        String sql = "select count(*)\n"
                + "from [Order]\n"
                + "where StatusID = "+status;
        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public static void main(String[] args) {
        OrderDAO od = new OrderDAO();
        System.out.println(od.GetIncomeByMonth(12));
    }
}
