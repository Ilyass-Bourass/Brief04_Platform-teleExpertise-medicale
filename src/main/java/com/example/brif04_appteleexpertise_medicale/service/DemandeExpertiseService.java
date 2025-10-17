package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.DemandeExpertiseDao;
import com.example.brif04_appteleexpertise_medicale.dao.SpecialisteDao;
import com.example.brif04_appteleexpertise_medicale.dao.ConsultationDao;
import com.example.brif04_appteleexpertise_medicale.entity.Consultation;
import com.example.brif04_appteleexpertise_medicale.entity.DemandeExpertise;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;

import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

public class DemandeExpertiseService {

    private final DemandeExpertiseDao demandeDao = new DemandeExpertiseDao();
    private final SpecialisteDao specialisteDao = new SpecialisteDao();
    private final ConsultationDao consultationDao = new ConsultationDao();

    private static final List<String> TOUS_LES_CRENEAUX = Arrays.asList(
        "09h00-10h00",
        "10h00-11h00",
        "14h00-15h00",
        "15h00-16h00"
    );


    public List<String> getCreneauxDisponibles(Long specialisteId, String dateRendezVous) {
        // Récupérer les créneaux déjà réservés pour ce spécialiste à cette date
        List<String> creneauxReserves = demandeDao.findCreneauxReserves(specialisteId, dateRendezVous);

        // Créer une liste des créneaux disponibles (ceux qui ne sont PAS réservés)
        List<String> creneauxDisponibles = new ArrayList<>();
        for (String creneau : TOUS_LES_CRENEAUX) {
            if (!creneauxReserves.contains(creneau)) {
                creneauxDisponibles.add(creneau);
            }
        }

        return creneauxDisponibles;
    }

    /**
     * Créer une nouvelle demande d'expertise
     */
    public DemandeExpertise creerDemandeExpertise(Long consultationId, Long specialisteId,
                                                   String question, String priorite,
                                                   String dateRendezVous, String creneauHoraire) {

        Consultation consultation = consultationDao.findById(consultationId);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable");
        }

        MedecinSpecialiste specialiste = specialisteDao.findById(specialisteId);
        if (specialiste == null) {
            throw new IllegalArgumentException("Spécialiste introuvable");
        }

        List<String> creneauxDisponibles = getCreneauxDisponibles(specialisteId, dateRendezVous);
        if (!creneauxDisponibles.contains(creneauHoraire)) {
            throw new IllegalArgumentException("Ce créneau n'est plus disponible. Un autre médecin l'a déjà réservé.");
        }

        DemandeExpertise demande = new DemandeExpertise();
        demande.setConsultation(consultation);
        demande.setMedecinSpecialiste(specialiste);
        demande.setQuestion(question);
        demande.setDateDemande(LocalDateTime.now());
        demande.setDateRendezVous(dateRendezVous);
        demande.setCreneauHoraire(creneauHoraire);
        demande.setStatus(DemandeExpertise.Status.EN_ATTENTE);

        if (priorite != null && !priorite.isEmpty()) {
            demande.setPriorite(DemandeExpertise.Priorite.valueOf(priorite));
        } else {
            demande.setPriorite(DemandeExpertise.Priorite.NORMALE);
        }

        demande = demandeDao.save(demande);


        consultation.setStatus(Consultation.Status.EN_ATTENTE_AVIS_SPECIALISTE);
        consultationDao.save(consultation);

        return demande;
    }


    public List<DemandeExpertise> getDemandesBySpecialiste(Long specialisteId) {
        return demandeDao.findBySpecialiste(specialisteId);
    }


    public DemandeExpertise getDemandeById(Long id) {
        return demandeDao.findById(id);
    }



    public List<DemandeExpertise> getAllDemandes() {
        return demandeDao.findAll();
    }


    public DemandeExpertise updateDemande(DemandeExpertise demande) {
        return demandeDao.save(demande);
    }
}
