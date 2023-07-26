/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.DAO;

import com.team1.BirdPee.DTO.Account;
import com.team1.BirdPee.DTO.Category;
import com.team1.BirdPee.DTO.Customer;
import com.team1.BirdPee.DTO.Discount;
import com.team1.BirdPee.DTO.Feedback;
import com.team1.BirdPee.DTO.Item;
import com.team1.BirdPee.DTO.Order;
import com.team1.BirdPee.DTO.OrderDetails;
import com.team1.BirdPee.DTO.Product;
import com.team1.BirdPee.DTO.Shop;
import com.team1.BirdPee.Library.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class BirdPeeDAO {

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    private static SimpleDateFormat sdfco = new SimpleDateFormat("dd MMMM yyyy");

//----------------------------- ACCOUNT -----------------------------//
//-----//
//-----//
// Check existed customer's account by email and password
    public static Customer ACCOUNT_checkExistedCustomerByEmailPass(String email, String pass) throws Exception {
        Customer ac = new Customer();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct name, email, gender, tel, DoB, Account.id, status, username, password, role, img, isDobSetup\n"
                    + "from Account, Customer\n"
                    + "where email = ? \n"
                    + "and password = ? Collate Latin1_General_CS_AS \n"
                    + "and Account.id = Customer.id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, pass);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                ac = new Customer(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), sdf.parse(sdf.format(rs.getDate(5))), rs.getInt(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getInt(12));
            }
            cn.close();
        }
        return ac;
    }

// Check existed customer's account by email
    public static Customer ACCOUNT_checkExistedCustomerByEmail(String email) throws Exception {
        Customer ac = new Customer();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct name, email, gender, tel, DoB, Account.id, status, username, password, role, img, isDobSetup\n"
                    + "from Account, Customer\n"
                    + "where email = ? \n"
                    + "and Account.id = Customer.id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                ac = new Customer(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), sdf.parse(sdf.format(rs.getDate(5))), rs.getInt(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getInt(12));
            }
            cn.close();
        }
        return ac;
    }

// Get customer by id
    public static Customer ACCOUNT_getCustomerByID(int customerID) throws Exception {
        Customer ac = new Customer();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct name, email, gender, tel, DoB, Account.id, status, username, password, role, img, isDobSetup\n"
                    + "from Account, Customer\n"
                    + "where Account.id = ? \n"
                    + "and Account.id = Customer.id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                ac = new Customer(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), sdf.parse(sdf.format(rs.getDate(5))), rs.getInt(6), rs.getInt(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getInt(12));
            }
            cn.close();
        }
        return ac;
    }

// Check existed shop owner or admin's account by username and password
    public static Account ACCOUNT_checkExistedAccountByNamePass(String username, String pass) throws Exception {
        Account ac = new Account();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct id, status, username, password, role, img\n"
                    + "from Account\n"
                    + "where username = ?\n"
                    + "and password = ? Collate Latin1_General_CS_AS\n"
                    + "and (role = 'AD' or role = 'SO')";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, pass);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                ac = new Account(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
            }
            cn.close();
        }
        return ac;
    }

//Reset password by email
    public static boolean ACCOUNT_resetPasswordByEmail(String email, String pass) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Account\n"
                    + "set password = ?\n"
                    + "where id = \n"
                    + "(\n"
                    + "select id\n"
                    + "from Customer\n"
                    + "where email = ?\n"
                    + ")";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, pass);
            pst.setString(2, email);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Create customer's account by email
    public static Customer ACCOUNT_createCustomerAccountByEmail(String username, String password, String role, int status, String img, String email, String addresss, String tel) throws Exception {
        int id = ACCOUNT_getCreatedAccountID(username, password, role, status, img).getId();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Customer (id, name, email, gender, tel, Dob, isDobSetup)\n"
                    + "values (?,?,?,?,?,'2000-01-01 00:00:00.000',0)\n"
                    + "\n"
                    + "insert into Customer_Address (customerid, address, isChosen)\n"
                    + "values ((select id from Customer where email = ?), ?,0)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);
            pst.setString(2, username);
            pst.setString(3, email);
            pst.setString(4, "Not set");
            pst.setString(5, tel);
            pst.setString(6, email);
            pst.setString(7, addresss);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return ACCOUNT_checkExistedCustomerByEmailPass(email, password);
            }
            cn.close();
        }
        return null;
    }

    //--- Create account
    private static boolean ACCOUNT_createAccount(String username, String password, String role, int status, String img) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Account (username, password, role, status, img)\n"
                    + "values (?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, role);
            pst.setInt(4, status);
            pst.setString(5, img);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Get created account id to assign to customer's id
    private static Account ACCOUNT_getCreatedAccountID(String username, String password, String role, int status, String img) throws Exception {
        Account ac = new Account();
        if (ACCOUNT_createAccount(username, password, role, status, img)) {
            Connection cn = DBUtils.getConnection();

            if (cn != null) {
                String sql = "select id, status, username, password, role, img\n"
                        + "from Account\n"
                        + "where username = ? and password = ? COLLATE Latin1_General_CS_AS";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    ac = new Account(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
                }
                cn.close();
            }
        }
        return ac;
    }

// Update customer's account information NOT change Dob
    public static boolean ACCOUNT_updateCustomerAccount(String username, String img, int id, String name, String tel, String gender) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null && ACCOUNT_updateAccountInformation(username, img, id)) {
            String sql = "update Customer\n"
                    + "set\n"
                    + "name = ?,\n"
                    + "tel = ?,\n"
                    + "gender = ?\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, tel);
            pst.setString(3, gender);
            pst.setInt(4, id);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Update customer's account information change Dob
    public static boolean ACCOUNT_updateCustomerAccountDoB(String username, String img, int id, String name, String tel, String gender, java.util.Date Dob) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null && ACCOUNT_updateAccountInformation(username, img, id)) {
            String sql = "update Customer\n"
                    + "set\n"
                    + "name = ?,\n"
                    + "tel = ?,\n"
                    + "gender = ?,\n"
                    + "DoB = ?,\n"
                    + "isDobSetup = 1\n"
                    + "where id = ?";
            java.sql.Date newDob = new java.sql.Date(Dob.getTime());
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, tel);
            pst.setString(3, gender);
            pst.setDate(4, newDob);
            pst.setInt(5, id);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Update account information
    private static boolean ACCOUNT_updateAccountInformation(String username, String img, int id) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Account\n"
                    + "set\n"
                    + "username = ?,\n"
                    + "img = ?\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, img);
            pst.setInt(3, id);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Get customer's all addresses by customer's id
    public static ArrayList<String> ACCOUNT_getAllAddressByCustomerID(int customerID) throws Exception {
        ArrayList<String> listA = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select Customer_Address.id, customerid, address, phone, receiver, District.name, Province.name, isChosen\n"
                    + "from Customer_Address, District, Province\n"
                    + "where customerid = ? and districtid = District.id and District.provinceid = Province.id\n"
                    + "order by id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listA.add(rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getString(3) + "@" + rs.getString(4) + "@" + rs.getString(5) + "@" + rs.getString(6) + "@" + rs.getString(7) + "@" + rs.getInt(8));
                }
            }
            cn.close();
        }
        return listA;
    }

// Get customer's chosen address by customer's id
    public static String ACCOUNT_getChosenAddress(int customerID) throws Exception {
        String address = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select Customer_Address.id, customerid, address, phone, receiver, District.name, Province.name, isChosen\n"
                    + "from Customer_Address, District, Province\n"
                    + "where customerid = ? and isChosen = 1 and districtid = District.id and District.provinceid = Province.id\n"
                    + "order by id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    address = rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getString(3) + "@" + rs.getString(4) + "@" + rs.getString(5) + "@" + rs.getString(6) + "@" + rs.getString(7) + "@" + rs.getInt(8);
                }
            }
            cn.close();
        }
        return address;
    }

// Get customer's name by customer's id
    public static String ACCOUNT_getCustomerNameByCustomerID(int customerID) throws Exception {
        String name = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct name\n"
                    + "from Customer\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    name = rs.getString(1);
                }
            }
            cn.close();
        }
        return name;
    }

// Get customer's address by address' id (return district and province's name)
    public static String ACCOUNT_getAddressByIDReturnDisProName(int addressID) throws Exception {
        String address = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select Customer_Address.id, customerid, address, phone, receiver, District.name, Province.name, isChosen\n"
                    + "from Customer_Address, District, Province\n"
                    + "where Customer_Address.id = ? and districtid = District.id and District.provinceid = Province.id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, addressID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    address = rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getString(3) + "@" + rs.getString(4) + "@" + rs.getString(5) + "@" + rs.getString(6) + "@" + rs.getString(7) + "@" + rs.getInt(8);
                }
            }
            cn.close();
        }
        return address;
    }

// Get customer's address by address' id (return district and province's id)
    public static String ACCOUNT_getAddressByIDReturnDisProID(int addressID) throws Exception {
        String address = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select Customer_Address.id, customerid, address, phone, receiver, District.id, Province.id, isChosen\n"
                    + "from Customer_Address, District, Province\n"
                    + "where Customer_Address.id = ? and districtid = District.id and District.provinceid = Province.id";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, addressID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    address = rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getString(3) + "@" + rs.getString(4) + "@" + rs.getString(5) + "@" + rs.getInt(6) + "@" + rs.getString(7) + "@" + rs.getInt(8);
                }
            }
            cn.close();
        }
        return address;
    }

