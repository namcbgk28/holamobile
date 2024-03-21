/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chaunam270203
 */
public class Cart {
    private int UserID;
    private Product Product;
    private int Quantity;
    private String CreatedDate;

    public Cart() {
    }

    public Cart(int UserID, Product Product, int Quantity, String CreatedDate) {
        this.UserID = UserID;
        this.Product = Product;
        this.Quantity = Quantity;
        this.CreatedDate = CreatedDate;
    }

    public Cart(int UserID, Product Product, int Quantity) {
        this.UserID = UserID;
        this.Product = Product;
        this.Quantity = Quantity;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
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

    public String getCreatedDate() {
        return CreatedDate;
    }

    public void setCreatedDate(String CreatedDate) {
        this.CreatedDate = CreatedDate;
    }

    @Override
    public String toString() {
        return "Cart{" + "UserID=" + UserID + ", Product=" + Product + ", Quantity=" + Quantity + ", CreatedDate=" + CreatedDate + '}';
    }
}
