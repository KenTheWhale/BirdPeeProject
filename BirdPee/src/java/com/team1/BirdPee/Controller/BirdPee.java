/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class BirdPee extends HttpServlet {

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
            String action = request.getParameter("action");
            String destination = "Homepage.jsp";
            if (action != null) {
                switch (action) {
                    //Customer & Guest
                    case "Login":
                        destination = "Login";
                        break;
                    case "Search":
                        destination = "Search";
                        break;
                    case "Next":
                        destination = "SendOTP";
                        break;
                    case "CheckOTP":
                        destination = "CheckOTP";
                        break;
                    case "ResetPass":
                        destination = "ResetPass";
                        break;
                    case "Register":
                        destination = "Register";
                        break;
                    case "Save":
                        destination = "SaveProfile";
                        break;
                    case "Signout":
                        destination = "Signout";
                        break;
                    case "SSort":
                        destination = "ShopSort";
                        break;
                    case "PSort":
                        destination = "ProductSort";
                        break;
                    case "OSort":
                        destination = "OrderSort";
                        break;
                    case "ViewProduct":
                        destination = "SendIDToProductDetail";
                        break;
                    case "AddToCart":
                        request.setAttribute("ac", "AddToCart");
                        destination = "AddToCart";
                        break;
                    case "AddToCartC":
                        request.setAttribute("ac", "AddToCartC");
                        destination = "AddToCart";
                        break;
                    case "checkout":
                        destination = "Checkout.jsp";
                        break;
                    case "payment":
                        destination = "Success";
                        break;
                    case "continueShopping":
                        destination = "Homepage.jsp";
                        break;
                    case "DeleteCart":
                        destination = "DeleteCart";
                        break;
                    case "minus":
                        request.setAttribute("ac", "minus");
                        destination = "UpdateQuantityCart";
                        break;
                    case "plus":
                        request.setAttribute("ac", "plus");
                        destination = "UpdateQuantityCart";
                        break;
                    case "EDelivery":
                        request.setAttribute("ac", "economy");
                        destination = "ChooseDelivery";
                        break;
                    case "SDelivery":
                        request.setAttribute("ac", "standard");
                        destination = "ChooseDelivery";
                        break;
                    case "FDelivery":
                        request.setAttribute("ac", "fast");
                        destination = "ChooseDelivery";
                        break;
                    case "Success":
                        destination = "Success";
                        break;
                    case "OrderDetail":
                        destination = "OrderDetail.jsp";
                        break;
                    case "CancelOrder":
                        destination = "CancelOrder";
                        break;
                    case "ChosenAddress":
                        destination = "ChosenAddress";
                        break;
                    case "AddAddress":
                        destination = "AddAddress";
                        break;
                    case "EditAddress":
                        destination = "EditAddress";
                        break;
                    case "DeleteAddress":
                        destination = "DeleteAddress";
                        break;
                    case "ReturnAddress":
                        destination = "Address.jsp";
                        break;
                    case "SendFeedback":
                        destination = "SendFeedback";
                        break;
                        
                    //Shop owner
                    case "SOOderSearch":
                        destination = "SOOderSearch";
                        break;
                    case "SOOrderApprove":
                        request.setAttribute("ac", "approve");
                        destination = "SOOrderProgress";
                        break;
                    case "SOOrderCancel":
                        request.setAttribute("ac", "cancel");
                        destination = "SOOrderProgress";
                        break;
                    case "SOUpdateProduct":
                        destination = "SOUpdateProduct";
                        break;
                    case "SOCreateProduct":
                        destination = "SOCreateProduct";
                        break;
                    case "SOProfileUpdate":
                        destination = "SOProfileUpdate";
                        break;
                    case "SOFindCustomer":
                        destination = "SOFindCustomer";
                        break;
                    case "SOReplyFeedback":
                        destination = "SOReplyFeedback";
                        break;
                    default:
                        break;
                }
                request.getRequestDispatcher(destination).forward(request, response);
            }
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
