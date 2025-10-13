package com.example.brif04_appteleexpertise_medicale.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;


public class EntityManagerUtil {


    private static EntityManagerFactory entityManagerFactory;


    static {
        try {

            entityManagerFactory = Persistence.createEntityManagerFactory("default");
            System.out.println("✅ Connexion à la base de données initialisée avec succès !");
        } catch (Exception e) {
            System.err.println("❌ ERREUR : Impossible de se connecter à la base de données !");
            e.printStackTrace();
            throw new ExceptionInInitializerError("Échec de création EntityManagerFactory: " + e);
        }
    }


    public static EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }


    public static void closeEntityManagerFactory() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
            System.out.println("🔒 Connexions à la base de données fermées.");
        }
    }
}
