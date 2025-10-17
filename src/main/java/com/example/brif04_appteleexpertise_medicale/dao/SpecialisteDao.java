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
}
