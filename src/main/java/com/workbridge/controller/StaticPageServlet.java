package com.workbridge.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/companies", "/resources", "/about"})
public class StaticPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String title = "Page";
        String content = "This page is under construction.";

        if ("/companies".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/public/companies.jsp").forward(request, response);
        } else if ("/resources".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/public/resources.jsp").forward(request, response);
        } else if ("/about".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/views/public/about.jsp").forward(request, response);
        }
    }
}