// Set customer's chosen address by address' id and customer's id
    public static boolean ACCOUNT_setChosenAddressByID(int addressID, int customerID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Customer_Address\n"
                    + "set isChosen = 1\n"
                    + "where id = ?\n"
                    + "\n"
                    + "update Customer_Address\n"
                    + "set isChosen = 0\n"
                    + "where customerid = ? and id <> ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, addressID);
            pst.setInt(2, customerID);
            pst.setInt(3, addressID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Add new customer's address
    public static void ACCOUNT_addAddress(int customerID, String address, String phone, String receiver, int districtID) throws Exception {
        int numberOfAddress = ACCOUNT_checkNumberOfAddress(customerID);
        int isChosen = 0;
        if (numberOfAddress == 0) {
            isChosen = 1;
        }
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Customer_Address(customerid, address, phone, receiver, districtid, isChosen)\n"
                    + "values (?,?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setString(2, address);
            pst.setString(3, phone);
            pst.setString(4, receiver);
            pst.setInt(5, districtID);
            pst.setInt(6, isChosen);
            pst.executeUpdate();
            cn.close();
        }
    }

    //--- Get number of address of customer (if 0 then new address auto be chosen)
    public static int ACCOUNT_checkNumberOfAddress(int customerID) throws Exception {
        int numberOfAddress = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select count(id)\n"
                    + "from Customer_Address\n"
                    + "where customerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                numberOfAddress = rs.getInt(1);
            }
            cn.close();
        }
        return numberOfAddress;
    }

// Update customer's address
    public static void ACCOUNT_updateAddress(int addressID, int customerID, String address, String phone, String receiver, int districtID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Customer_Address\n"
                    + "set address = ?, phone = ?, receiver = ?, districtid = ?\n"
                    + "where id = ? and customerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, address);
            pst.setString(2, phone);
            pst.setString(3, receiver);
            pst.setInt(4, districtID);
            pst.setInt(5, addressID);
            pst.setInt(6, customerID);
            int rs = pst.executeUpdate();
            cn.close();
        }
    }

// Delete customer's address by address' id
    public static void ACCOUNT_deleteAddress(int addressID, int customerID, int isChosen) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "";
            if (isChosen == 0) {
                sql = "delete from Customer_Address\n"
                        + "where id = ?";
            } else {
                sql = "delete from Customer_Address\n"
                        + "where id = ?\n"
                        + "\n"
                        + "update Customer_Address\n"
                        + "set isChosen = 1\n"
                        + "where id = (select top 1 id from Customer_Address where customerid = ? order by id desc)\n"
                        + "\n"
                        + "update Customer_Address\n"
                        + "set isChosen = 0\n"
                        + "where id <> (select top 1 id from Customer_Address where customerid = ? order by id desc) and customerid = ?";
            }

            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, addressID);
            if (isChosen != 0) {
                pst.setInt(2, customerID);
                pst.setInt(3, customerID);
                pst.setInt(4, customerID);
            }
            pst.executeUpdate();
            cn.close();
        }
    }

// Get customer notification
    public static ArrayList<String> ACCOUNT_getNotification(int customerID) throws Exception{
        ArrayList<String> listN = new ArrayList<>();
        
        return listN;
    }
    
    //--- Get customer feedback reply
    
//-----//
//-----//
//----------------------------- CANCELLATION -----------------------------//
//-----//
//-----//
// Add new cancellation
    public static void CANCELLATION_addCancelation(int orderID, String reason) throws Exception {
        java.sql.Date cancelDate = new java.sql.Date(new java.util.Date().getTime());
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Cancelation(reason, canceldate, orderid)\n"
                    + "values (?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, reason);
            pst.setDate(2, cancelDate);
            pst.setInt(3, orderID);
            pst.executeUpdate();
            cn.close();
        }
    }

//-----//
//-----//
//----------------------------- CART -----------------------------//
//-----//
//-----//
// Update cart (use for add to cart)
    public static boolean CART_updateCart(int productID, int customerID, int quantity) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            if (CART_getCartDetail(productID, customerID)) {
                if (CART_updateCartQuantity(productID, customerID, quantity)) {
                    return true;
                }
            } else {
                if (CART_checkAccountCart(customerID) && CART_createNewForAccExisted(productID, customerID, quantity)) {
                    return true;
                }
                if (!CART_checkAccountCart(customerID) && CART_createNewForAccNotExisted(productID, customerID, quantity)) {
                    return true;
                }
            }
        }
        return false;
    }

    //--- Get cart detail (null if dont have)
    private static boolean CART_getCartDetail(int productID, int customerID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, customerid, productid, quantity\n"
                    + "from Cart, Cart_Details\n"
                    + "where id = cartid and customerid = ? and productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setInt(2, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Check if customer have added to cart before
    private static boolean CART_checkAccountCart(int customerID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, customerid\n"
                    + "from Cart\n"
                    + "where customerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Update cart quantity
    private static boolean CART_updateCartQuantity(int productID, int customerID, int quantity) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Cart_Details\n"
                    + "set quantity = quantity + ?\n"
                    + "where cartid = (select id from Cart where customerid = ?) and productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, quantity);
            pst.setInt(2, customerID);
            pst.setInt(3, productID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Create new cart when account already existed
    private static boolean CART_createNewForAccExisted(int productID, int customerID, int quantity) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Cart_Details(cartid, productid, quantity)\n"
                    + "values((select id from Cart where customerid = ?), ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setInt(2, productID);
            pst.setInt(3, quantity);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Create new cart when account NOT existed
    private static boolean CART_createNewForAccNotExisted(int productID, int customerID, int quantity) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Cart(customerid)\n"
                    + "values(?)\n"
                    + "\n"
                    + "insert into Cart_Details(cartid, productid, quantity)\n"
                    + "values((select id from Cart where customerid = ?), ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setInt(2, customerID);
            pst.setInt(3, productID);
            pst.setInt(4, quantity);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Update new quantity for cart (use in edit quantity in cart)
    public static boolean CART_updateNewQuantity(int customerID, int productID, int newQuantity) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Cart_Details\n"
                    + "set quantity = ?\n"
                    + "where cartid = (select id from Cart where customerid = ?) and productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, newQuantity);
            pst.setInt(2, customerID);
            pst.setInt(3, productID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Count total item in cart
    public static int CART_countNumberOfItemInCart(int customerID) throws Exception {
        int result = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select count(productid)\n"
                    + "from Cart_Details, Cart\n"
                    + "where cartid = id and customerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                result = rs.getInt(1);
            }
            cn.close();
        }
        return result;
    }

// Get all item in cart
    public static ArrayList<Item> CART_getAllItemInCart(int customerID) throws Exception {
        ArrayList<Item> listI = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select productid, quantity\n"
                    + "from Cart, Cart_Details\n"
                    + "where id = cartid and customerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listI.add(new Item(rs.getInt(1), rs.getInt(2)));
                }
            }
            cn.close();
        }
        return listI;
    }

// Get item by product's id and customer's id
    public static boolean CART_getItemByID(int customerID, int productID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, customerid, productid, quantity\n"
                    + "from Cart, Cart_Details\n"
                    + "where id = cartid and customerid = ? and productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setInt(2, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Remove cart by customer's id
    public static boolean CART_removeCartByCustomerID(int customerID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "delete from Cart_Details\n"
                    + "where cartid = (select id from Cart where customerid = ?)\n"
                    + "\n"
                    + "delete from Cart\n"
                    + "where customerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setInt(2, customerID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }

        return false;
    }

// Remove item in cart by product's id and customer's id
    public static boolean CART_removeCartItemByID(int productID, int customerID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "delete from Cart_Details\n"
                    + "where cartid = (select id from Cart where customerid = ?) and productid = ?\n";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            pst.setInt(2, productID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }

        return false;
    }

//-----//
//-----//
//----------------------------- CATEGORY -----------------------------//
//-----//
//-----//
// Get all categories
    public static ArrayList<Category> CATEGORY_getAllCate() throws Exception {
        ArrayList<Category> listC = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, name, img, code\n"
                    + "from Category";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listC.add(new Category(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
                }
            }
            cn.close();
        }

        return listC;
    }

// Get category's id by code
    public static int CATEGORY_getIDByCode(String code) throws Exception {
        int id = -1;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id\n"
                    + "from Category\n"
                    + "where code = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                id = rs.getInt(1);
            }
            cn.close();
        }
        return id;
    }

// Get category's name by id
    public static String CATEGORY_getNameByID(int cateID) throws Exception {
        String name = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name\n"
                    + "from Category\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, cateID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                name = rs.getString(1);
            }
            cn.close();
        }
        return name;
    }

