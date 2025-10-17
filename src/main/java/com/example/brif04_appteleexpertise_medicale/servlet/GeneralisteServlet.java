package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.MedecinGeneraliste;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;
import com.example.brif04_appteleexpertise_medicale.entity.Consultation;
import com.example.brif04_appteleexpertise_medicale.service.PatientService;
import com.example.brif04_appteleexpertise_medicale.service.ConsultationService;
import com.example.brif04_appteleexpertise_medicale.service.SpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/generaliste/dashboard")
public class GeneralisteServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();
    private final ConsultationService consultationService = new ConsultationService();
    private final SpecialisteService specialisteService = new SpecialisteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            List<Patient> patientsEnAttente = patientService.getPatientsEnAttente();
            List<Consultation> consultations = consultationService.getConsultationsByMedecin(medecin.getId());

            List<Consultation> consultationsSansExpertise = consultationService.getConsultationsSansDemandeExpertise(medecin.getId());

            List<Patient> patients = patientService.getAllPatients();
            List<MedecinSpecialiste> specialistes = specialisteService.getAllSpecialistes();

            request.setAttribute("patients", patients);
            request.setAttribute("patientsEnAttente", patientsEnAttente);
            request.setAttribute("consultations", consultations);
            request.setAttribute("consultationsSansExpertise", consultationsSansExpertise);
            request.setAttribute("specialistes", specialistes);
            request.setAttribute("totalPatients", patientService.countTotalPatients());

            request.getRequestDispatcher("/WEB-INF/views/generaliste/generaliste.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur chargement données : " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/generaliste/generaliste.jsp").forward(request, response);
        }
    }
}
