package entity;

import java.sql.Date;

public class User {
    private int UserID;
    private String FullName;
    private String Address;
    private String Phone;
    private boolean Gender;
    private String Username;
    private String Password;
    private int RoleID;
    private String DateAdd;
    private String Email;

    public User() {
        
    }

    public User(int UserID, String FullName, String Address, String Phone, boolean Gender, String Email) {
        this.UserID = UserID;
        this.FullName = FullName;
        this.Address = Address;
        this.Phone = Phone;
        this.Gender = Gender;
        this.Email = Email;
    }
    
    

    public User(String FullName, String Address, String Phone, boolean Gender, String Username, String Password, int RoleID, String Email) {
        this.FullName = FullName;
        this.Address = Address;
        this.Phone = Phone;
        this.Gender = Gender;
        this.Username = Username;
        this.Password = Password;
        this.RoleID = RoleID;
        this.Email = Email;
    }
    
    public User(int UserID, String FullName, String Address, String Phone, boolean Gender, String Username, String Password, int RoleID, String Email) {
        this.UserID = UserID;
        this.FullName = FullName;
        this.Address = Address;
        this.Phone = Phone;
        this.Gender = Gender;
        this.Username = Username;
        this.Password = Password;
        this.RoleID = RoleID;
        this.Email = Email;
    }
    

    public User(int UserID, String FullName, String Address, String Phone, boolean Gender, String Username, String Password, int RoleID, String DateAdd, String Email) {
        this.UserID = UserID;
        this.FullName = FullName;
        this.Address = Address;
        this.Phone = Phone;
        this.Gender = Gender;
        this.Username = Username;
        this.Password = Password;
        this.RoleID = RoleID;
        this.DateAdd = DateAdd;
        this.Email = Email;
    }

    public User(String FullName, String Address, String Phone, boolean Gender, String Username, String Password, int RoleID, String DateAdd, String Email) {
        this.FullName = FullName;
        this.Address = Address;
        this.Phone = Phone;
        this.Gender = Gender;
        this.Username = Username;
        this.Password = Password;
        this.RoleID = RoleID;
        this.DateAdd = DateAdd;
        this.Email = Email;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public boolean isGender() {
        return Gender;
    }

    public void setGender(boolean Gender) {
        this.Gender = Gender;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

    public String getDateAdd() {
        return DateAdd;
    }

    public void setDateAdd(String DateAdd) {
        this.DateAdd = DateAdd;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    @Override
    public String toString() {
        return "User{" + "UserID=" + UserID + ", FullName=" + FullName + ", Address=" + Address + ", Phone=" + Phone + ", Gender=" + Gender + ", Username=" + Username + ", Password=" + Password + ", RoleID=" + RoleID + ", DateAdd=" + DateAdd + ", Email=" + Email + '}';
    }

   
}
