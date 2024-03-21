/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chaunam270203
 */
public class Order {

    private int OrderID;
    private int UserID;
    private String OrderDate;
    private String RequiredDate;
    private String ShippedDate;
    private double TotalPrice;
    private int StatusID;
    private String DeliverAddress;
    private int Shipvia;
    private String Phone;

    public Order() {
    }

    public Order(int OrderID, int UserID, String OrderDate, String RequiredDate, String ShippedDate, double TotalPrice, int StatusID, String DeliverAddress) {
        this.OrderID = OrderID;
        this.UserID = UserID;
        this.OrderDate = OrderDate;
        this.RequiredDate = RequiredDate;
        this.ShippedDate = ShippedDate;
        this.TotalPrice = TotalPrice;
        this.StatusID = StatusID;
        this.DeliverAddress = DeliverAddress;
    }

    public Order(int UserID, double TotalPrice, int StatusID, String DeliverAddress, String Phone) {
        this.UserID = UserID;
        this.TotalPrice = TotalPrice;
        this.StatusID = StatusID;
        this.DeliverAddress = DeliverAddress;
        this.Phone = Phone;
    }

    public Order(int UserID, double TotalPrice, int StatusID, String DeliverAddress, int Shipvia, String Phone) {
        this.UserID = UserID;
        this.TotalPrice = TotalPrice;
        this.StatusID = StatusID;
        this.DeliverAddress = DeliverAddress;
        this.Shipvia = Shipvia;
        this.Phone = Phone;
    }
    
    public Order(int OrderID, int UserID, double TotalPrice, int StatusID, String DeliverAddress) {
        this.OrderID = OrderID;
        this.UserID = UserID;
        this.TotalPrice = TotalPrice;
        this.StatusID = StatusID;
        this.DeliverAddress = DeliverAddress;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }
    
    public int getShipvia() {
        return Shipvia;
    }

    public void setShipvia(int Shipvia) {
        this.Shipvia = Shipvia;
    }
    
    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
    }

    public String getOrderDate() {
        return OrderDate;
    }

    public void setOrderDate(String OrderDate) {
        this.OrderDate = OrderDate;
    }

    public String getRequiredDate() {
        return RequiredDate;
    }

    public void setRequiredDate(String RequiredDate) {
        this.RequiredDate = RequiredDate;
    }

    public String getShippedDate() {
        return ShippedDate;
    }

    public void setShippedDate(String ShippedDate) {
        this.ShippedDate = ShippedDate;
    }

    public double getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(double TotalPrice) {
        this.TotalPrice = TotalPrice;
    }

    public int getStatusID() {
        return StatusID;
    }

    public void setStatusID(int StatusID) {
        this.StatusID = StatusID;
    }

    public String getDeliverAddress() {
        return DeliverAddress;
    }

    public void setDeliverAddress(String DeliverAddress) {
        this.DeliverAddress = DeliverAddress;
    }

    @Override
    public String toString() {
        return "Order{" + "OrderID=" + OrderID + ", UserID=" + UserID + ", OrderDate=" + OrderDate + ", RequiredDate=" + RequiredDate + ", ShippedDate=" + ShippedDate + ", TotalPrice=" + TotalPrice + ", StatusID=" + StatusID + ", DeliverAddress=" + DeliverAddress + ", Shipvia=" + Shipvia + ", Phone=" + Phone + '}';
    }

}