//-----//
//-----//
//----------------------------- DATESTRINGCONVERTER -----------------------------//
//-----//
//-----//
// Convert String to SQL Date
    public static java.sql.Date DATESTRINGCONVERTER_convertStringToSQLDate(String s) throws Exception {
        java.sql.Date d = new java.sql.Date(sdf.parse(s).getTime());
        return d;
    }

// Convert Util Date to String
    public static String DATESTRINGCONVERTER_convertUtilDateToString(java.util.Date date) throws Exception {
        return sdf.format(date);
    }

// Convert Util Date to String in Check out
    public static String DATESTRINGCONVERTER_convertUtilDateToStringInCheckOut(java.util.Date date, int numberOfDayAdded) throws Exception {
        java.util.Date d = new java.util.Date(date.getTime() + 1000 * 60 * 60 * 24 * numberOfDayAdded);
        return sdfco.format(d);
    }

// Convert Util Date to SQL Date
    public static java.sql.Date DATESTRINGCONVERTER_convertUtilDateToSQLDate(java.util.Date date, int numberOfDayAdded) throws Exception {
        long da = date.getTime() + 1000 * 60 * 60 * 24 * numberOfDayAdded;
        java.sql.Date d = new java.sql.Date(da);
        return d;
    }

// Convert SQL Date to Util Date
    public static java.util.Date DATESTRINGCONVERTER_convertSQLDatetoUtilDate(java.sql.Date date) throws Exception {
        return sdf.parse(DATESTRINGCONVERTER_convertUtilDateToString(date));
    }

// Convert String to Util Date
    public static java.util.Date DATESTRINGCONVERTER_convertStringToUtilDate(String s) throws Exception {
        return DATESTRINGCONVERTER_convertSQLDatetoUtilDate(DATESTRINGCONVERTER_convertStringToSQLDate(s));
    }

//-----//
//-----//
//----------------------------- DISCOUNT -----------------------------//
//-----//
//-----//
// Get discount percentage by product's id
    public static float DISCOUNT_getDiscountPercentageByProductID(int productID) throws Exception {
        float discount = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select discountChoice\n"
                    + "from Discount_Details\n"
                    + "where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    discount = rs.getFloat(1) / 100;
                }
            }
            cn.close();
        }

        return discount;
    }

// Get full discount's information by product's id
    public static Discount DISCOUNT_getDiscountInformationByProductID(int productID) throws Exception {
        Discount d = new Discount();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select productid, discountChoice, startdate, enddate, id, isFreeShip\n"
                    + "from Discount_Details\n"
                    + "where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                d = new Discount(rs.getInt(1),
                        rs.getFloat(2),
                        BirdPeeDAO.DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(3)),
                        BirdPeeDAO.DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)),
                        rs.getInt(5),
                        rs.getInt(6));
            }
            cn.close();
        }
        return d;
    }

//-----//
//-----//
//----------------------------- ORDER -----------------------------//
//-----//
//-----//
// Get all order by customer's id
    public static ArrayList<Order> ORDER_getAllOrderItem(int customerID, String sort) throws Exception {
        ArrayList<Order> listO = new ArrayList<>();
        Connection cn = DBUtils.getConnection();
        String sql = "";

        if (cn != null) {
            switch (sort) {
                case "Last 5 days":
                    sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                            + "from Orders\n"
                            + "where customerid = ? and createdate >= DATEADD(day, -5, GETDATE())\n"
                            + "order by id desc";
                    break;
                case "Last 15 days":
                    sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                            + "from Orders\n"
                            + "where customerid = ? and createdate >= DATEADD(day, -15, GETDATE())\n"
                            + "order by id desc";
                    break;
                case "Last 30 days":
                    sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                            + "from Orders\n"
                            + "where customerid = ? and createdate >= DATEADD(day, -30, GETDATE())\n"
                            + "order by id desc";
                    break;
                case "All Orders":
                    sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                            + "from Orders\n"
                            + "where customerid = ?\n"
                            + "order by id desc";
                    break;
            }
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listO.add(new Order(rs.getInt(1),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(2)),
                            rs.getString(3),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)),
                            rs.getInt(5),
                            rs.getInt(6),
                            rs.getInt(7),
                            rs.getInt(8),
                            rs.getInt(9),
                            rs.getInt(10), SHOPOWNER_getAllOrderItem(rs.getInt(1))));
                }
            }
            cn.close();
        }
        return listO;
    }

// Get order status by order id
    public static String ORDER_getOrderStatus(int orderID) throws Exception {
        String status = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select Order_Status.status\n"
                    + "from Orders, Order_Status\n"
                    + "where Order_Status.id = Orders.status and Orders.id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                status = rs.getString(1);
            }
        }
        return status;
    }

// Get order by order id
    public static Order ORDER_getOrderByID(int orderID) throws Exception {
        Order o = new Order();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                    + "from Orders\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                o = new Order(rs.getInt(1),
                        DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(2)),
                        rs.getString(3),
                        DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)),
                        rs.getInt(5),
                        rs.getInt(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getInt(9),
                        rs.getInt(10), SHOPOWNER_getAllOrderItem(rs.getInt(1)));
            }
        }
        return o;
    }

// Get payment method by payment method id
    public static String ORDER_getPaymentMethod(int paymentMethodID) throws Exception {
        String paymentMethod = null;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select method\n"
                    + "from Payment_Method\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, paymentMethodID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                paymentMethod = rs.getString(1);
            }
            cn.close();
        }
        return paymentMethod;
    }

// Change order status
    public static boolean ORDER_changeStatus(int orderID, int newStatus) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Orders\n"
                    + "set status = ?\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, newStatus);
            pst.setInt(2, orderID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Add to order after check out succesfully
    public static void ORDER_addToOrderAfterCheckOut(ArrayList<Item> listI, String shipChoice, String shipAddress, String paymentMethod, int customerid) throws Exception {
        java.sql.Date shipdate = null;
        int paymenttype = 0;
        int paymentmethod = 0;
        java.sql.Date createDate = new java.sql.Date(new java.util.Date().getTime());
        int shipid = 0;
        int shipDistanceID = 0;

        switch (paymentMethod) {
            case "cod":
                paymentmethod = 1;
                paymenttype = 1;
                break;
            case "vnpay":
                paymentmethod = 2;
                paymenttype = 2;
                break;
        }

        switch (shipChoice) {
            case "economy":
                shipid = 1;
                break;
            case "standard":
                shipid = 2;
                break;
            case "fast":
                shipid = 3;
                break;
        }

        ArrayList<Integer> listShopID = new ArrayList<>();

        for (Item item : listI) {
            int id = SHOP_getShopByProductID(item.getProductID()).getId();
            for (Integer sid : listShopID) {
                if (sid == id) {
                    listShopID.remove(sid);
                    break;
                }
            }
            listShopID.add(id);
        }

        for (Integer sid : listShopID) {
            shipdate = SHIP_getShipDate(shipid, shipAddress, SHOP_getShopLocation(sid));
            shipDistanceID = SHIP_checkLocation(shipAddress, SHOP_getShopLocation(sid));
            if (ORDER_addToOrders(shipdate, shipAddress, createDate, paymenttype, paymentmethod, customerid, shipid, shipDistanceID)) {
                for (Item item : listI) {
                    if (SHOP_getShopByProductID(item.getProductID()).getId() == sid) {
                        ORDER_addToOrdersDetail(customerid, item.getProductID(), PRODUCT_getProductByID(item.getProductID()).getName(), item.getQuantity(), PRODUCT_getProductDiscountOrNotByID(item.getProductID()), SHIP_getShipPrice(shipDistanceID, shipid));
                    }
                }
            }
        }
    }

    //--- Add to Orders
    private static boolean ORDER_addToOrders(java.sql.Date shipDate, String shipAddress, java.sql.Date createDate, int paymentTypeID, int paymentMethodID, int customerID, int shipID, int shipDistanceID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Orders(shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid)\n"
                    + "values (?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setDate(1, shipDate);
            pst.setString(2, shipAddress);
            pst.setDate(3, createDate);
            pst.setInt(4, 2);
            pst.setInt(5, paymentTypeID);
            pst.setInt(6, paymentMethodID);
            pst.setInt(7, customerID);
            pst.setInt(8, shipID);
            pst.setInt(9, shipDistanceID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Get lastest order id
    private static int ORDER_getLastestOrderID(int customerID) throws Exception {
        int id = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select top 1 id\n"
                    + "from Orders\n"
                    + "where customerid = ?\n"
                    + "order by id desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, customerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                id = rs.getInt(1);
            }
        }
        return id;
    }

    //--- Add to Order detail
    private static boolean ORDER_addToOrdersDetail(int customerID, int productID, String productName, int quantity, float initPrice, float shipPrice) throws Exception {
        int orderID = ORDER_getLastestOrderID(customerID);
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Order_Details(orderid, productid, productname, quantity, initprice, shipprice)\n"
                    + "values(?,?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            pst.setInt(2, productID);
            pst.setString(3, productName);
            pst.setInt(4, quantity);
            pst.setFloat(5, initPrice);
            pst.setFloat(6, shipPrice);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Get sub total of order
    public static int ORDER_getSubTotal(int orderID) throws Exception {
        int subTotal = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select SUM(initprice * quantity)\n"
                    + "from Order_Details\n"
                    + "where orderid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                subTotal = rs.getInt(1);
            }
            cn.close();
        }
        return subTotal;
    }

