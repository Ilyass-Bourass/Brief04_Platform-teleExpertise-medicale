package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.Consultation;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ConsultationDao {

    public Consultation save(Consultation consultation) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            if (consultation.getId() == null) {
                em.persist(consultation);
            } else {
                consultation = em.merge(consultation);
            }

            em.getTransaction().commit();
            return consultation;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de la consultation", e);
        } finally {
            em.close();
        }
    }

    public Consultation findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.find(Consultation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Consultation> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByMedecinGeneraliste(Long medecinId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.medecinGeneraliste.id = :medecinId ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            query.setParameter("medecinId", medecinId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Consultation> findByPatient(Long patientId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.patient.id = :patientId ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Long countByMedecin(Long medecinId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(c) FROM Consultation c WHERE c.medecinGeneraliste.id = :medecinId",
                Long.class
            );
            query.setParameter("medecinId", medecinId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
