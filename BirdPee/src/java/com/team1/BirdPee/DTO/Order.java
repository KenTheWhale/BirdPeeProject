/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.DTO;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Order {
    private int id;
    private Date shipDate;
    private String shipAddress;
    private Date createDate;
    private int status, paymentTypeID, paymentMethodID, customerID, shipID, shipdistanceID;
    private ArrayList<OrderDetails> listOD;

    public Order(int id, Date shipDate, String shipAddress, Date createDate, int status, int paymentTypeID, int paymentMethodID, int customerID, int shipID, int shipdistanceID, ArrayList<OrderDetails> listOD) {
        this.id = id;
        this.shipDate = shipDate;
        this.shipAddress = shipAddress;
        this.createDate = createDate;
        this.status = status;
        this.paymentTypeID = paymentTypeID;
        this.paymentMethodID = paymentMethodID;
        this.customerID = customerID;
        this.shipID = shipID;
        this.shipdistanceID = shipdistanceID;
        this.listOD = listOD;
    }
    
   
    public Order() {
        
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getShipDate() {
        return shipDate;
    }

    public void setShipDate(Date shipDate) {
        this.shipDate = shipDate;
    }

    public String getShipAddress() {
        return shipAddress;
    }

    public void setShipAddress(String shipAddress) {
        this.shipAddress = shipAddress;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPaymentTypeID() {
        return paymentTypeID;
    }

    public void setPaymentTypeID(int paymentTypeID) {
        this.paymentTypeID = paymentTypeID;
    }

    public int getPaymentMethodID() {
        return paymentMethodID;
    }

    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getShipID() {
        return shipID;
    }

    public void setShipID(int shipID) {
        this.shipID = shipID;
    }

    public int getShipdistanceID() {
        return shipdistanceID;
    }

    public void setShipdistanceID(int shipdistanceID) {
        this.shipdistanceID = shipdistanceID;
    }

    public ArrayList<OrderDetails> getListOD() {
        return listOD;
    }

    public void setListOD(ArrayList<OrderDetails> listOD) {
        this.listOD = listOD;
    }
    
    
}
