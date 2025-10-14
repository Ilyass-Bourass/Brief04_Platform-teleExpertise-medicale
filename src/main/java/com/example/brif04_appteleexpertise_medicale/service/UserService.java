package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.UserDao;
import com.example.brif04_appteleexpertise_medicale.entity.*;
import org.mindrot.jbcrypt.BCrypt;


public class UserService {

    private UserDao userDao = new UserDao();

    public void registerUser(String nom, String prenom, String email, String password, String roleStr) throws Exception {

        Utilisateur existingUser = userDao.findByEmail(email);
        if (existingUser != null) {
            throw new Exception("Cet email est déjà utilisé. Veuillez en choisir un autre.");
        }


        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        Utilisateur utilisateur = createUserByRole(nom, prenom, email, hashedPassword, roleStr);
        userDao.save(utilisateur);
    }

    public Utilisateur authenticateUser(String email, String password) {
        Utilisateur utilisateur = userDao.findByEmail(email);
        if (utilisateur == null) {
            return null;
        }

        boolean passwordMatches = BCrypt.checkpw(password, utilisateur.getMotDePasse());

        if (passwordMatches) {
            return utilisateur;
        } else {
            return null;
        }
    }

    public boolean emailExists(String email) {
        Utilisateur utilisateur = userDao.findByEmail(email);
        return utilisateur != null;
    }

    private Utilisateur createUserByRole(String nom, String prenom, String email,
                                         String hashedPassword, String roleStr) throws Exception {

        switch (roleStr) {
            case "INFIRMIER":
                // Créer un Infirmier
                return new Infirmier(nom, prenom, email, hashedPassword);

            case "GENERALISTE":
                // Créer un MedecinGeneraliste
                return new MedecinGeneraliste(nom, prenom, email, hashedPassword, null);

            case "SPECIALISTE":
                // Créer un MedecinSpecialiste avec des valeurs par défaut
                return new MedecinSpecialiste(
                    nom, prenom, email, hashedPassword,
                    MedecinSpecialiste.Specialite.CARDIOLOGIE,
                    200.0,
                    30
                );

            default:
                throw new Exception("Rôle non valide : " + roleStr);
        }
    }


    public void validateRegistrationData(String nom, String prenom, String email,
                                         String password, String role) throws Exception {

        if (nom == null || nom.trim().isEmpty()) {
            throw new Exception("Le nom est obligatoire");
        }

        if (prenom == null || prenom.trim().isEmpty()) {
            throw new Exception("Le prénom est obligatoire");
        }

        if (email == null || email.trim().isEmpty()) {
            throw new Exception("L'email est obligatoire");
        }

        if (password == null || password.trim().isEmpty()) {
            throw new Exception("Le mot de passe est obligatoire");
        }

        if (role == null || role.trim().isEmpty()) {
            throw new Exception("Le rôle est obligatoire");
        }

        // Vérifier que le mot de passe fait au moins 8 caractères
        if (password.length() < 8) {
            throw new Exception("Le mot de passe doit contenir au moins 8 caractères");
        }

        if (!email.contains("@")) {
            throw new Exception("L'email n'est pas valide");
        }
    }
}
