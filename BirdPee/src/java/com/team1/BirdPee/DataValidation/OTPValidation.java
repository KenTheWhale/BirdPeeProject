/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.DataValidation;

/**
 *
 * @author Admin
 */
public class OTPValidation {
   
//OTP must be in number
    public static boolean checkOTP(String data) throws Exception{
        for (int i = 0; i < data.length(); i++) {
            if(!Character.isDigit(data.charAt(i))){
                return false;
            }
        }
        return true;
    }
}
