package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.User;

/**
 *
 * @author Chaunam270203
 */
public class UserDAO extends DBConnect {

    public int GetMaxId() {
        String sql = "select top 1 UserID from [User] order by UserID desc";
        try {
            PreparedStatement a = connection.prepareStatement(sql);
            ResultSet rs = a.executeQuery();
            if (rs.next()) {
                return rs.getInt("UserID");
            }
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    public User check(String username, String password) {
//        int id = GetMaxId() + 1;
        String sql = "SELECT [UserID]\n"
                + "      ,[FullName]\n"
                + "      ,[Address]\n"
                + "      ,[Phone]\n"
                + "      ,[Gender]\n"
                + "      ,[Username]\n"
                + "      ,[Password]\n"
                + "      ,[RoleID]\n"
                + "      ,[DateAdd]\n"
                + "      ,[Email]\n"
                + "  FROM [dbo].[User]"
                + "  WHERE [Username] = ? AND [Password] = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User a = new User(rs.getInt("UserID"), rs.getString("FullName"), rs.getString("Address"),
                        rs.getString("Phone"), rs.getBoolean("Gender"),
                        rs.getString("Username"),
                        rs.getString("Password"), rs.getInt("RoleID"), rs.getString("DateAdd"), rs.getString("Email"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean isExist(String username) {
        String sql = "select * from [USER] where USERNAME = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {

        }
        return false;
    }

    public int addNewCustomer(User user) {
        int uid = GetMaxId() + 1;
        int n = 0;
        String sql = "INSERT INTO [dbo].[User]\n"
                + "           ([UserID]\n"
                + "           ,[FullName]\n"
                + "           ,[Address]\n"
                + "           ,[Phone]\n"
                + "           ,[Gender]\n"
                + "           ,[Username]\n"
                + "           ,[Password]\n"
                + "           ,[RoleID]\n"
                + "           ,[DateAdd]\n"
                + "           ,[Email])"
                + "     VALUES (?,?,?,?,?,?,?,?,getdate(),?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, uid);
            st.setString(2, user.getFullName());
            st.setString(3, user.getAddress());
            st.setString(4, user.getPhone());
            st.setBoolean(5, user.isGender());
            st.setString(6, user.getUsername());
            st.setString(7, user.getPassword());
            st.setInt(8, user.getRoleID());
            st.setString(9, user.getEmail());
            n = st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return n;
    }

    public int updateCustomer(User newUser) {
        int n = 0;
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [FullName] = ?\n"
                + "      ,[Phone] = ?\n"
                + "      ,[Gender] = ?\n"
                + "      ,[Email] = ?\n"
                + "      ,[Address] = ?\n"
                + " WHERE UserID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newUser.getFullName());
            st.setString(2, newUser.getPhone());
            st.setBoolean(3, newUser.isGender());
            st.setString(4, newUser.getEmail());
            st.setString(5, newUser.getAddress());
            st.setInt(6, newUser.getUserID());
            n = st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return n;
    }
    
    public int deleteUser(int uid) {
        int n = 0;
        String sql = "delete [User] where UserID =" + uid;
        try {
            Statement st = connection.createStatement();
            n = st.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int changePassword(int uid, String password) {
        int n = 0;
        String sql = "UPDATE [dbo].[User]\n"
                + "   SET [Password] = ?\n"
                + " WHERE UserID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setInt(2, uid);
            n = st.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return n;
    }

    public User getUser(String sql) {
        try {
            Statement st = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                User a = new User(rs.getInt("UserID"), rs.getString("FullName"), rs.getString("Address"),
                        rs.getString("Phone"), rs.getBoolean("Gender"),
                        rs.getString("Username"),
                        rs.getString("Password"), rs.getInt("RoleID"), rs.getString("DateAdd"), rs.getString("Email"));
                return a;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {
        UserDAO ud = new UserDAO();
        int role = 2;
//        System.out.println(ud.check("admin", "admin1"));
        User user = new User("Customer", "Hà Nội", "0855270203", false, "user12", "pass12", role, "nam@gmail.com");
        ud.addNewCustomer(user);

        System.out.println(ud.check("userhaha", "pass12"));
    }
}
