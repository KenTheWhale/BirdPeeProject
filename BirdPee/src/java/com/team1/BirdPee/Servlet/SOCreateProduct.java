/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.team1.BirdPee.Servlet;

import com.team1.BirdPee.DAO.BirdPeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class SOCreateProduct extends HttpServlet {

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
            String name = request.getParameter("name");
            long price = Long.parseLong(request.getParameter("price"));
            int cateID = Integer.parseInt(request.getParameter("category"));
            int qty = Integer.parseInt(request.getParameter("qty"));
            float discountChoice = Float.parseFloat(request.getParameter("discount"));
            String desc = request.getParameter("shortdesc") + "@" + request.getParameter("fulldesc");
            int shopID = Integer.parseInt(request.getParameter("shopid"));

            ArrayList<String> listImg = new ArrayList<>();
            for (int i = 1; i <= 4; i++) {
                if (request.getParameter("img" + i) != null && !request.getParameter("img" + i).isEmpty()) {
                    listImg.add("images/" + request.getParameter("img" + i));
                }
            }
            if(listImg.isEmpty()){
                listImg.add("images/noimg.jpg");
            }
            BirdPeeDAO.SHOPOWNER_createProduct(listImg, name, desc, qty, price, cateID, discountChoice, shopID);
            response.sendRedirect("SO_ProductManagement.jsp");
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
