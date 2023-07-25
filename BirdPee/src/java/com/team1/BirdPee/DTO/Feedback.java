/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.DTO;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Feedback {
    private int id;
    private String comment;
    private float rating;
    private Date createDate;
    private int customerID, productID, orderID;
    private String reply;
    private int status;

    public Feedback() {
    }

    public Feedback(int id, String comment, float rating, Date createDate, int customerID, int productID, String reply, int status, int orderID) {
        this.id = id;
        this.comment = comment;
        this.rating = rating;
        this.createDate = createDate;
        this.customerID = customerID;
        this.productID = productID;
        this.reply = reply;
        this.status = status;
        this.orderID = orderID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }
    
    
}
