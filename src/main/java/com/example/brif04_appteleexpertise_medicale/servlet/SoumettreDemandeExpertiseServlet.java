package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.DemandeExpertise;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinGeneraliste;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.DemandeExpertiseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/generaliste/soumettreDemandeExpertise")
public class SoumettreDemandeExpertiseServlet extends HttpServlet {

    private final DemandeExpertiseService demandeService = new DemandeExpertiseService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!(utilisateur instanceof MedecinGeneraliste)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Long consultationId = Long.parseLong(request.getParameter("consultationId"));
            Long specialisteId = Long.parseLong(request.getParameter("specialisteId"));
            String dateRendezVous = request.getParameter("dateRendezVous");
            String creneauHoraire = request.getParameter("creneauHoraire");
            String question = request.getParameter("question");
            String priorite = request.getParameter("priorite");

            if (question == null || question.trim().isEmpty()) {
                session.setAttribute("errorMessage", "❌ La question pour le spécialiste est obligatoire");
                response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
                return;
            }

            if (dateRendezVous == null || dateRendezVous.trim().isEmpty()) {
                session.setAttribute("errorMessage", "❌ La date du rendez-vous est obligatoire");
                response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
                return;
            }

            if (creneauHoraire == null || creneauHoraire.trim().isEmpty()) {
                session.setAttribute("errorMessage", "❌ Le créneau horaire est obligatoire");
                response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
                return;
            }

            DemandeExpertise demande = demandeService.creerDemandeExpertise(
                consultationId,
                specialisteId,
                question,
                priorite,
                dateRendezVous,
                creneauHoraire
            );

            session.setAttribute("successMessage",
                "✅ Demande d'expertise envoyée avec succès ! " +
                "📅 Rendez-vous programmé le " + dateRendezVous +
                " à " + creneauHoraire + ". " +
                "Le spécialiste recevra votre demande.");

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "❌ Erreur: format de nombre invalide");
        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMessage", "❌ " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "❌ Erreur lors de la création de la demande: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
    }
}

