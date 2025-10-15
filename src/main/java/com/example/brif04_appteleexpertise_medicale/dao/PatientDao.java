package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.Patient;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class PatientDao {

    // Méthode pour sauvegarder un patient dans la base de données
    public Patient save(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            // Si l'ID est null, c'est une création (persist)
            // Sinon c'est une modification (merge)
            if (patient.getId() == null) {
                em.persist(patient);
            } else {
                patient = em.merge(patient);
            }

            em.getTransaction().commit();
            return patient;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde du patient", e);
        } finally {
            em.close();
        }
    }

    // Méthode pour récupérer un patient par ID
    public Patient findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    // Méthode pour récupérer tous les patients
    public List<Patient> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p ORDER BY p.id DESC",
                Patient.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Méthode pour récupérer les patients en attente (file d'attente)
    public List<Patient> findPatientsEnAttente() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.fileAttente = true ORDER BY p.id ASC",
                Patient.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Méthode pour compter le nombre total de patients
    public Long countAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(p) FROM Patient p",
                Long.class
            );
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Méthode pour compter les patients en attente
    public Long countPatientsEnAttente() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(p) FROM Patient p WHERE p.fileAttente = true",
                Long.class
            );
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Méthode pour compter les patients traités
    public Long countPatientsTraites() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(p) FROM Patient p WHERE p.fileAttente = false",
                Long.class
            );
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    // Méthode pour rechercher un patient par numéro de sécurité sociale
    public Patient findByNumSecu(String numSecu) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.numSecu = :numSecu",
                Patient.class
            );
            query.setParameter("numSecu", numSecu);

            List<Patient> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);

        } finally {
            em.close();
        }
    }

    // Méthode pour supprimer un patient
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du patient", e);
        } finally {
            em.close();
        }
    }
}

