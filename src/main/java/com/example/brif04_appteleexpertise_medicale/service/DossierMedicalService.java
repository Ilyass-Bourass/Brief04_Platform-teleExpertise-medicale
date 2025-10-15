package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.DossierMedicalDao;
import com.example.brif04_appteleexpertise_medicale.entity.DossierMedical;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;

public class DossierMedicalService {

    private final DossierMedicalDao dossierMedicalDao = new DossierMedicalDao();

    public DossierMedical creerEtAssocierDossierMedical(Patient patient, String antecedents,
                                                        String allergies, String traitements) {

        DossierMedical dossierMedical = new DossierMedical(patient, antecedents, allergies, traitements);

        DossierMedical saved = dossierMedicalDao.save(dossierMedical);
        patient.setDossierMedical(saved);
        return saved;
    }

    public DossierMedical creerDossierMedical(String antecedents, String allergies,
                                              String traitements) {

        DossierMedical dossierMedical = new DossierMedical(null, antecedents, allergies, traitements);

        return dossierMedicalDao.save(dossierMedical);
    }

    public DossierMedical getDossierMedicalById(Long id) {
        return dossierMedicalDao.findById(id);
    }

    public DossierMedical updateDossierMedical(DossierMedical dossierMedical) {
        return dossierMedicalDao.update(dossierMedical);
    }
}
