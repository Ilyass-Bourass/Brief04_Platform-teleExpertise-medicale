package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.DemandeExpertise;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class DemandeExpertiseDao {


    public DemandeExpertise save(DemandeExpertise demande) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            if (demande.getId() == null) {
                em.persist(demande);
            } else {
                demande = em.merge(demande);
            }

            em.getTransaction().commit();
            return demande;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde de la demande d'expertise", e);
        } finally {
            em.close();
        }
    }

    public DemandeExpertise findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.find(DemandeExpertise.class, id);
        } finally {
            em.close();
        }
    }

    public List<DemandeExpertise> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d ORDER BY d.dateDemande DESC",
                DemandeExpertise.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<DemandeExpertise> findBySpecialiste(Long specialisteId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d WHERE d.medecinSpecialiste.id = :specialisteId ORDER BY d.dateDemande DESC",
                DemandeExpertise.class
            );
            query.setParameter("specialisteId", specialisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // Récupérer les créneaux déjà réservés pour un spécialiste à une date donnée
    // Cette méthode est ESSENTIELLE pour filtrer les créneaux disponibles !
    public List<String> findCreneauxReserves(Long specialisteId, String dateRendezVous) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<String> query = em.createQuery(
                "SELECT d.creneauHoraire FROM DemandeExpertise d " +
                "WHERE d.medecinSpecialiste.id = :specialisteId " +
                "AND d.dateRendezVous = :dateRendezVous " +
                "AND d.status != 'ANNULEE'",
                String.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("dateRendezVous", dateRendezVous);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}

