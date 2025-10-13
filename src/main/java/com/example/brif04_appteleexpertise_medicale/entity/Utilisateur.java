package com.example.brif04_appteleexpertise_medicale.entity;

import jakarta.persistence.*;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)

@DiscriminatorColumn(name = "user_role", discriminatorType = DiscriminatorType.STRING)
@Table(name = "utilisateur")

public abstract class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;

    @Enumerated(EnumType.STRING)
    private Role role;

    public enum Role {
        INFIRMIER, GENERALISTE, SPECIALISTE
    }

    protected Utilisateur() {}
    protected   Utilisateur(String nom , String prenom,String email,String motDePasse, Role role){
        this.nom=nom;
        this.prenom=prenom;
        this.email=email;
        this.motDePasse=motDePasse;
        this.role =role;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
