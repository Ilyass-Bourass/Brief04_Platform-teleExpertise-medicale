package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.*;
import com.example.brif04_appteleexpertise_medicale.service.UserService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty()) {

                request.setAttribute("errorMessage", "Veuillez remplir tous les champs");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            Utilisateur utilisateur = userService.authenticateUser(email, password);

            if (utilisateur == null) {
                request.setAttribute("errorMessage", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }


            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);
            session.setAttribute("userId", utilisateur.getId());
            session.setAttribute("userName", utilisateur.getNom() + " " + utilisateur.getPrenom());

            String redirectUrl = getRedirectUrlByRole(utilisateur);
            response.sendRedirect(request.getContextPath() + redirectUrl);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite : " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private String getRedirectUrlByRole(Utilisateur utilisateur) {

        if (utilisateur instanceof Infirmier) {
            return "/infirmier/dashboard";
        }
        else if (utilisateur instanceof MedecinGeneraliste) {
            return "/generaliste/dashboard";
        }
        else if (utilisateur instanceof MedecinSpecialiste) {
            return "/specialiste/dashboard";
        }

        return "/login.jsp";
    }
}