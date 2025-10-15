package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.Infirmier;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.PatientService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@WebServlet("/infirmier/dashboard")
public class InfirmierServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws jakarta.servlet.ServletException, java.io.IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!(utilisateur instanceof Infirmier)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Long totalPatients = patientService.countTotalPatients();
            Long patientsEnAttente = patientService.countPatientsEnAttente();
            Long patientsTraites = patientService.countPatientsTraites();

            List<Patient> patients = patientService.getAllPatients();

            request.setAttribute("totalPatients", totalPatients);
            request.setAttribute("patientsEnAttente", patientsEnAttente);
            request.setAttribute("patientsTraites", patientsTraites);
            request.setAttribute("patients", patients);

            request.getRequestDispatcher("/WEB-INF/views/infirmier/infirmier.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des données : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/infirmier/infirmier.jsp").forward(request, response);
        }
    }
}

