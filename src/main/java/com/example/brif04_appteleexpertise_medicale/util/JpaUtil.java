package com.example.brif04_appteleexpertise_medicale.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {

    private static final String PERSISTENCE_UNIT_NAME = "default";
    private static EntityManagerFactory emf;

    static {
        try {
            emf = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("EntityManagerFactory creation failed: " + e);
        }
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }


    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }


    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