// Get ship price of order
    public static int ORDER_getShipPrice(int orderID) throws Exception {
        int subTotal = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select SUM(shipprice * quantity)\n"
                    + "from Order_Details\n"
                    + "where orderid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                subTotal = rs.getInt(1);
            }
            cn.close();
        }
        return subTotal;
    }
//-----//
//-----//
//----------------------------- PRODUCT -----------------------------//
//-----//
//-----//
// Get all products after sorted by sort and sub-sort

    public static ArrayList<Product> PRODUCT_getAllProductAfterSorted(String sort, String subSort) throws Exception {
        ArrayList<Product> listP = new ArrayList<>();
        Connection cn = DBUtils.getConnection();
        String sql = null;
        String subSql = null;
        int defaultRating = 0;
        if (cn != null) {
            if (!subSort.equalsIgnoreCase("none")) {
                if (CATEGORY_getIDByCode(subSort) != -1) {
                    subSql = "and cateid = " + CATEGORY_getIDByCode(subSort) + "\n";
                } else {
                    if (SHIP_getProvinceNameByCode(subSort)) {
                        subSql = "and shopid = Shop.id and districtid in (select id from District where provinceid in (select id from Province where code = '" + subSort + "'))\n";
                    }
                }
            }
            switch (sort) {
                case "Popular":
                    sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price\n"
                            + "from Product" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and availableQuantity > 0 " + ((subSql == null) ? "\n" : subSql)
                            + "order by soldQuantity desc";
                    break;
                case "Discount":
                    sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, discountChoice\n"
                            + "from Product, Discount_Details" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and isDiscount = 1 and Product.id = productid and availableQuantity > 0 " + ((subSql == null) ? "\n" : (subSql + "\n"))
                            + "order by discountChoice desc";
                    break;
                case "Rating":
                    sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, round(AVG(?), 0, 1) as rating\n"
                            + "from Product" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and availableQuantity > 0 and Product.id not in\n"
                            + "(\n"
                            + "select Product.id\n"
                            + "from Product, Feedback\n"
                            + "where Product.status = 'Available' and productid = Product.id \n"
                            + ") " + ((subSql == null) ? "\n" : subSql)
                            + "group by Product.status, soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price\n"
                            + "\n"
                            + "UNION ALL\n"
                            + "\n"
                            + "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, round(AVG(rating), 0, 1) as rating\n"
                            + "from Product, Feedback" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and productid = Product.id and availableQuantity > 0 " + ((subSql == null) ? "\n" : subSql)
                            + "group by soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, Product.status\n"
                            + "order by rating desc;";
                    break;
                case "Price Ascending":
                    sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, (price * (100 - discountChoice) / 100) as discountprice\n"
                            + "from Product, Discount_Details" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and availableQuantity > 0 and productid = Product.id and isDiscount = 1 " + ((subSql == null) ? "\n" : subSql)
                            + "\n"
                            + "union all\n"
                            + "\n"
                            + "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, price as discountprice\n"
                            + "from Product" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and availableQuantity > 0 and isDiscount = 0 " + ((subSql == null) ? "\n" : subSql)
                            + "order by price";
                    break;
                case "Price Descending":
                    sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, (price * (100 - discountChoice) / 100) as discountprice\n"
                            + "from Product, Discount_Details" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and availableQuantity > 0 and productid = Product.id and isDiscount = 1 " + ((subSql == null) ? "\n" : subSql)
                            + "\n"
                            + "union all\n"
                            + "\n"
                            + "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price, price as discountprice\n"
                            + "from Product" + ((subSql == null) ? "\n" : ", Shop\n")
                            + "where Product.status = 'Available' and availableQuantity > 0 and isDiscount = 0 " + ((subSql == null) ? "\n" : subSql)
                            + "order by discountprice desc";
                    break;
                default:
                    sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price\n"
                            + "from Product\n"
                            + "where Product.status = 'Available' and name like '%" + sort + "%'";
                    break;
            }
            PreparedStatement pst = cn.prepareStatement(sql);
            if (sort.equalsIgnoreCase("Rating")) {
                pst.setInt(1, defaultRating);
            }
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listP.add(new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), rs.getFloat(9)));
                }
            }
            cn.close();
        }
        return listP;
    }

// Get rating of product by product's id
    public static int PRODUCT_getRatingByID(int productID) throws Exception {
        int rating = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select round(AVG(rating), 0, 1)\n"
                    + "from Product, Feedback\n"
                    + "where Product.status = 'Available' and productid = Product.id and Product.id = ?\n"
                    + "group by Product.id, Product.status";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    rating = rs.getInt(1);
                }
            }
            cn.close();
        }

        return rating;
    }

// Get all discounted products
    public static ArrayList<Product> PRODUCT_getAllDiscountProduct() throws Exception {
        ArrayList<Product> listP = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select top 8 soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, description, price\n"
                    + "from Product, Discount_Details\n"
                    + "where Product.status = 'Available' and isDiscount = 1 and Product.id = productid\n"
                    + "order by discountChoice desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listP.add(new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), rs.getFloat(9)));
                }
            }
            cn.close();
        }

        return listP;
    }

// Get all hot products
    public static ArrayList<Product> PRODUCT_getAllHotProduct() throws Exception {
        ArrayList<Product> listP = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select top 8 soldQuantity, availableQuantity, cateid, isDiscount, shopid, id, Product.name, description, price\n"
                    + "from Product\n"
                    + "where Product.status = 'Available' and soldQuantity > 0\n"
                    + "order by soldQuantity desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listP.add(new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), rs.getFloat(9)));
                }
            }
            cn.close();
        }

        return listP;
    }

// Get all images by product's id
    public static ArrayList<String> PRODUCT_getImages(int productID) throws Exception {
        ArrayList<String> listI = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select img\n"
                    + "from Product_img\n"
                    + "where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listI.add(rs.getString(1));
                }
            }
            cn.close();
        }
        return listI;
    }

// Get product by product's id
    public static Product PRODUCT_getProductByID(int productID) throws Exception {
        Product p = new Product();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price\n"
                    + "from Product\n"
                    + "where Product.status = 'Available' and id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    p = new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), rs.getFloat(9));
                }
            }
            cn.close();
        }
        return p;
    }

// Get init price or discount if product is discount
    public static float PRODUCT_getProductDiscountOrNotByID(int productID) throws Exception {
        float price = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct (price * (100 - discountChoice) / 100) as price\n"
                    + "from Product, Discount_Details\n"
                    + "where Product.status = 'Available' and productid = Product.id and isDiscount = 1 and Product.id = ?\n"
                    + "\n"
                    + "union \n"
                    + "\n"
                    + "select distinct price\n"
                    + "from Product\n"
                    + "where Product.status = 'Available' and isDiscount = 0 and id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            pst.setInt(2, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    price = rs.getFloat(1);
                }
            }
            cn.close();
        }
        return price;
    }

// Get description base on type
    public static String PRODUCT_getDescription(String typeOfDescription, String description) throws Exception {
        String desc = null;
        switch (typeOfDescription) {
            case "short":
                desc = PRODUCT_getShortDescription(description);
                break;
            case "full":
                desc = PRODUCT_getFullDescription(description);
                break;
        }
        return desc;
    }

    //--- Short type
    private static String PRODUCT_getShortDescription(String description) throws Exception {
        String sdesc = "No description for this product";
        int rs = PRODUCT_checkDescription(description);
        if (rs > 1) {
            sdesc = description.split("@")[0];
        }
        return sdesc;
    }

    //--- Full type
    private static String PRODUCT_getFullDescription(String description) throws Exception {
        String fdesc = description;
        int rs = PRODUCT_checkDescription(description);
        if (rs > 1) {
            fdesc = description.substring(description.indexOf("@") + 1);
        }
        return fdesc;
    }

    //--- Check if description is valid
    private static int PRODUCT_checkDescription(String description) throws Exception {
        String s[] = description.split("@");
        return s.length;
    }

// Get top 8 related products by category's id
    public static ArrayList<Product> PRODUCT_getRelatedProduct(int cateID) throws Exception {
        ArrayList<Product> listP = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select top 8 soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, description, price\n"
                    + "from Product\n"
                    + "where Product.status = 'Available' and cateid = ?\n"
                    + "order by id desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, cateID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listP.add(new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), rs.getFloat(9)));
                }
            }
            cn.close();
        }
        return listP;
    }

// Get product's status by product's id
    public static String PRODUCT_getProductStatusByID(int productID) throws Exception {
        String status = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select status\n"
                    + "from Product\n"
                    + "where Product.status = 'Available' and id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                status = rs.getString(1);
            }
            cn.close();
        }
        return status;
    }

// Update product's quantity after check out
    public static void PRODUCT_updateProductQuantityAfterCheckOut(int quantity, int productID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Product\n"
                    + "set \n"
                    + "availableQuantity = availableQuantity - ?,\n"
                    + "soldQuantity = soldQuantity + ?\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, quantity);
            pst.setInt(2, quantity);
            pst.setInt(3, productID);
            pst.executeUpdate();
            cn.close();
        }
    }

