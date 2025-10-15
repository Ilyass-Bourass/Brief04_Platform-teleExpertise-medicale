package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.DossierMedical;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;

public class DossierMedicalDao {

    // Méthode pour sauvegarder le dossier médical dans la base de données
    public DossierMedical save(DossierMedical dossierMedical) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            // Si l'ID est null, c'est une création (persist)
            // Sinon c'est une modification (merge)
            if (dossierMedical.getId() == null) {
                em.persist(dossierMedical);
            } else {
                dossierMedical = em.merge(dossierMedical);
            }

            em.getTransaction().commit();
            return dossierMedical;

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde du dossier médical", e);
        } finally {
            em.close();
        }
    }

    // Méthode pour récupérer le dossier médical par ID
    public DossierMedical findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.find(DossierMedical.class, id);
        } finally {
            em.close();
        }
    }

    // Méthode pour mettre à jour le dossier médical
    public DossierMedical update(DossierMedical dossierMedical) {
        return save(dossierMedical);
    }

    // Méthode pour supprimer le dossier médical
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            DossierMedical dossierMedical = em.find(DossierMedical.class, id);
            if (dossierMedical != null) {
                em.remove(dossierMedical);
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du dossier médical", e);
        } finally {
            em.close();
        }
    }
}

