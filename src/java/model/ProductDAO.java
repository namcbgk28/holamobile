/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.Category;
import entity.Product;

/**
 *
 * @author Chaunam270203
 */
public class ProductDAO extends DBConnect {

    public Vector<Product> getAllData() {
        String sql = "SELECT * FROM PRODUCT";
        Vector<Product> vector = new Vector<>();
        try {
            Statement st = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Product c = new Product(rs.getInt("ProductID"),
                        rs.getInt("CategoryID"), rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("UnitInStock"),
                        rs.getDouble("Discount"),
                        rs.getString("Image"),
                        rs.getInt("Status")
                );
                vector.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public Vector<Product> getProduct(String sql) {
        Vector<Product> vector = new Vector<>();
        try {
            Statement st = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Product c = new Product(rs.getInt("ProductID"),
                        rs.getInt("CategoryID"), rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("UnitInStock"),
                        rs.getDouble("Discount"),
                        rs.getString("Image"),
                        rs.getInt("Status")
                );
                vector.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public int GetMaxId() {
        String sql = "select top 1 ProductID from PRODUCT order by ProductID desc";
        try {
            PreparedStatement a = connection.prepareStatement(sql);
            ResultSet rs = a.executeQuery();
            while (rs.next()) {
                return rs.getInt("ProductID");
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public int addNewProduct(Product product) {
        int id = GetMaxId() + 1;
        int n = 0;
        String sql = "INSERT INTO [dbo].[Product]\n"
                + "           ([ProductID]\n"
                + "           ,[CategoryID]\n"
                + "           ,[ProductName]\n"
                + "           ,[Description]\n"
                + "           ,[UnitPrice]\n"
                + "           ,[UnitInStock]\n"
                + "           ,[Discount]\n"
                + "           ,[Image]\n"
                + "           ,[Status])"
                + "     VALUES (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.setInt(2, product.getCategoryID());
            st.setString(3, product.getProductName());
            st.setString(4, product.getDescription());
            st.setDouble(5, product.getUnitPrice());
            st.setInt(6, product.getUnitInStock());
            st.setDouble(7, product.getDiscount());
            st.setString(8, product.getImage());
            st.setInt(9, product.getStatus());

            n = st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return n;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM PRODUCT WHERE ProductID = ?";
        Product p = new Product();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p.setProductID(rs.getInt("ProductID"));
                p.setCategoryID(rs.getInt("CategoryID"));
                p.setProductName(rs.getString("ProductName"));
                p.setDescription(rs.getString("Description"));
                p.setUnitPrice(rs.getDouble("UnitPrice"));
                p.setUnitInStock(rs.getInt("UnitInStock"));
                p.setDiscount(rs.getDouble("Discount"));
                p.setImage(rs.getString("Image"));
                p.setStatus(rs.getInt("Status"));
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return p;
    }

    public int getCategoryIdByProductId(int productId) {
        int cateId = 0;
        String sql = "select * from Product\n"
                + "where ProductID = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                cateId = rs.getInt("CategoryID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cateId;
    }

    //Update product 
    public int update(Product product) {
        int n = 0;
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [CategoryID] = ?\n"
                + "      ,[ProductName] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[UnitPrice] = ?\n"
                + "      ,[UnitInStock] = ?\n"
                + "      ,[Discount] =?\n"
                + "      ,[Image] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE ProductID = ?";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            st.setInt(1, product.getCategoryID());
            st.setString(2, product.getProductName());
            st.setString(3, product.getDescription());
            st.setDouble(4, product.getUnitPrice());
            st.setInt(5, product.getUnitInStock());
            st.setDouble(6, product.getDiscount());
            st.setString(7, product.getImage());
            st.setInt(8, product.getStatus());
            st.setInt(9, product.getProductID());
            n = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int update(Product product, int pid) {
        int n = 0;
        String sql = "UPDATE [dbo].[Product]\n"
                + "   SET [CategoryID] = ?\n"
                + "      ,[ProductName] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[UnitPrice] = ?\n"
                + "      ,[UnitInStock] = ?\n"
                + "      ,[Discount] =?\n"
                + "      ,[Image] = ?\n"
                + "      ,[Status] = ?\n"
                + " WHERE ProductID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, product.getCategoryID());
            st.setString(2, product.getProductName());
            st.setString(3, product.getDescription());
            st.setDouble(4, product.getUnitPrice());
            st.setInt(5, product.getUnitInStock());
            st.setDouble(6, product.getDiscount());
            st.setString(7, product.getImage());
            st.setInt(8, product.getStatus());
            st.setInt(9, pid);
            n = st.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int delete(int id) {
        int n = 0;
        String sql = "delete Product where ProductID =" + id;
        try {
            Statement st = connection.createStatement();
            n = st.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int getTotalProduct() {
        String sql = "SELECT COUNT(*) FROM Product";
        try {
            PreparedStatement st = connection.prepareCall(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public Vector<Product> getListByPage(int page, int numberPerPage) {
        int start = (page - 1) * numberPerPage;
        String sql = "SELECT * FROM Product\n"
                + "ORDER BY [ProductID]\n"
                + "OFFSET ? ROW FETCH NEXT ? ROWS ONLY";
        Vector<Product> list = new Vector<>();
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, start);
            st.setInt(2, numberPerPage);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product c = new Product(rs.getInt("ProductID"),
                        rs.getInt("CategoryID"), rs.getString("ProductName"),
                        rs.getString("Description"),
                        rs.getDouble("UnitPrice"),
                        rs.getInt("UnitInStock"),
                        rs.getDouble("Discount"),
                        rs.getString("Image"),
                        rs.getInt("Status")
                );
                list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        Product product = new Product();
        product = p.getProductById(2);
        Vector<Product> list = p.getListByPage(1, 4);
//        System.out.println(product.getUnitPrice());
//        System.out.println(p.getCategoryIdByProductId(1));
        System.out.println(p.getProduct("SELECT * FROM PRODUCT WHERE CATEGORYID = 1").size());
    }
}
