/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.Servlet;

import com.team1.BirdPee.DAO.BirdPeeDAO;
import com.team1.BirdPee.DTO.Customer;
import com.team1.BirdPee.DTO.Item;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class SendOrderMail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession ss = request.getSession();
            Customer cu = (Customer) ss.getAttribute("user");
            ArrayList<Item> listI = (ArrayList<Item>) ss.getAttribute("listI");
            String shipChoice = (String) ss.getAttribute("shipchoice");
            String paymentMethod = (String) ss.getAttribute("paymentmethod");
            String customerAddress = (String) ss.getAttribute("customeraddress");
            String mail = ((Customer) ss.getAttribute("user")).getEmail();
            for (Item item : listI) {
                float distance = BirdPeeDAO.SHIP_getShipDistance(BirdPeeDAO.SHIP_checkLocation(customerAddress, BirdPeeDAO.SHOP_getShopLocation(BirdPeeDAO.SHOP_getShopByProductID(item.getProductID()).getId())));
                int shipID = 0;
                switch(shipChoice){
                    case "economy":
                        shipID = 1;
                        break;
                    case "standard":
                        shipID = 2;
                        break;
                    case "fast":
                        shipID = 3;
                        break;
                }
                float initprice = BirdPeeDAO.SHIP_getInitShipPrice(shipID);
                float shipprice = initprice * distance;
                
                final String fromEmail = "kienquoc11026789@gmail.com";
                final String password = "anokqftgtbljhfdn";
                final String toEmail = mail;

                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
                props.put("mail.smtp.port", "587"); //TLS Port
                props.put("mail.smtp.auth", "true"); //enable authentication
                props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
                Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, password);
                    }
                });
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(fromEmail));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
                message.setSubject("BirdPee: Order successfully");
                String htmlContent = ""
                        + "<!DOCTYPE html>\n"
                        + "<html lang=\"en\">\n"
                        + "    <head>\n"
                        + "        <meta charset=\"UTF-8\">\n"
                        + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                        + "        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\"\n"
                        + "              integrity=\"sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==\"\n"
                        + "              crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\" />\n"
                        + "    </head>\n"
                        + "    <body >\n"
                        + "        <main >\n"
                        + "            <div style=\"background-color: rgb(218, 215, 215); width: 1200px; margin-left: auto; margin-right: auto; padding-top: 40px; padding-bottom: 40px;\">\n"
                        + "                <div\n"
                        + "                    style=\"background-color: white; width: 1000px; margin-left: auto; margin-right: auto; padding-bottom: 20px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); \">\n"
                        + "                    <div class=\"header_-logo\" style=\"text-align: center;\">\n"
                        + "                        <img src=\"images/Logo.png\" style=\"height: 100px;\" alt=\"\" />\n"
                        + "                    </div>\n"
                        + "                    <div class=\"main-container\">\n"
                        + "                        <div style=\"text-align: center; color: rgb(71, 114, 5); font-size: 30px;\">\n"
                        + "                            Thank you for choosing Birdpee !\n"
                        + "                        </div>\n"
                        + "                        <div class=\"mail-container\" style=\"width: 800px; margin-left: auto; margin-right: auto;\">\n"
                        + "                            <p style=\"font-size: 27px;\"> Hello " + cu.getFullname() + " ,</p>\n"
                        + "                            <p style=\"font-size: 24px;\">\n"
                        + "                                We are delighted to inform you that your order has been successfully\n"
                        + "                                processed\n"
                        + "                                and is now on its way to you. Our dedicated team has carefully picked and packed your items,\n"
                        + "                                ensuring that they are in perfect condition and ready to be enjoyed.\n"
                        + "                            </p>\n"
                        + "                            <p style=\"font-size: 24px;\">\n"
                        + "                                If you have any questions, concerns, or require any further assistance regarding your order,\n"
                        + "                                please feel free to reach out to our dedicated customer support team. We are here to address\n"
                        + "                                any queries you may have and ensure your continued satisfaction.\n"
                        + "                            </p>\n"
                        + "                        </div>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div\n"
                        + "                    style=\"background-color: white; width: 1000px; margin-left: auto; margin-right: auto; padding-bottom: 20px; margin-top: 20px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); \">\n"
                        + "                    <div class=\"delivery-container\"\n"
                        + "                         style=\"margin-left: auto; margin-right: auto; width: 800px; padding-top: 20px;\">\n"
                        + "                        <div class=\"delivery-header\" style=\"padding-bottom: 20px; padding-top: 20px; font-size: 27px;\">\n"
                        + "                            <span><i class=\"fa-solid fa-location-pin\"></i> &nbsp; Delivery Details</span>\n"
                        + "                        </div>\n"
                        + "                        <div class=\"delivery-content\">\n"
                        + "                            <table>\n"
                        + "                                <tbody style=\"text-align: left;\">\n"
                        + "                                    <tr>\n"
                        + "                                        <td\n"
                        + "                                            style=\"width: 120px; height: 30px; vertical-align: top; color: blue; font-size: 20px;\">\n"
                        + "                                            Name</td>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px;\">" + cu.getFullname() + "</td>\n"
                        + "                                    </tr>\n"
                        + "                                    <tr>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px; height: 30px; color: blue;\">Address\n"
                        + "                                        </td>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px; height: 30px;\">" + BirdPeeDAO.ACCOUNT_getChosenAddress(cu.getId()).split("@")[2] + ", " + BirdPeeDAO.ACCOUNT_getChosenAddress(cu.getId()).split("@")[5] + ", " + BirdPeeDAO.ACCOUNT_getChosenAddress(cu.getId()).split("@")[6] + "</td>\n"
                        + "                                    </tr>\n"
                        + "                                    <tr>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px; height: 30px; color: blue;\">Phone</td>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px; height: 30px;\">" + cu.getTel() + "</td>\n"
                        + "                                    </tr>\n"
                        + "                                    <tr>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px; height: 30px; color: blue;\">Email</td>\n"
                        + "                                        <td style=\"vertical-align: top; font-size: 20px; height: 30px;\">\n"
                        + "                                            " + cu.getEmail() + "\n"
                        + "                                        </td>\n"
                        + "                                    </tr>\n"
                        + "                                </tbody>\n"
                        + "                            </table>\n"
                        + "                        </div>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div\n"
                        + "                    style=\"background-color: white; width: 1000px; margin-left: auto; margin-right: auto; padding-bottom: 20px; margin-top: 20px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); \">\n"
                        + "                    <div class=\"package-container\"\n"
                        + "                         style=\"margin-left: auto; margin-right: auto; width: 800px; padding-top: 20px;\">\n"
                        + "                        <div class=\"package-title\" style=\"font-size: 27px;\">\n"
                        + "                            <i class=\"fa-solid fa-boxes-packing\"></i> Package\n"
                        + "                        </div>\n"
                        + "                            <div class=\"cart-item-inner\">\n"
                        + "                                <div class=\"cart-item-left\" style=\"display: flex;\">\n"
                        + "                                    <div class=\"image-wrap\" style=\"flex: 2;\">\n"
                        + "                                        <img src=\"" + BirdPeeDAO.PRODUCT_getImages(item.getProductID()).get(0) + "\" style=\"height: 100px;\" alt=\"...\">\n"
                        + "                                    </div>\n"
                        + "                                    <div class=\"info\" style=\"flex: 10; font-size: 20px;\">\n"
                        + "                                        <p>\n"
                        + "                                            " +  BirdPeeDAO.PRODUCT_getProductByID(item.getProductID()).getName() + "\n"
                        + "                                        </p>\n"
                        + "                                        <p style=\"margin-bottom: 2px; margin-top: 2px; color: #66da40;\">" + String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(item.getProductID())) + " VND</p>\n"
                        + "                                        <p style=\"margin-bottom: 2px; margin-top: 2px;\">Qty: " + item.getQuantity() + "</p>\n"
                        + "                                    </div>\n"
                        + "                                </div>\n"
                        + "                            </div>\n"
                        + "                    </div>\n"
                        + "                </div>\n"
                        + "                <div\n"
                        + "                    style=\"background-color: white; width: 1000px; margin-left: auto; margin-right: auto; padding-bottom: 20px; margin-top: 20px;  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); \">\n"
                        + "                    <table\n"
                        + "                        style=\"margin-left: auto; margin-right: auto; width: 800px; padding-top: 20px; font-size: 20px; border-bottom: 1px solid gray;\">\n"
                        + "                        <tbody>\n"
                        + "                            <tr>\n"
                        + "                                <td style=\"width: 267px; padding-bottom: 20px;\">Subtotal</td>\n"
                        + "                                <td style=\"width: 267px; text-align: center; padding-bottom: 20px;\">VND</td>\n"
                        + "                                <td style=\"text-align: right; width: 267px; padding-bottom: 20px;\">" + String.format("%,.0f", BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(item.getProductID())) + "</td>\n"
                        + "                            </tr>\n"
                        + "                            <tr>\n"
                        + "                                <td style=\"width: 267px; padding-bottom: 20px;\">Shipping fee</td>\n"
                        + "                                <td style=\"width: 267px; text-align: center; padding-bottom: 20px;\">VND</td>\n"
                        + "                                <td style=\"text-align: right; width: 267px; padding-bottom: 20px;\">" + String.format("%,.0f", shipprice) + "</td>\n"
                        + "                            </tr>\n"
                        + "                            <tr>\n"
                        + "                                <td style=\"width: 267px; padding-bottom: 20px;\">Discount</td>\n"
                        + "                                <td style=\"width: 267px; text-align: center; padding-bottom: 20px;\">VND</td>\n"
                        + "                                <td style=\"text-align: right; width: 267px; padding-bottom: 20px;\">0</td>\n"
                        + "                            </tr>\n"
                        + "                            <tr>\n"
                        + "                                <td style=\"width: 267px; padding-bottom: 20px;\">Total</td>\n"
                        + "                                <td style=\"width: 267px; text-align: center; padding-bottom: 20px; color: #66da40;\">VND</td>\n"
                        + "                                <td style=\"text-align: right; width: 267px; padding-bottom: 20px; color: #66da40;\">" + String.format("%,.0f", shipprice + BirdPeeDAO.PRODUCT_getProductDiscountOrNotByID(item.getProductID())) + "\n"
                        + "                                </td>\n"
                        + "                            </tr>\n"
                        + "                        </tbody>\n"
                        + "                    </table>\n"
                        + "                    <table style=\"margin-left: auto; margin-right: auto; width: 800px; padding-top: 20px; font-size: 20px;\">\n"
                        + "                        <tbody>\n"
                        + "                            <tr>\n"
                        + "                                <td style=\"width: 400px; padding-bottom: 20px;\">Delivery type</td>\n"
                        + "                                <td style=\"width: 400px; padding-bottom: 20px; text-align: right;\">" + shipChoice + "</td>\n"
                        + "                            </tr>\n"
                        + "                        </tbody>\n"
                        + "                    </table>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "        </main>\n"
                        + "        <footer>\n"
                        + "        </footer>\n"
                        + "    </body>\n"
                        + "</html>"
                        + "";
                message.setContent(htmlContent, "text/html");
                Transport.send(message);
            }

            BirdPeeDAO.CART_removeCartByCustomerID(cu.getId());
            ss.removeAttribute("shipchoice");
            ss.removeAttribute("ship");
            ss.removeAttribute("shipaddress");
            ss.removeAttribute("paymentmethod");
            ss.removeAttribute("customeraddress");
            request.getRequestDispatcher("Success.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(SendOrderMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(SendOrderMail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