// Send feedback
    public static void PRODUCT_sendFeedback(String comment, int rating, int customerID, int productID, int orderID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Feedback(comment, rating, date, customerid, productid, isReported, reply, status, orderid)\n"
                    + "values(?,?,GETDATE(),?,?,0,'',0,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, comment);
            pst.setInt(2, rating);
            pst.setInt(3, customerID);
            pst.setInt(4, productID);
            pst.setInt(5, orderID);
            pst.executeUpdate();
            cn.close();
        }
    }

// Check if send feedback or not
    public static boolean PRODUCT_checkExistedFeedback(int orderID, int productID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id from Feedback where orderid = ? and productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            pst.setInt(2, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                return true;
            }
            cn.close();
        }
        return false;
    }
//-----//
//-----//
//----------------------------- SHIP -----------------------------//
//-----//
//-----//
// Get province's name by province's code

    public static boolean SHIP_getProvinceNameByCode(String code) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name\n"
                    + "from Province\n"
                    + "where code = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, code);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                return true;
            }
            cn.close();
        }
        return false;
    }

// Get province's name by province's id
    public static String SHIP_getProvinceNameByID(String provinceid) throws Exception {
        String name = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name\n"
                    + "from Province\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, provinceid);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                name = rs.getString(1);
            }
            cn.close();
        }
        return name;
    }

// Get district's name by id
    public static String SHIP_getDistrictNameByID(String districtID) throws Exception {
        String name = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name\n"
                    + "from District\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, districtID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                name = rs.getString(1);
            }
            cn.close();
        }
        return name;
    }

// Get all province
    public static ArrayList<String> SHIP_getAllProvince() throws Exception {
        ArrayList<String> province = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name, id\n"
                    + "from Province";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    province.add(rs.getString(1) + "@" + rs.getString(2));
                }
            }
            cn.close();
        }
        return province;
    }

// Get all district belongs to province by province's id
    public static ArrayList<String> SHIP_getDistrictByProvinceID(String provinceID) throws Exception {
        ArrayList<String> district = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name, id\n"
                    + "from District\n"
                    + "where provinceid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, provinceID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    district.add(rs.getString(1) + "@" + rs.getString(2));
                }
            }
            cn.close();
        }
        return district;
    }

//Get province id by shop id
    public static String SHIP_getProvinceIDByShopID(int shopID) throws Exception {
        Connection cn = DBUtils.getConnection();
        String provinceID = "";

        if (cn != null) {
            String sql = "select id\n"
                    + "from Province\n"
                    + "where id = (select provinceid from District where id = (select districtid from Shop where id = ?))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                provinceID = rs.getString(1);
            }
            cn.close();
        }
        return provinceID;
    }

//Get district id by shop id
    public static String SHIP_getDistrictIDByShopID(int shopID) throws Exception {
        Connection cn = DBUtils.getConnection();
        String districtID = "";

        if (cn != null) {
            String sql = "select districtid from Shop where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                districtID = rs.getString(1);
            }
            cn.close();
        }
        return districtID;
    }

// Get all ship types
    public static ArrayList<String> SHIP_getAllShipType() throws Exception {
        ArrayList<String> listS = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select type, id\n"
                    + "from Order_Ship";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listS.add(rs.getString(1) + "@" + rs.getInt(2));
                }
            }
            cn.close();
        }
        return listS;
    }

// Get shipdate
    public static java.sql.Date SHIP_getShipDate(int shipID, String customerAddress, String shopAddress) throws Exception {
        java.util.Date date = new java.util.Date();
        int shipDelay = SHIP_getShipDelay(shipID);
        int shipDuration = SHIP_getShipDuration(customerAddress, shopAddress);
        return DATESTRINGCONVERTER_convertUtilDateToSQLDate(date, shipDelay + shipDuration);
    }

// Get ship delay
    public static int SHIP_getShipDelay(int shipID) throws Exception {
        int shipDelay = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select shipDelay\n"
                    + "from Order_Ship\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shipID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                shipDelay = rs.getInt(1);
            }
            cn.close();
        }
        return shipDelay;
    }

// Get ship duration
    public static int SHIP_getShipDuration(String customerAddress, String shopAddress) throws Exception {
        int shipDuration = 0;
        int id = SHIP_checkLocation(customerAddress, shopAddress);
        Connection cn = DBUtils.getConnection();

        if (cn != null && id > 0) {
            String sql = "select duration\n"
                    + "from Ship_Distance\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                shipDuration = rs.getInt(1);
            }
            cn.close();
        }
        return shipDuration;
    }

// Get ship's price
    public static float SHIP_getShipPrice(int shipdistanctID, int shipID) throws Exception {
        float price = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select ROUND((initPrice * distance), 0, 0) as total\n"
                    + "from Order_Ship, Ship_Distance\n"
                    + "where Ship_Distance.id = ? and Order_Ship.id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shipdistanctID);
            pst.setInt(2, shipID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                price = rs.getFloat(1);
            }
            cn.close();
        }
        return price;
    }

// Get ship init price
    public static int SHIP_getInitShipPrice(int shipID) throws Exception {
        int price = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select initPrice\n"
                    + "from Order_Ship\n"
                    + "where Order_Ship.id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shipID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                price = rs.getInt(1);
            }
            cn.close();
        }
        return price;
    }

// Get ship distance
    public static float SHIP_getShipDistance(int shipdistanctID) throws Exception {
        float distance = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select ROUND((distance), 0, 0)\n"
                    + "from Ship_Distance\n"
                    + "where Ship_Distance.id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shipdistanctID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                distance = rs.getFloat(1);
            }
            cn.close();
        }
        return distance;
    }

// Get ship type by ship's id
    public static String SHIP_getShipType(int shipID) throws Exception {
        String type = null;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select type\n"
                    + "from Order_Ship where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shipID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    type = rs.getString(1);
                }
            }
            cn.close();
        }
        return type;
    }

// Check location
    public static int SHIP_checkLocation(String customerAddress, String shopAddress) throws Exception {
        int id = -1;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select id\n"
                    + "from Ship_Distance\n"
                    + "where departure like ? and destination like ?";
            PreparedStatement pst = cn.prepareStatement(sql);

            pst.setString(1, "%" + customerAddress + "%");
            pst.setString(2, "%" + shopAddress + "%");
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                id = rs.getInt(1);
            } else {
                sql = "select id\n"
                        + "from Ship_Distance\n"
                        + "where departure like ? and destination like ?";
                pst = cn.prepareStatement(sql);
                pst.setString(2, "%" + customerAddress + "%");
                pst.setString(1, "%" + shopAddress + "%");
                rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    id = rs.getInt(1);
                } else {
                    id = 1226;
                }
            }
            cn.close();
        }
        return id;
    }

//-----//
//-----//
//----------------------------- SHOP -----------------------------//
//-----//
//-----//
// Get shop by product's id
    public static Shop SHOP_getShopByProductID(int productID) throws Exception {
        Shop s = new Shop();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, ownerid, name, img, description, createdate\n"
                    + "from Shop\n"
                    + "where id = \n"
                    + "(\n"
                    + "select shopid\n"
                    + "from Product\n"
                    + "where id = ?\n"
                    + ")";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    s = new Shop(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(6)));
                }
            }
            cn.close();
        }

        return s;
    }

// Get all shops after sort by sort
    public static ArrayList<Shop> SHOP_getAllShopAfterSorted(String sort) throws Exception {
        ArrayList<Shop> listS = new ArrayList<>();
        Connection cn = DBUtils.getConnection();
        String sql = null;

        if (cn != null) {
            switch (sort) {
                case "Newest":
                    sql = "select id, ownerid, name, img, description, createdate\n"
                            + "from Shop\n"
                            + "order by id desc";
                    break;
                case "A to Z":
                    sql = "select id, ownerid, name, img, description, createdate\n"
                            + "from Shop\n"
                            + "order by name";
                    break;
                case "Z to A":
                    sql = "select id, ownerid, name, img, description, createdate\n"
                            + "from Shop\n"
                            + "order by name desc";
                    break;
                case "Popular":
                    sql = "select id, ownerid, name, img, description, createdate\n"
                            + "from Shop, Shop_Follower\n"
                            + "where id = shopid and id in (select shopid from Shop_Follower)\n"
                            + "group by id, ownerid, name, img, description, createdate, rating\n"
                            + "order by count(customerid) desc";
                    break;
                case "Rating":
                    sql = "select id, ownerid, name, img, description, createdate\n"
                            + "from Shop";
                    break;
            }

            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listS.add(new Shop(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(6))));
                }
            }
            if (sort.equalsIgnoreCase("Rating")) {
                for (int i = 0; i < listS.size(); i++) {
                    for (int j = i + 1; j < listS.size(); j++) {
                        if (SHOPOWNER_getRating(listS.get(i).getId()) < SHOPOWNER_getRating(listS.get(j).getId())) {
                            Shop s = listS.get(i);
                            listS.set(i, listS.get(j));
                            listS.set(j, s);
                        }
                    }
                }
            }
            cn.close();
        }

        return listS;
    }

