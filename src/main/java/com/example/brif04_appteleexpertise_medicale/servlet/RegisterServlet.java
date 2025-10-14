package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService = new UserService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String prenom = request.getParameter("username");
        String nom = request.getParameter("secondname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            userService.validateRegistrationData(nom, prenom, email, password, role);
            userService.registerUser(nom, prenom, email, password, role);

            request.getSession().setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            response.sendRedirect(request.getContextPath() + "/login");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
