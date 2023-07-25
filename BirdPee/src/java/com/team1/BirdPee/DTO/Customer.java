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
public class Customer extends Account{
    private String fullname, email, gender, tel;
    private Date DoB;
    private int isDobSetup;
    public Customer() {
    }

    public Customer(String fullname, String email, String gender, String tel, Date DoB, int id, int status, String username, String password, String role, String img, int isDobSetup) {
        super(id, status, username, password, role, img);
        this.fullname = fullname;
        this.email = email;
        this.gender = gender;
        this.tel = tel;
        this.DoB = DoB;
        this.isDobSetup = isDobSetup;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Date getDoB() {
        return DoB;
    }

    public void setDoB(Date DoB) {
        this.DoB = DoB;
    }

    public int getIsDobSetup() {
        return isDobSetup;
    }

    public void setIsDobSetup(int isDobSetup) {
        this.isDobSetup = isDobSetup;
    }
    
   
    
}
