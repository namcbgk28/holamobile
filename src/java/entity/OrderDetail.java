/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chaunam270203
 */
public class OrderDetail {
    private int OrderID;
    private Product Product;
    private int Quantity;
    private double UnitPrice;

    public OrderDetail() {
    }

    public OrderDetail(int OrderID, Product Product, int Quantity, double UnitPrice) {
        this.OrderID = OrderID;
        this.Product = Product;
        this.Quantity = Quantity;
        this.UnitPrice = UnitPrice;
    }

    public OrderDetail(Product Product, int Quantity, double UnitPrice) {
        this.Product = Product;
        this.Quantity = Quantity;
        this.UnitPrice = UnitPrice;
    }
    
    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public Product getProduct() {
        return Product;
    }

    public void setProduct(Product Product) {
        this.Product = Product;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    public double getUnitPrice() {
        return UnitPrice;
    }

    public void setUnitPrice(double UnitPrice) {
        this.UnitPrice = UnitPrice;
    }

    @Override
    public String toString() {
        return "OrderDetail{" + "OrderID=" + OrderID + ", Product=" + Product + ", Quantity=" + Quantity + ", UnitPrice=" + UnitPrice + '}';
    }
    
}
