package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.Utilisateur;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;


public class UserDao {

    public void save(Utilisateur utilisateur) throws Exception {
        EntityManager em = null;

        try {
            em = JpaUtil.getEntityManager();

            EntityTransaction transaction = em.getTransaction();
            transaction.begin();
            em.persist(utilisateur);
            transaction.commit();

        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public Utilisateur findByEmail(String email) {
        EntityManager em = null;
        Utilisateur utilisateur = null;

        try {
            em = JpaUtil.getEntityManager();
            TypedQuery<Utilisateur> query = em.createQuery("SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class);
            query.setParameter("email", email);
            utilisateur = query.getResultStream().findFirst().orElse(null);

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }

        return utilisateur;
    }
}
