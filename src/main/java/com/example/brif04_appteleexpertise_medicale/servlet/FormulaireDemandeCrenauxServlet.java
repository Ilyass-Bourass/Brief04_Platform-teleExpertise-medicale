package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.Consultation;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinGeneraliste;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.ConsultationService;
import com.example.brif04_appteleexpertise_medicale.service.SpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/generaliste/formulaireDemandeCrenaux")
public class FormulaireDemandeCrenauxServlet extends HttpServlet {

    private final ConsultationService consultationService = new ConsultationService();
    private final SpecialisteService specialisteService = new SpecialisteService();

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

            Consultation consultation = consultationService.getConsultationById(consultationId);
            MedecinSpecialiste specialiste = specialisteService.getSpecialisteById(specialisteId);

            if (consultation == null || specialiste == null) {
                session.setAttribute("errorMessage", "Consultation ou spécialiste introuvable");
                response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
                return;
            }

            request.setAttribute("consultation", consultation);
            request.setAttribute("specialiste", specialiste);

            request.getRequestDispatcher("/WEB-INF/views/generaliste/choisirDate.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Erreur: format de nombre invalide");
            response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
        }
    }
}

