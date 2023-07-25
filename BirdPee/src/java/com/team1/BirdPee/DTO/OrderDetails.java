/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.DTO;

/**
 *
 * @author Admin
 */
public class OrderDetails {
    private int id, orderID, productID;
    private String productName;
    private int quantity;
    private float initPrice, shipPrice;

    public OrderDetails() {
    }

    public OrderDetails(int id, int orderID, int productID, String productName, int quantity, float initPrice, float shipPrice) {
        this.id = id;
        this.orderID = orderID;
        this.productID = productID;
        this.productName = productName;
        this.quantity = quantity;
        this.initPrice = initPrice;
        this.shipPrice = shipPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getInitPrice() {
        return initPrice;
    }

    public void setInitPrice(float initPrice) {
        this.initPrice = initPrice;
    }

    public float getShipPrice() {
        return shipPrice;
    }

    public void setShipPrice(float shipPrice) {
        this.shipPrice = shipPrice;
    }
    
    
}
