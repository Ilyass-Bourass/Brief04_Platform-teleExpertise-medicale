package com.example.brif04_appteleexpertise_medicale.entity;


import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@DiscriminatorValue("INFIRMIER")
public class Infirmier extends Utilisateur {

    @OneToMany(mappedBy = "infirmier", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Patient> patients = new ArrayList<>();

    protected Infirmier() {}

    public Infirmier(String nom, String prenom, String email, String motDePasse) {
        super(nom, prenom, email, motDePasse, Role.INFIRMIER);
    }

    public List<Patient> getPatients() {
        return patients;
    }

    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }

}
