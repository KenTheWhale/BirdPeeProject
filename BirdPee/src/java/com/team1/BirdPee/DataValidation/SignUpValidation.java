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
public class SignUpValidation {

//Check signup data
    public static String checkSignup(String datatype, String data) throws Exception{
        String errorMsg = "";
        switch(datatype){
            case "name":
                if(checkName(data)) errorMsg = "Name must be in letters only";
                break;
            case "phone":
                if(checkPhone(data)) errorMsg = "Phone must has 10 numbers only";
                break;
            case "address":
                if(checkAddress(data)) errorMsg = "Address must be in format: Your street, your province, your city\nEx: Nguyen Van Cu, Binh Tan, HCM ";
                break;
        }
        
        return errorMsg;
    }
    
//Check name no number, non alphabet letter
    private static boolean checkName(String name) throws Exception{
        String errorMsg = "";
        for (int i = 0; i < name.length(); i++) {
            if( Character.isDigit(name.charAt(i)) || (!Character.isAlphabetic(name.charAt(i)) && !Character.isWhitespace(name.charAt(i))) ){
                return false;
            }
        }
        return true;
    }
    
//Check phone has 10 to 11 number and start with
    private static boolean checkPhone(String phone) throws Exception{
        String regex = "0[3|5|7|8|9]+[0-9]{8}";
        if(phone.matches(regex)){
            return true;
        }
        return false;
    }
    
//Check address that have 3 parts compulsorily
    private static boolean checkAddress(String address) throws Exception{
        String add[] = address.split(",");
        if(add.length == 3){
            return true;
        }
        return false;
    }
}
