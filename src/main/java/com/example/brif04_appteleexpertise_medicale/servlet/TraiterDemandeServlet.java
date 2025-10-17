package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.DemandeExpertise;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.DemandeExpertiseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/specialiste/traiterDemande")
public class TraiterDemandeServlet extends HttpServlet {

    private final DemandeExpertiseService demandeService = new DemandeExpertiseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Vérifier l'authentification
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!(utilisateur instanceof MedecinSpecialiste)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Récupérer l'ID de la demande
            Long demandeId = Long.parseLong(request.getParameter("id"));

            // Récupérer la demande
            DemandeExpertise demande = demandeService.getDemandeById(demandeId);

            if (demande == null) {
                session.setAttribute("errorMessage", "❌ Demande introuvable");
                response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
                return;
            }

            // Passer la demande au JSP
            request.setAttribute("demande", demande);
            request.getRequestDispatcher("/WEB-INF/views/specialiste/traiterDemande.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "❌ ID invalide");
            response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "❌ Erreur : " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
        }
    }
}