// Count number of product in shop
    public static int SHOP_countNumberOfProduct(int shopID) throws Exception {
        int count = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select count(id)\n"
                    + "from Product\n"
                    + "where shopid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    count = rs.getInt(1);
                }
            }
            cn.close();
        }

        return count;
    }

// Count number of feedback of shop
    public static int SHOP_countNumberOfFeedback(int shopID) throws Exception {
        ArrayList<Integer> listI = SHOP_getAllProductIDInShop(shopID);
        int sum = 0;
        for (Integer i : listI) {
            sum += SHOP_countFeedbackPerProduct(i);
        }
        return sum;
    }

// Count number of feedback of product by product's id
    public static int SHOP_countFeedbackPerProduct(int productid) throws Exception {
        int count = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select count(id)\n"
                    + "from Feedback\n"
                    + "where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productid);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    count = rs.getInt(1);
                }
            }
            cn.close();
        }

        return count;
    }

// Get all product's id in shop by shop's id
    public static ArrayList<Integer> SHOP_getAllProductIDInShop(int shopID) throws Exception {
        ArrayList<Integer> listI = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id\n"
                    + "from Product\n"
                    + "where shopid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listI.add(rs.getInt(1));
                }
            }
            cn.close();
        }

        return listI;
    }

// Get shop's location by shop's id
    public static String SHOP_getShopLocation(int shopID) throws Exception {
        String location = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name\n"
                    + "from Province\n"
                    + "where id = (select provinceid from District where id = (select districtid from Shop where id = ?))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    location = rs.getString(1);
                }
            }
            cn.close();
        }
        return location;
    }

// Get locations of all shops
    public static ArrayList<String> SHOP_getLocationOfAllShop() throws Exception {
        ArrayList<String> listL = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select name, code\n"
                    + "from Province\n"
                    + "where id in (select provinceid from District where id in (select districtid from Shop))";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listL.add(rs.getString(1) + "@" + rs.getString(2));
                }
            }
            cn.close();
        }
        return listL;
    }

//-----//
//-----//
//----------------------------- SHOPOWNER -----------------------------//
//-----//
//-----//
// Get product by product's id
    public static Product SHOPOWNER_getProductByID(int productID) throws Exception {
        Product p = new Product();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select distinct soldQuantity, availableQuantity, cateid, isDiscount, shopid, Product.id, Product.name, Product.description, price\n"
                    + "from Product\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    p = new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getString(8), rs.getFloat(9));
                }
            }
            cn.close();
        }
        return p;
    }

// Get product's status by product's id
    public static String SHOPOWNER_getProductStatusByID(int productID) throws Exception {
        String status = "";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select status\n"
                    + "from Product\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                status = rs.getString(1);
            }
            cn.close();
        }
        return status;
    }

// Get shop by owner's id
    public static Shop SHOPOWNER_findShopByOwnerId(int ownerID) throws Exception {
        Shop s = new Shop();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, ownerid, name, img, description, createdate\n"
                    + "from Shop\n"
                    + "where ownerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    s = new Shop(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(6)));
                }
            }
            cn.close();
        }

        return s;
    }

// Get all orders
    public static ArrayList<Order> SHOPOWNER_getAllOrder() throws Exception {
        ArrayList<Order> listO = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                    + "from Orders\n"
                    + "order by id desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listO.add(new Order(rs.getInt(1),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(2)),
                            rs.getString(3),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)),
                            rs.getInt(5),
                            rs.getInt(6),
                            rs.getInt(7),
                            rs.getInt(8),
                            rs.getInt(9),
                            rs.getInt(10), SHOPOWNER_getAllOrderItem(rs.getInt(1))));
                }
            }
            cn.close();
        }
        return listO;
    }

// Get all order's item by order
    public static ArrayList<OrderDetails> SHOPOWNER_getAllOrderItem(int orderID) throws Exception {
        ArrayList<OrderDetails> listOI = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, orderid, productid, productname, quantity, initprice, shipprice\n"
                    + "from Order_Details\n"
                    + "where orderid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, orderID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listOI.add(new OrderDetails(rs.getInt(1),
                            rs.getInt(2),
                            rs.getInt(3),
                            rs.getString(4),
                            rs.getInt(5),
                            rs.getFloat(6),
                            rs.getFloat(7)));
                }
            }
            cn.close();
        }
        return listOI;
    }

// Get all order after sort
    public static ArrayList<Order> SHOPOWNER_getAllOrderItemBySort(String sort) throws Exception {
        ArrayList<Order> listO = new ArrayList<>();
        int flag = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                    + "from Orders\n"
                    + "order by id desc";
            if (!sort.isEmpty()) {
                switch (sort) {
                    case "Cancel":
                        sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                                + "from Orders\n"
                                + "where status = 1\n"
                                + "order by id desc";
                        break;

                    case "Processing":
                        sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                                + "from Orders\n"
                                + "where status = 2\n"
                                + "order by id desc";
                        break;
                    case "Packed":
                        sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                                + "from Orders\n"
                                + "where status = 3\n"
                                + "order by id desc";
                        break;
                    case "InDelivery":
                        sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                                + "from Orders\n"
                                + "where status = 4\n"
                                + "order by id desc";
                        break;
                    case "Successful":
                        sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                                + "from Orders\n"
                                + "where status = 5\n"
                                + "order by id desc";
                        break;

                    default:
                        for (int i = 0; i < sort.length(); i++) {
                            if (!Character.isDigit(sort.charAt(i))) {
                                sort = "-1";
                                break;
                            }
                        }
                        sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                                + "from Orders\n"
                                + "where id = ?\n"
                                + "order by id desc";
                        flag = 1;
                        break;
                }
            }

            PreparedStatement pst = cn.prepareStatement(sql);
            if (flag == 1) {
                pst.setInt(1, Integer.parseInt(sort));
            }
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listO.add(new Order(rs.getInt(1),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(2)),
                            rs.getString(3),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)),
                            rs.getInt(5),
                            rs.getInt(6),
                            rs.getInt(7),
                            rs.getInt(8),
                            rs.getInt(9),
                            rs.getInt(10), SHOPOWNER_getAllOrderItem(rs.getInt(1))));
                }
            }
            cn.close();
        }
        return listO;
    }

// Get all feedbacks of shop by owner's id
    public static ArrayList<Feedback> SHOPOWNER_getAllFeedbackByOwnerID(int ownerID) throws Exception {
        ArrayList<Feedback> listFSO = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                    + "from Feedback\n"
                    + "where isReported = 0 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                    + "order by id desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listFSO.add(new Feedback(rs.getInt(1), rs.getString(2), rs.getFloat(3), DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getInt(8), rs.getInt(9)));
                }
            }
            cn.close();
        }
        return listFSO;
    }

// Get all feedbacks of shop by owner's id and sort
    public static ArrayList<Feedback> SHOPOWNER_getAllFeedbackByOwnerIDAndSort(int ownerID, String sort) throws Exception {
        ArrayList<Feedback> listFSO = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "";
            if (sort == null) {
                sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                        + "from Feedback\n"
                        + "where isReported = 0 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                        + "order by id desc";
            } else {
                switch (sort) {
                    case "replied":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and status = 1 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                    case "notreply":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and status = 0 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                    case "5":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and rating = 5 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                    case "4":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and rating = 4 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                    case "3":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and rating = 3 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                    case "2":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and rating = 2 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                    case "1":
                        sql = "select id, comment, rating, date, customerid, productid, reply, status, orderid\n"
                                + "from Feedback\n"
                                + "where isReported = 0 and rating = 1 and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))"
                                + "order by id desc";
                        break;

                }
            }
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listFSO.add(new Feedback(rs.getInt(1), rs.getString(2), rs.getFloat(3), DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)), rs.getInt(5), rs.getInt(6), rs.getString(7), rs.getInt(8), rs.getInt(9)));
                }
            }
            cn.close();
        }
        return listFSO;
    }

// Get all followers of shop by owner's id
    public static ArrayList<String> SHOPOWNER_getAllFollowerByOwnerID(int ownerID) throws Exception {
        ArrayList<String> listFSO = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select shopid, customerid\n"
                    + "from Shop_Follower\n"
                    + "where shopid = (select id from Shop where ownerid = ?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listFSO.add(rs.getInt(1) + "@" + rs.getInt(2));
                }
            }
            cn.close();
        }
        return listFSO;
    }

// Get all order sold in current time by owner id (Time type is DATE or MONTH or YEAR)
    public static ArrayList<Order> SHOPOWNER_getAllOrderSoldCurrentTimeTypeByOwnerID(int ownerID, String timeType) throws Exception {
        timeType = timeType.toUpperCase();
        ArrayList<Order> listO = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select id, shipdate, shipaddress, createdate, status, paymenttypeid, paymentmethodid, customerid, shipid, shipdistanceid\n"
                    + "from Orders\n"
                    + "where " + timeType + "(createdate) = " + timeType + "(GETDATE()) and id in (select orderid from Order_Details where productid in (select id from Product where shopid = (select id from Shop where ownerid = ?)))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listO.add(new Order(rs.getInt(1),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(2)),
                            rs.getString(3),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(4)),
                            rs.getInt(5),
                            rs.getInt(6),
                            rs.getInt(7),
                            rs.getInt(8),
                            rs.getInt(9),
                            rs.getInt(10), SHOPOWNER_getAllOrderItem(rs.getInt(1))));
                }
            }
            cn.close();
        }
        return listO;
    }

