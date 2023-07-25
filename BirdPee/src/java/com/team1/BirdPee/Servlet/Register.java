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
public class Register extends HttpServlet {

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
           String mail = request.getParameter("email");
           String name = request.getParameter("name");
           String pass = request.getParameter("pass");
           String cpass = request.getParameter("cpass");
           String phone = request.getParameter("phone");
           String address = request.getParameter("address");
           String destination = "Signup.jsp";
           
           if(pass.equals(cpass)){
               Account ac = BirdPeeDAO.ACCOUNT_checkExistedCustomerByEmail(mail);
               if(ac.getUsername() == null && BirdPeeDAO.ACCOUNT_createCustomerAccountByEmail(name, pass, ac.getRole(), 1, "Not set", mail, address, phone) != null){
                   session.setAttribute("user", BirdPeeDAO.ACCOUNT_checkExistedCustomerByEmail(mail));
                   destination = "Login.jsp";
               } else{
                   request.setAttribute("errorMsg", "This email has been registed");
               }
           } else{
               request.setAttribute("errorMsg", "Password doesn't match");
           }
           request.getRequestDispatcher(destination).forward(request, response);
           
        } catch(Exception e){
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
