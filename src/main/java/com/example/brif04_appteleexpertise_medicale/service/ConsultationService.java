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


    public Consultation creerConsultation(Long patientId, MedecinGeneraliste medecin,
                                          String motif, String observations,
                                          String diagnostic, String traitement, Double cout) {

        Patient patient = patientDao.findById(patientId);
        if (patient == null) {
            throw new IllegalArgumentException("Patient introuvable avec l'ID: " + patientId);
        }

        Consultation consultation = new Consultation(patient, medecin, motif, observations, diagnostic, traitement, cout);
        consultation.setStatus(Consultation.Status.TERMINEE);

        consultation = consultationDao.save(consultation);

        patient.setFileAttente(false);
        patientDao.save(patient);

        return consultation;
    }


    public List<Consultation> getConsultationsByMedecin(Long medecinId) {
        return consultationDao.findByMedecinGeneraliste(medecinId);
    }


    public List<Consultation> getConsultationsByPatient(Long patientId) {
        return consultationDao.findByPatient(patientId);
    }


    public Consultation getConsultationById(Long id) {
        return consultationDao.findById(id);
    }


    public Long countConsultationsByMedecin(Long medecinId) {
        return consultationDao.countByMedecin(medecinId);
    }


    public Consultation updateStatus(Long consultationId, Consultation.Status newStatus) {
        Consultation consultation = consultationDao.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        consultation.setStatus(newStatus);
        return consultationDao.save(consultation);
    }

    public List<Consultation> getConsultationsSansDemandeExpertise(Long medecinId) {
        return consultationDao.findByMedecinSansDemandeExpertise(medecinId);
    }
}