// Get the growing percentage of order by time type (Time type is DATE or MONTH or YEAR)
    public static float SHOPOWNER_getGrowingOrderPercentage(int ownerID, String timeType) throws Exception {
        float result = 0;
        timeType = timeType.toUpperCase();
        float present = SHOPOWNER_getAmountOrderPresent(ownerID, timeType);
        float past = SHOPOWNER_getAmountOrderPast(ownerID, timeType);
        if (past == 0) {
            past = 1;
        }
        result = ((present - past) / past) * 100;
        return result;
    }

    //--- Get amount order of present time type
    private static int SHOPOWNER_getAmountOrderPresent(int ownerID, String timeType) throws Exception {
        int result = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select COUNT(id)\n"
                    + "from Orders\n"
                    + "where " + timeType + "(createdate) = " + timeType + "(GETDATE()) and id in (select orderid from Order_Details where productid in (select id from Product where shopid = (select id from Shop where ownerid = ?)))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                result = rs.getInt(1);
            }
            cn.close();
        }
        return result;
    }

    //--- Get amount order of past time type
    private static int SHOPOWNER_getAmountOrderPast(int ownerID, String timeType) throws Exception {
        int result = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select COUNT(id)\n"
                    + "from Orders\n"
                    + "where " + timeType + "(createdate) = " + timeType + "(DATEADD(" + timeType.toUpperCase() + ", -1, GETDATE())) and id in (select orderid from Order_Details where productid in (select id from Product where shopid = (select id from Shop where ownerid = ?)))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                result = rs.getInt(1);
            }
            cn.close();
        }
        return result;
    }

// Get the growing revenue percentage of order by time type
    public static float SHOPOWNER_getGrowingPricePercentage(int ownerID, String timeType) throws Exception {
        float result = 0;
        timeType = timeType.toUpperCase();
        float present = SHOPOWNER_getAmountPricePresent(ownerID, timeType);
        float past = SHOPOWNER_getAmountPricePast(ownerID, timeType);
        if (past == 0) {
            past = 1;
        }
        result = ((present - past) / past) * 100;
        return result;
    }

    //--- Get amount revenue of present time type
    public static float SHOPOWNER_getAmountPricePresent(int ownerID, String timeType) throws Exception {
        float result = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select SUM(initprice)\n"
                    + "from Order_Details, Orders\n"
                    + "where orderid = Orders.id and " + timeType + "(createdate) = " + timeType + "(GETDATE()) and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                result = rs.getFloat(1);
            }
            cn.close();
        }
        return result;
    }

    //--- Get amount revenue of past time type
    private static float SHOPOWNER_getAmountPricePast(int ownerID, String timeType) throws Exception {
        float result = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select SUM(initprice)\n"
                    + "from Order_Details, Orders\n"
                    + "where orderid = Orders.id and " + timeType + "(createdate) = " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", -1, GETDATE())) and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                result = rs.getFloat(1);
            }
            cn.close();
        }
        return result;
    }

// Product sold bar chart
    public static ArrayList<String> SHOPOWNER_productSoldBarChart(int ownerID, int timeAmount, String timeType, String timeType2) throws Exception {
        ArrayList<String> date = new ArrayList<>();
        timeType = timeType.toUpperCase();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            for (int i = 0; i < timeAmount; i++) {
                String sql = "select " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), " + timeType2 + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), COUNT(productid)\n"
                        + "from Order_Details, Orders\n"
                        + "where " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())) = " + timeType + "(createdate)\n"
                        + "and orderid = Orders.id and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))\n"
                        + "order by COUNT(productid) desc";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, -i);
                pst.setInt(2, -i);
                pst.setInt(3, -i);
                pst.setInt(4, ownerID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    date.add(rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getInt(3));
                } else {
                    sql = "select " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), " + timeType2 + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), 0\n"
                            + "from Order_Details, Orders\n"
                            + "where orderid = Orders.id and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))\n"
                            + "order by COUNT(productid) desc";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, -i);
                    pst.setInt(2, -i);
                    pst.setInt(3, ownerID);
                    rs = pst.executeQuery();
                    if (rs != null && rs.next()) {
                        date.add(rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getInt(3));
                    }
                }
            }
            cn.close();
        }
        return date;
    }

// Revenue bar chart
    public static ArrayList<String> SHOPOWNER_revenueBarChart(int ownerID, int timeAmount, String timeType, String timeType2) throws Exception {
        ArrayList<String> revenue = new ArrayList<>();
        timeType = timeType.toUpperCase();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            for (int i = 0; i < timeAmount; i++) {
                String sql = "select " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), " + timeType2 + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), SUM(initprice)\n"
                        + "from Order_Details, Orders\n"
                        + "where " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())) = " + timeType + "(createdate)\n"
                        + "and orderid = Orders.id and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))\n"
                        + "group by " + timeType + "(createdate)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, -i);
                pst.setInt(2, -i);
                pst.setInt(3, -i);
                pst.setInt(4, ownerID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    revenue.add(rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getInt(3));
                } else {
                    sql = "select " + timeType + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), " + timeType2 + "(DATEADD(" + timeType.toLowerCase() + ", ?, GETDATE())), 0\n"
                            + "from Order_Details, Orders\n"
                            + "where orderid = Orders.id and productid in (select id from Product where shopid = (select id from Shop where ownerid = ?))\n"
                            + "group by " + timeType + "(createdate)";
                    pst = cn.prepareStatement(sql);
                    pst.setInt(1, -i);
                    pst.setInt(2, -i);
                    pst.setInt(3, ownerID);
                    rs = pst.executeQuery();
                    if (rs != null && rs.next()) {
                        revenue.add(rs.getInt(1) + "@" + rs.getInt(2) + "@" + rs.getInt(3));
                    }
                }
            }
            cn.close();
        }
        return revenue;
    }

// Hot product chart
    public static ArrayList<String> SHOPOWNER_hotProductBarChart(int ownerID) throws Exception {
        ArrayList<String> hotProduct = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select top 10 id, soldQuantity\n"
                    + "from Product\n"
                    + "where shopid = (select id from Shop where ownerid = ?)\n"
                    + "order by soldQuantity desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ownerID);
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    hotProduct.add(rs.getString(1) + "@" + rs.getInt(2));
                }
            }
            cn.close();
        }
        return hotProduct;
    }

// Order status chart
    public static ArrayList<String> SHOPOWNER_orderStatusBarChart(int shopID) throws Exception {
        ArrayList<String> orderStatus = new ArrayList<>();
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            for (int i = 1; i <= 5; i++) {
                String sql = "select count(Order_Details.id), Order_Status.status\n"
                        + "from Order_Details, Orders, Order_Status\n"
                        + "where Orders.status = ? and Orders.status = Order_Status.id and orderid = Orders.id and productid in (select id from Product where shopid = ?)\n"
                        + "group by Order_Status.status";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, i);
                pst.setInt(2, shopID);
                ResultSet rs = pst.executeQuery();
                if (rs != null && rs.next()) {
                    orderStatus.add(rs.getInt(1) + "@" + rs.getString(2));
                } else {
                    orderStatus.add(0 + "@" + SHOPOWNER_getOrderStatusByID(i));
                }
            }
            cn.close();
        }
        return orderStatus;
    }

    // --- Get status by id
    private static String SHOPOWNER_getOrderStatusByID(int statusID) throws Exception {
        String status = "Cancelled";
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select status\n"
                    + "from Order_Status\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, statusID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                status = rs.getString(1).trim();
            }
            cn.close();
        }
        return status;
    }

// Change number to month
    public static String SHOPOWNER_changeToMonth(int month) throws Exception {
        String m = "";
        switch (month) {
            case 1:
                m = "Jan";
                break;
            case 2:
                m = "Feb";
                break;
            case 3:
                m = "Mar";
                break;
            case 4:
                m = "Apr";
                break;
            case 5:
                m = "May";
                break;
            case 6:
                m = "Jun";
                break;
            case 7:
                m = "Jul";
                break;
            case 8:
                m = "Aug";
                break;
            case 9:
                m = "Sep";
                break;
            case 10:
                m = "Oct";
                break;
            case 11:
                m = "Nov";
                break;
            case 12:
                m = "Dec";
                break;
        }
        return m;
    }

