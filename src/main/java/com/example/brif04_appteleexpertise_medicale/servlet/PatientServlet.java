package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.Infirmier;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

// La servlet gère à la fois l'ajout et la suppression de patients
@WebServlet({"/infirmier/ajouterPatient", "/infirmier/supprimerPatient"})
public class PatientServlet extends HttpServlet {

    private final PatientService patientService = new PatientService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        String path = request.getServletPath();

        if ("/infirmier/supprimerPatient".equals(path)) {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                session.setAttribute("errorMessage", "ID patient manquant pour la suppression.");
                response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
                return;
            }

            try {
                Long id = Long.parseLong(idStr);
                patientService.deletePatient(id);
                session.setAttribute("successMessage", "Patient supprimé avec succès.");
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "ID patient invalide.");
            } catch (Exception e) {
                session.setAttribute("errorMessage", "Erreur lors de la suppression : " + e.getMessage());
                e.printStackTrace();
            }

            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
            return;
        }

        Infirmier infirmier = (Infirmier) utilisateur;

        try {
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String dateNaissanceStr = request.getParameter("dateNaissance");
            String numSecu = request.getParameter("numSecu");
            String telephone = request.getParameter("telephone");
            String adresse = request.getParameter("adresse");
            String mutuelle = request.getParameter("mutuelle");

            LocalDate dateNaissance = LocalDate.parse(dateNaissanceStr);

            String tensionArterielle = request.getParameter("tensionArterielle");
            String frequenceCardiaqueStr = request.getParameter("frequenceCardiaque");
            String temperatureStr = request.getParameter("temperature");
            String frequenceRespiratoireStr = request.getParameter("frequenceRespiratoire");
            String poidsStr = request.getParameter("poids");
            String tailleStr = request.getParameter("taille");

            Integer frequenceCardiaque = (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.isEmpty())
                ? Integer.parseInt(frequenceCardiaqueStr) : null;
            Double temperature = (temperatureStr != null && !temperatureStr.isEmpty())
                ? Double.parseDouble(temperatureStr) : null;
            Integer frequenceRespiratoire = (frequenceRespiratoireStr != null && !frequenceRespiratoireStr.isEmpty())
                ? Integer.parseInt(frequenceRespiratoireStr) : null;
            Double poids = (poidsStr != null && !poidsStr.isEmpty())
                ? Double.parseDouble(poidsStr) : null;
            Double taille = (tailleStr != null && !tailleStr.isEmpty())
                ? Double.parseDouble(tailleStr) : null;

            String antecedents = request.getParameter("antecedents");
            String allergies = request.getParameter("allergies");
            String traitements = request.getParameter("traitements");

            Patient patient = patientService.creerPatient(
                nom, prenom, dateNaissance, numSecu, adresse, telephone, mutuelle, infirmier,
                tensionArterielle, frequenceCardiaque, temperature, frequenceRespiratoire, poids, taille,
                antecedents, allergies, traitements
            );

            session.setAttribute("successMessage", "Patient " + patient.getPrenom() + " " + patient.getNom() + " ajouté avec succès !");
            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de l'ajout du patient : " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
        }
    }
}
