package com.example.brif04_appteleexpertise_medicale.dao;

import com.example.brif04_appteleexpertise_medicale.entity.SignesVitaux;
import com.example.brif04_appteleexpertise_medicale.util.JpaUtil;
import jakarta.persistence.EntityManager;

public class SignesVitauxDao {

    // Méthode pour sauvegarder les signes vitaux dans la base de données
    public SignesVitaux save(SignesVitaux signesVitaux) {
        EntityManager em = JpaUtil.getEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Si l'ID est null, c'est une création (persist)
            // Sinon c'est une modification (merge)
            if (signesVitaux.getId() == null) {
                em.persist(signesVitaux);
            } else {
                signesVitaux = em.merge(signesVitaux);
            }
            
            em.getTransaction().commit();
            return signesVitaux;
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde des signes vitaux", e);
        } finally {
            em.close();
        }
    }

    // Méthode pour récupérer les signes vitaux par ID
    public SignesVitaux findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        
        try {
            return em.find(SignesVitaux.class, id);
        } finally {
            em.close();
        }
    }

    // Méthode pour supprimer les signes vitaux
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        
        try {
            em.getTransaction().begin();
            
            SignesVitaux signesVitaux = em.find(SignesVitaux.class, id);
            if (signesVitaux != null) {
                em.remove(signesVitaux);
            }
            
            em.getTransaction().commit();
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression des signes vitaux", e);
        } finally {
            em.close();
        }
    }
}

