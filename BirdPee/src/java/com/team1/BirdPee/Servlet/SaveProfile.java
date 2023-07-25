/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.Servlet;

import com.team1.BirdPee.DAO.BirdPeeDAO;
import com.team1.BirdPee.DTO.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class SaveProfile extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error ocacrs
     * @throws IOException if an I/O error ocacrs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String username = request.getParameter("username");
            String img = request.getParameter("img");
            String name = null;
            String mail = null;
            String phone = null;
            String gender = null;
            Date Dob = null;
            Customer ac = (Customer) session.getAttribute("user");
            if (img.isEmpty() || (img.contains("lh3.googleusercontent.com"))) {
                img = ac.getImg();
            }
            if (!img.contains("images") && !img.isEmpty() && !img.contains("lh3.googleusercontent.com")){
                img = "images/" + img;
            }

            mail = request.getParameter("mail");
            phone = request.getParameter("phone");
            gender = request.getParameter("gender");
            Dob = Date.valueOf(request.getParameter("Dob"));
            name = request.getParameter("name");
            if (ac != null) {
                if (ac.getDoB().compareTo(Dob) == 0 && BirdPeeDAO.ACCOUNT_updateCustomerAccount(username, img, ac.getId(), name, phone, gender)) {
                    session.setAttribute("user", BirdPeeDAO.ACCOUNT_checkExistedCustomerByEmail(mail));
                }
                if (ac.getDoB().compareTo(Dob) != 0 && BirdPeeDAO.ACCOUNT_updateCustomerAccountDoB(username, img, ac.getId(), name, phone, gender, Dob)) {
                    session.setAttribute("user", BirdPeeDAO.ACCOUNT_checkExistedCustomerByEmail(mail));
                }
            }
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
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
     * @throws ServletException if a servlet-specific error ocacrs
     * @throws IOException if an I/O error ocacrs
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
     * @throws ServletException if a servlet-specific error ocacrs
     * @throws IOException if an I/O error ocacrs
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