// Update product detail
    public static boolean SHOPOWNER_updateProductDetail(String name, long price, int cateID, int qty, float discountChoice, String desc, String status, int productID) throws Exception {
        Connection cn = DBUtils.getConnection();
        int isDiscount = 0;
        if (discountChoice != 0) {
            isDiscount = 1;
        }
        boolean wasDiscount = SHOPOWNER_checkDiscountExisted(productID);
        if (!wasDiscount && isDiscount == 1) {
            SHOPOWNER_createDiscount(productID, discountChoice);
        }
        if (wasDiscount && isDiscount == 1) {
            SHOPOWNER_updateDiscount(discountChoice, productID);
        }
        if (wasDiscount && isDiscount == 0) {
            SHOPOWNER_updateDiscount(0, productID);
        }

        System.out.println(productID);
        System.out.println(name);
        System.out.println(price);
        System.out.println(cateID);
        System.out.println(qty);
        System.out.println(discountChoice);
        System.out.println(desc);
        System.out.println(status);

        if (cn != null) {
            String sql = "update Product\n"
                    + "set \n"
                    + "name = ?,\n"
                    + "price = ?,\n"
                    + "cateid = ?,\n"
                    + "availableQuantity = ?,\n"
                    + "isDiscount = ?,\n"
                    + "description = ?,\n"
                    + "status = ?\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setLong(2, price);
            pst.setInt(3, cateID);
            pst.setInt(4, qty);
            pst.setInt(5, isDiscount);
            pst.setString(6, desc);
            pst.setString(7, status);
            pst.setInt(8, productID);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Check if this product is discount
    private static boolean SHOPOWNER_checkDiscountExisted(int productID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select discountChoice\n"
                    + "from Discount_Details\n"
                    + "where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Update discount detail
    private static void SHOPOWNER_updateDiscount(float discountChoice, int productID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Discount_Details\n"
                    + "set discountChoice = ?,\n"
                    + "startdate = GETDATE(),\n"
                    + "enddate = DATEADD(year, 1, GETDATE())\n"
                    + "where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setFloat(1, discountChoice);
            pst.setInt(2, productID);
            pst.executeUpdate();
        }
    }

    //--- Create discount
    private static void SHOPOWNER_createDiscount(int productID, float discountChoice) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Discount_Details(productid, discountChoice, startdate, enddate, isFreeShip)\n"
                    + "values(?, ?, GETDATE(), DATEADD(year, 1, GETDATE()), 0)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            pst.setFloat(2, discountChoice);
            pst.executeUpdate();
        }
    }

// Create a product
    public static void SHOPOWNER_createProduct(ArrayList<String> listImg, String name, String desc, int availableQty, long price, int cateID, float discountChoice, int shopID) throws Exception {
        int soldQty = 0, isDiscount = 0;
        String status = "Available";
        if (discountChoice != 0) {
            isDiscount = 1;
        }
        if (SHOPOWNER_createNewProduct(name, desc, soldQty, availableQty, price, cateID, isDiscount, shopID, status)) {
            SHOPOWNER_createNewProductImg(listImg, shopID);
            if (isDiscount == 1) {
                SHOPOWNER_createDiscountForNewProduct(shopID, discountChoice, isDiscount);
            }
        }
    }

    //--- Create product
    private static boolean SHOPOWNER_createNewProduct(String name, String desc, int soldQty, int availableQty, long price, int cateID, int isDiscount, int shopID, String status) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Product(name, description, soldQuantity, availableQuantity, price, cateid, isDiscount, shopid, status)\n"
                    + "values(?,?,?,?,?,?,?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, desc);
            pst.setInt(3, soldQty);
            pst.setInt(4, availableQty);
            pst.setLong(5, price);
            pst.setInt(6, cateID);
            pst.setInt(7, isDiscount);
            pst.setInt(8, shopID);
            pst.setString(9, status);
            int rs = pst.executeUpdate();
            if (rs > 0) {
                return true;
            }
            cn.close();
        }
        return false;
    }

    //--- Create product img
    private static void SHOPOWNER_createNewProductImg(ArrayList<String> listImg, int shopID) throws Exception {
        Connection cn = DBUtils.getConnection();
        int productID = SHOPOWNER_getLastestProductID(shopID);

        if (cn != null && !listImg.isEmpty()) {
            for (String img : listImg) {
                String sql = "insert into Product_img(productid, img)\n"
                        + "values(?,?)";
                PreparedStatement pst = cn.prepareStatement(sql);
                pst.setInt(1, productID);
                pst.setString(2, img);
                pst.executeUpdate();
            }
            cn.close();
        }
    }

    //--- Get lastest product id
    private static int SHOPOWNER_getLastestProductID(int shopID) throws Exception {
        int result = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "select top 1 id\n"
                    + "from Product\n"
                    + "where shopid = ?\n"
                    + "order by id desc";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                result = rs.getInt(1);
            }
            cn.close();
        }
        return result;
    }

    //--- Create discount for new product
    private static void SHOPOWNER_createDiscountForNewProduct(int shopID, float discountChoice, int isFreeShip) throws Exception {
        int productID = SHOPOWNER_getLastestProductID(shopID);
        isFreeShip = 0;
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "insert into Discount_Details(productid, discountChoice, startdate, enddate, isFreeShip)\n"
                    + "values(?,?,GETDATE(),DATEADD(YEAR, 1, GETDATE()),?);";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            pst.setFloat(2, discountChoice);
            pst.setInt(3, isFreeShip);
            pst.executeUpdate();
            cn.close();
        }
    }

// Update shop profile
    public static void SHOPOWNER_updateShopProfile(String districtID, String name, String img, String description, int ownerID) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Shop\n"
                    + "set\n"
                    + "districtid = ?,\n"
                    + "name = ?,\n"
                    + "img = ?,\n"
                    + "description = ?\n"
                    + "where ownerid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, districtID);
            pst.setString(2, name);
            pst.setString(3, img);
            pst.setString(4, description);
            pst.setInt(5, ownerID);
            pst.executeUpdate();
            cn.close();
        }
    }

// Get all customer of shop
    public static ArrayList<Customer> SHOPOWNER_getAllCusOfShop(int shopID, String key, String type) throws Exception {
        Connection cn = DBUtils.getConnection();
        ArrayList<Customer> listC = new ArrayList<>();
        String sql = "";

        if (cn != null) {
            if (key.isEmpty()) {
                sql = "select name, email, gender, tel, DoB, Customer.id, status, username, password, role, img, isDobSetup\n"
                        + "from Customer, Account\n"
                        + "where Customer.id = Account.id\n"
                        + "and Customer.id in (select customerid from Orders where id in (select orderid from Order_Details where productid in (select productid from Shop where id = ?)))";
            } else {
                switch (type) {
                    case "mail":
                        sql = "select name, email, gender, tel, DoB, Customer.id, status, username, password, role, img, isDobSetup\n"
                                + "from Customer, Account\n"
                                + "where Customer.id = Account.id\n"
                                + "and Customer.id in (select customerid from Orders where id in (select orderid from Order_Details where productid in (select productid from Shop where id = ?)))\n"
                                + "and email like ?";
                        break;
                    case "phone":
                        sql = "select name, email, gender, tel, DoB, Customer.id, status, username, password, role, img, isDobSetup\n"
                                + "from Customer, Account\n"
                                + "where Customer.id = Account.id\n"
                                + "and Customer.id in (select customerid from Orders where id in (select orderid from Order_Details where productid in (select productid from Shop where id = ?)))\n"
                                + "and tel like ?";
                        break;
                }
            }

            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, shopID);
            if (!key.isEmpty()) {
                pst.setString(2, "%" + key + "%");
            }
            ResultSet rs = pst.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    listC.add(new Customer(rs.getString(1),
                            rs.getString(2),
                            rs.getString(3),
                            rs.getString(4),
                            DATESTRINGCONVERTER_convertSQLDatetoUtilDate(rs.getDate(5)),
                            rs.getInt(6),
                            rs.getInt(7),
                            rs.getString(8),
                            rs.getString(9),
                            rs.getString(10),
                            rs.getString(11),
                            rs.getInt(12)));
                }
            }
            cn.close();
        }
        return listC;
    }

//Count feedback average rating
    public static int SHOPOWNER_getRating(int shopID) throws Exception {
        int rating = 0;
        int count = 0;
        ArrayList<Integer> listProID = SHOP_getAllProductIDInShop(shopID);
        for (Integer id : listProID) {
            if (SHOPOWNER_getProductRating(id) != 0) {
                rating += SHOPOWNER_getProductRating(id);
                count++;
            }
        }
        if (count != 0) {
            rating = rating / count;
        } else {
            rating = 0;
        }
        return rating;
    }

    //--- Get product's rating
    private static int SHOPOWNER_getProductRating(int productID) throws Exception {
        int rating = 0;
        Connection cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "select ROUND(AVG(rating), 0, 1) from Feedback where productid = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, productID);
            ResultSet rs = pst.executeQuery();
            if (rs != null && rs.next()) {
                rating = rs.getInt(1);
            }
            cn.close();
        }
        return rating;
    }

// Update feedback status
    public static void SHOPOWNER_updateFeedbackStatus(int feedbackID, String reply) throws Exception {
        Connection cn = DBUtils.getConnection();

        if (cn != null) {
            String sql = "update Feedback\n"
                    + "set status = 1, reply = ?\n"
                    + "where id = ?";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, reply);
            pst.setInt(2, feedbackID);
            pst.executeUpdate();
            cn.close();
        }
    }
//-----//
//-----//
//----------------------------- ADMIN -----------------------------//
//-----//
//-----//
//-----//
//-----//
}
