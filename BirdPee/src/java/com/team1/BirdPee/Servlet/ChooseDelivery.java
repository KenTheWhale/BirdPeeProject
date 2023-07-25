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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ChooseDelivery extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Customer cu = (Customer) session.getAttribute("user");
            String ac = (String) request.getAttribute("ac");
            String choice = null;
            float price = 0;
            int shipID = 0;
            int isFreeShip = 0;
            ArrayList<Item> listI = BirdPeeDAO.CART_getAllItemInCart(cu.getId());

            if (ac != null) {
                switch (ac) {
                    case "economy":
                        shipID = 1;
                        choice = "economy";
                        break;
                    case "standard":
                        shipID = 2;
                        choice = "standard";
                        break;
                    case "fast":
                        shipID = 3;
                        choice = "fast";
                        break;
                }
            }
            ArrayList<Integer> listShopID = new ArrayList<>();
            for (Item i : listI) {
                int shopID = BirdPeeDAO.SHOP_getShopByProductID(i.getProductID()).getId();
                int initPrice = BirdPeeDAO.SHIP_getInitShipPrice(shipID);
                String customerAddress = BirdPeeDAO.ACCOUNT_getChosenAddress(cu.getId()).split("@")[6].trim();
                String shopAddress = BirdPeeDAO.SHOP_getShopLocation(BirdPeeDAO.SHOP_getShopByProductID(i.getProductID()).getId()).trim();
                float distance = BirdPeeDAO.SHIP_getShipDistance(BirdPeeDAO.SHIP_checkLocation(customerAddress, shopAddress));
                if (listShopID.isEmpty()) {
                    price += initPrice * distance;// sum the ship price
                }
                if (listShopID.indexOf(shopID) == -1) {
                    price += initPrice * distance;// sum the ship price
                }
                // Scan the list, if already have the item then delete it and re-add it, if not already then just add it
                if (listShopID.indexOf(shopID) != -1) {
                    int index = listShopID.indexOf(shopID);
                    listShopID.remove(index);
                }
                listShopID.add(shopID);
                isFreeShip += BirdPeeDAO.DISCOUNT_getDiscountInformationByProductID(i.getProductID()).getIsFreeShip();
            }
            if (isFreeShip == listI.size()) {
                price = 0;
            }
            request.setAttribute("shipchoice", choice);
            request.setAttribute("shipprice", price);
            request.getRequestDispatcher("Checkout.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
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
        processRequest(request, response);
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
        processRequest(request, response);
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
