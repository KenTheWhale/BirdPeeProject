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
public class Discount {
    private int productID;
    private float discountChoice;
    private Date startDate, endDate;
    private int id, isFreeShip;

    public Discount() {
    }

    public Discount(int productID, float discountChoice, Date startDate, Date endDate, int id, int isFreeShip) {
        this.productID = productID;
        this.discountChoice = discountChoice;
        this.startDate = startDate;
        this.endDate = endDate;
        this.id = id;
        this.isFreeShip = isFreeShip;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public float getDiscountChoice() {
        return discountChoice;
    }

    public void setDiscountChoice(float discountChoice) {
        this.discountChoice = discountChoice;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIsFreeShip() {
        return isFreeShip;
    }

    public void setIsFreeShip(int isFreeShip) {
        this.isFreeShip = isFreeShip;
    }
    
    
}
