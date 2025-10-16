package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.PatientDao;
import com.example.brif04_appteleexpertise_medicale.entity.DossierMedical;
import com.example.brif04_appteleexpertise_medicale.entity.Infirmier;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;
import com.example.brif04_appteleexpertise_medicale.entity.SignesVitaux;

import java.time.LocalDate;
import java.util.List;

public class PatientService {

    private final PatientDao patientDao = new PatientDao();
    private final SignesVitauxService signesVitauxService = new SignesVitauxService();
    private final DossierMedicalService dossierMedicalService = new DossierMedicalService();


    public Patient creerPatient(String nom, String prenom, LocalDate dateNaissance,
                               String numSecu, String adresse, String telephone,
                               String mutuelle, Infirmier infirmier,
                               String tensionArterielle, Integer frequenceCardiaque,
                               Double temperature, Integer frequenceRespiratoire,
                               Double poids, Double taille,
                               String antecedents, String allergies, String traitements) {

        Patient existant = patientDao.findByNumSecu(numSecu);
        if (existant != null) {
            throw new RuntimeException("Un patient avec ce numéro de sécurité sociale existe déjà");
        }

        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setDateNaissance(dateNaissance);
        patient.setNumSecu(numSecu);
        patient.setAdresse(adresse);
        patient.setTelephone(telephone);
        patient.setMutuelle(mutuelle);
        patient.setFileAttente(true);
        patient.setInfirmier(infirmier);

        if (tensionArterielle != null || frequenceCardiaque != null ||
            temperature != null || frequenceRespiratoire != null ||
            poids != null || taille != null) {

            SignesVitaux signesVitaux = new SignesVitaux(patient, tensionArterielle,
                frequenceCardiaque, temperature, frequenceRespiratoire, poids, taille);
            patient.setSignesVitaux(signesVitaux);
        }

        if (antecedents != null || allergies != null || traitements != null) {
            DossierMedical dossierMedical = new DossierMedical(patient, antecedents,
                allergies, traitements);
            patient.setDossierMedical(dossierMedical);
        }

        return patientDao.save(patient);
    }


    public List<Patient> getAllPatients() {
        return patientDao.findAll();
    }


    public List<Patient> getPatientsEnAttente() {
        return patientDao.findPatientsEnAttente();
    }


    public Patient getPatientById(Long id) {
        return patientDao.findById(id);
    }


    public Patient getPatientByNumSecu(String numSecu) {
        return patientDao.findByNumSecu(numSecu);
    }


    public Long countTotalPatients() {
        return patientDao.countAll();
    }


    public Long countPatientsEnAttente() {
        return patientDao.countPatientsEnAttente();
    }

    public Long countPatientsTraites() {
        return patientDao.countPatientsTraites();
    }

    public Patient mettreEnFileAttente(Long patientId) {
        Patient patient = patientDao.findById(patientId);
        if (patient != null) {
            patient.setFileAttente(true);
            return patientDao.save(patient);
        }
        throw new RuntimeException("Patient introuvable");
    }


    public Patient retirerDeFileAttente(Long patientId) {
        Patient patient = patientDao.findById(patientId);
        if (patient != null) {
            patient.setFileAttente(false);
            return patientDao.save(patient);
        }
        throw new RuntimeException("Patient introuvable");
    }

    // Ajout: suppression d'un patient via le service
    public void deletePatient(Long patientId) {
        patientDao.delete(patientId);
    }
}
