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
import java.util.List;

@WebServlet("/specialiste/dashboard")
public class SpecialisteServlet extends HttpServlet {

    private final DemandeExpertiseService demandeService = new DemandeExpertiseService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!(utilisateur instanceof MedecinSpecialiste)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        MedecinSpecialiste specialiste = (MedecinSpecialiste) utilisateur;

        try {
            List<DemandeExpertise> demandes = demandeService.getDemandesBySpecialiste(specialiste.getId());

            request.setAttribute("demandes", demandes);
            request.setAttribute("specialiste", specialiste);

            request.getRequestDispatcher("/WEB-INF/views/specialiste/specialiste.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des demandes : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/specialiste/specialiste.jsp").forward(request, response);
        }
    }
}

