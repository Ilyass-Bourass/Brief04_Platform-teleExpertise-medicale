package com.example.brif04_appteleexpertise_medicale.service;

import com.example.brif04_appteleexpertise_medicale.dao.SpecialisteDao;
import com.example.brif04_appteleexpertise_medicale.entity.MedecinSpecialiste;

import java.util.List;

public class SpecialisteService {
    private final SpecialisteDao specialisteDao = new SpecialisteDao();

    public List<MedecinSpecialiste> getAllSpecialistes() {
        return specialisteDao.findAll();
    }

    public MedecinSpecialiste getSpecialisteById(Long id) {
        return specialisteDao.findById(id);
    }

    public void updateSpecialiste(MedecinSpecialiste specialiste) {
        specialisteDao.update(specialiste);
    }
}
