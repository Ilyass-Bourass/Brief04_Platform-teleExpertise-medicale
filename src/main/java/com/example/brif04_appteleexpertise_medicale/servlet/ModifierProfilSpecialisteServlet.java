package com.example.brif04_appteleexpertise_medicale.servlet;

import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;
import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.service.SpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/specialiste/modifierProfil")
public class ModifierProfilSpecialisteServlet extends HttpServlet {

    private final SpecialisteService specialisteService = new SpecialisteService();

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
        request.setAttribute("specialiste", specialiste);
        request.getRequestDispatcher("/WEB-INF/views/specialiste/modifierProfil.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        try {
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String email = request.getParameter("email");
            String specialiteStr = request.getParameter("specialite");
            String tarifStr = request.getParameter("tarif");
            String dureeStr = request.getParameter("dureeConsultation");

            if (nom == null || nom.trim().isEmpty() ||
                prenom == null || prenom.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                specialiteStr == null || specialiteStr.trim().isEmpty() ||
                tarifStr == null || tarifStr.trim().isEmpty() ||
                dureeStr == null || dureeStr.trim().isEmpty()) {

                session.setAttribute("errorMessage", "Tous les champs sont obligatoires !");
                response.sendRedirect(request.getContextPath() + "/specialiste/modifierProfil");
                return;
            }

            // Récupérer l'ID du spécialiste connecté
            Long specialisteId = utilisateur.getId();

            // Créer un objet avec les nouvelles valeurs
            MedecinSpecialiste specialisteToUpdate = specialisteService.getSpecialisteById(specialisteId);

            if (specialisteToUpdate == null) {
                session.setAttribute("errorMessage", "Spécialiste introuvable !");
                response.sendRedirect(request.getContextPath() + "/specialiste/modifierProfil");
                return;
            }

            // Mettre les nouvelles valeurs
            specialisteToUpdate.setNom(nom.trim());
            specialisteToUpdate.setPrenom(prenom.trim());
            specialisteToUpdate.setEmail(email.trim());
            specialisteToUpdate.setSpecialite(MedecinSpecialiste.Specialite.valueOf(specialiteStr));
            specialisteToUpdate.setTarif(Double.parseDouble(tarifStr));
            specialisteToUpdate.setDureeConsultation(Integer.parseInt(dureeStr));

            specialisteService.updateSpecialiste(specialisteToUpdate);

            MedecinSpecialiste specialisteUpdated = specialisteService.getSpecialisteById(specialisteId);

            session.setAttribute("utilisateur", specialisteUpdated);
            session.setAttribute("successMessage", "✅ Votre profil a été mis à jour avec succès !");
            response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur : Le tarif et la durée doivent être des nombres valides !");
            response.sendRedirect(request.getContextPath() + "/specialiste/modifierProfil");
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur : Spécialité invalide !");
            response.sendRedirect(request.getContextPath() + "/specialiste/modifierProfil");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour du profil : " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/specialiste/modifierProfil");
        }
    }
}
