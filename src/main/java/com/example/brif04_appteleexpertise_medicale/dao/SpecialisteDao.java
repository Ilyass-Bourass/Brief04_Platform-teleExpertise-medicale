package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class SpecialisteDao {

    public List<MedecinSpecialiste> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<MedecinSpecialiste> query = em.createQuery(
                "SELECT s FROM MedecinSpecialiste s ORDER BY s.nom ASC",
                MedecinSpecialiste.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public MedecinSpecialiste findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.find(MedecinSpecialiste.class, id);
        } finally {
            em.close();
        }
    }

    public MedecinSpecialiste findSpecialisteById(int specialisteId) {
        return findById(Long.valueOf(specialisteId));
    }

    public List<MedecinSpecialiste> findBySpecialite(MedecinSpecialiste.Specialite specialite) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<MedecinSpecialiste> query = em.createQuery(
                "SELECT s FROM MedecinSpecialiste s WHERE s.specialite = :specialite ORDER BY s.nom ASC",
                MedecinSpecialiste.class
            );
            query.setParameter("specialite", specialite);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(MedecinSpecialiste specialiste) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            em.createQuery("UPDATE MedecinSpecialiste s SET " +
                    "s.nom = :nom, " +
                    "s.prenom = :prenom, " +
                    "s.email = :email, " +
                    "s.specialite = :specialite, " +
                    "s.tarif = :tarif, " +
                    "s.dureeConsultation = :duree " +
                    "WHERE s.id = :id")
                .setParameter("nom", specialiste.getNom())
                .setParameter("prenom", specialiste.getPrenom())
                .setParameter("email", specialiste.getEmail())
                .setParameter("specialite", specialiste.getSpecialite())
                .setParameter("tarif", specialiste.getTarif())
                .setParameter("duree", specialiste.getDureeConsultation())
                .setParameter("id", specialiste.getId())
                .executeUpdate();

            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la mise à jour du spécialiste", e);
        } finally {
            em.close();
        }
    }
}
