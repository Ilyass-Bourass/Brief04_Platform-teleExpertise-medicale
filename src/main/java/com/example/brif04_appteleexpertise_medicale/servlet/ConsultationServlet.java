package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.Consultation;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinGeneraliste;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.ConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/generaliste/ajouterConsultation")
public class ConsultationServlet extends HttpServlet {
    private final ConsultationService consultationService = new ConsultationService();

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

        MedecinGeneraliste medecin = (MedecinGeneraliste) utilisateur;

        try {
            Long patientId = Long.parseLong(request.getParameter("patientId"));
            String motif = request.getParameter("motif");
            String observations = request.getParameter("observations");
            String diagnostic = request.getParameter("diagnostic");
            String traitement = request.getParameter("traitement");

            Double cout = null;
            String coutStr = request.getParameter("cout");
            if (coutStr != null && !coutStr.trim().isEmpty()) {
                cout = Double.parseDouble(coutStr);
            }

            // Valider les champs obligatoires
            if (motif == null || motif.trim().isEmpty() ||
                    observations == null || observations.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Le motif et les observations sont obligatoires");
                response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
                return;
            }

            // Créer la consultation
            Consultation consultation = consultationService.creerConsultation(
                    patientId,
                    medecin,
                    motif,
                    observations,
                    diagnostic,
                    traitement,
                    cout
            );

            session.setAttribute("successMessage",
                    "✅ Consultation ajoutée avec succès pour le patient ID: " + patientId);

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Erreur: format de nombre invalide");
        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMessage", "Erreur: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de l'ajout de la consultation: " + e.getMessage());
        }

        // Rediriger vers le dashboard
        response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
    }
}
