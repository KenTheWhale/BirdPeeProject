/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.Servlet;

import com.team1.BirdPee.DAO.BirdPeeDAO;
import com.team1.BirdPee.DTO.Account;
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
public class Login extends HttpServlet {

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
            HttpSession sesson = request.getSession();
            String eou = request.getParameter("email");//eou first time is email
            String pass = request.getParameter("pass");
            String destination = "";
            Account ac = new Account();
            String e[] = eou.split("@");

            if (e.length == 2) {//is email
                ac = BirdPeeDAO.ACCOUNT_checkExistedCustomerByEmailPass(eou, pass);
                if (ac.getUsername() != null) {
                    destination = "Homepage.jsp";
                    sesson.setAttribute("user", ac);
                } else{// no account
                     request.setAttribute("errorMsg", "Incorrect email or password");
                    destination = "Login.jsp";
                }
            } else {//is not email -> username
                ac = BirdPeeDAO.ACCOUNT_checkExistedAccountByNamePass(eou, pass);
                if (ac.getRole() != null) {//have account
                    switch (ac.getRole()) {
                        case "SO":
                            destination = "SO_Dashboard.jsp";
                            break;
                        case "AD":
                            destination = "TestTrue.jsp";
                            break;
                    }
                    sesson.setAttribute("user", ac);
                } else {//no account
                    request.setAttribute("errorMsg", "Incorrect email or password");
                    destination = "Login.jsp";
                }
            }

            request.getRequestDispatcher(destination).forward(request, response);

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
