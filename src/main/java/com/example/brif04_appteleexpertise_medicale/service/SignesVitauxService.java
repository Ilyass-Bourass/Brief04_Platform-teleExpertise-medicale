package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.SignesVitauxDao;
import com.example.brif04_appteleexpertise_medicale.entity.Patient;
import com.example.brif04_appteleexpertise_medicale.entity.SignesVitaux;

public class SignesVitauxService {

    private final SignesVitauxDao signesVitauxDao = new SignesVitauxDao();

    public SignesVitaux creerEtAssocierSignesVitaux(Patient patient, String tension,
                                                     Integer frequenceCardiaque,
                                                     Double temperature,
                                                     Integer frequenceRespiratoire,
                                                     Double poids, Double taille) {

        SignesVitaux signesVitaux = new SignesVitaux(patient, tension, frequenceCardiaque,
                                                     temperature, frequenceRespiratoire,
                                                     poids, taille);

        SignesVitaux saved = signesVitauxDao.save(signesVitaux);

        patient.setSignesVitaux(saved);

        return saved;
    }

    public SignesVitaux creerSignesVitaux(String tension, Integer frequenceCardiaque,
                                          Double temperature, Integer frequenceRespiratoire,
                                          Double poids, Double taille) {

        SignesVitaux signesVitaux = new SignesVitaux(null, tension, frequenceCardiaque,
                                                     temperature, frequenceRespiratoire,
                                                     poids, taille);

        return signesVitauxDao.save(signesVitaux);
    }

    public SignesVitaux getSignesVitauxById(Long id) {
        return signesVitauxDao.findById(id);
    }

    public SignesVitaux updateSignesVitaux(SignesVitaux signesVitaux) {
        return signesVitauxDao.save(signesVitaux);
    }
}
