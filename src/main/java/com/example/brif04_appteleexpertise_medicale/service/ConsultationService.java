package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.ConsultationDao;
import com.example.brif04_appteleexpertise_medicale.dao.PatientDao;
import com.example.brif04_appteleexpertise_medicale.entity.Consultation;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinGeneraliste;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;

import java.util.List;

public class ConsultationService {

    private final ConsultationDao consultationDao = new ConsultationDao();
    private final PatientDao patientDao = new PatientDao();

    /**
     * Créer une nouvelle consultation
     */
    public Consultation creerConsultation(Long patientId, MedecinGeneraliste medecin,
                                          String motif, String observations,
                                          String diagnostic, String traitement, Double cout) {

        // Vérifier que le patient existe
        Patient patient = patientDao.findById(patientId);
        if (patient == null) {
            throw new IllegalArgumentException("Patient introuvable avec l'ID: " + patientId);
        }

        // Créer la consultation
        Consultation consultation = new Consultation(patient, medecin, motif, observations, diagnostic, traitement, cout);
        consultation.setStatus(Consultation.Status.TERMINEE);

        // Sauvegarder la consultation
        consultation = consultationDao.save(consultation);

        // Retirer le patient de la file d'attente
        patient.setFileAttente(false);
        patientDao.save(patient);

        return consultation;
    }

    /**
     * Récupérer toutes les consultations d'un médecin
     */
    public List<Consultation> getConsultationsByMedecin(Long medecinId) {
        return consultationDao.findByMedecinGeneraliste(medecinId);
    }

    /**
     * Récupérer toutes les consultations d'un patient
     */
    public List<Consultation> getConsultationsByPatient(Long patientId) {
        return consultationDao.findByPatient(patientId);
    }

    /**
     * Récupérer une consultation par ID
     */
    public Consultation getConsultationById(Long id) {
        return consultationDao.findById(id);
    }

    /**
     * Compter le nombre de consultations d'un médecin
     */
    public Long countConsultationsByMedecin(Long medecinId) {
        return consultationDao.countByMedecin(medecinId);
    }

    /**
     * Mettre à jour le statut d'une consultation
     */
    public Consultation updateStatus(Long consultationId, Consultation.Status newStatus) {
        Consultation consultation = consultationDao.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        consultation.setStatus(newStatus);
        return consultationDao.save(consultation);
    }
}
