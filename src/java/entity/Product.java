package entity;

public class Product {
    private int ProductID;
    private int CategoryID;
    private String ProductName;
    private String Description;
    private double UnitPrice;
    private int UnitInStock;
    private double Discount;
    private String Image;
    private int Status;
    private int UnitInCart;

    public Product() {
    }

    public Product(int ProductID, int CategoryID, String ProductName, String Description, double UnitPrice, int UnitInStock, double Discount, String Image, int Status) {
        this.ProductID = ProductID;
        this.CategoryID = CategoryID;
        this.ProductName = ProductName;
        this.Description = Description;
        this.UnitPrice = UnitPrice;
        this.UnitInStock = UnitInStock;
        this.Discount = Discount;
        this.Image = Image;
        this.Status = Status;
    }

    public Product(int CategoryID, String ProductName, String Description, double UnitPrice, int UnitInStock, double Discount, String Image, int Status) {
        this.CategoryID = CategoryID;
        this.ProductName = ProductName;
        this.Description = Description;
        this.UnitPrice = UnitPrice;
        this.UnitInStock = UnitInStock;
        this.Discount = Discount;
        this.Image = Image;
        this.Status = Status;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getCategoryID() {
        return CategoryID;
    }

    public void setCategoryID(int CategoryID) {
        this.CategoryID = CategoryID;
    }

    public String getProductName() {
        return ProductName;
    }

    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public double getUnitPrice() {
        return UnitPrice;
    }

    public void setUnitPrice(double UnitPrice) {
        this.UnitPrice = UnitPrice;
    }

    public int getUnitInStock() {
        return UnitInStock;
    }

    public void setUnitInStock(int UnitInStock) {
        this.UnitInStock = UnitInStock;
    }

    public double getDiscount() {
        return Discount;
    }

    public void setDiscount(double Discount) {
        this.Discount = Discount;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getStatus() {
        return Status;
    }

    public void setStatus(int Status) {
        this.Status = Status;
    }

    public int getUnitInCart() {
        return UnitInCart;
    }

    public void setUnitInCart(int UnitInCart) {
        this.UnitInCart = UnitInCart;
    }
    
    @Override
    public String toString() {
        return "Product{" + "ProductID=" + ProductID + ", CategoryID=" + CategoryID + ", ProductName=" + ProductName + ", Description=" + Description + ", UnitPrice=" + UnitPrice + ", UnitInStock=" + UnitInStock + ", Discount=" + Discount + ", Image=" + Image + ", Status=" + Status + '}';
    }

}
