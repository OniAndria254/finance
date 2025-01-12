package itu.p16.finance.service;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.repository.BilanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class BilanService {

    @Autowired
    private BilanRepository bilanRepository;

    @Autowired
    private EntrepriseService entrepriseService;

    @Autowired
    private CategorieService categorieService;

    @Autowired
    private SousCategorieService sousCategorieService;

    @Autowired
    private SousSousCategorieService sousSousCategorieService;

    public void addBilan(Integer entrepriseId, Integer categorieId, Integer sousCategorieId, Integer sousSousCategorieId, Double valeur, String date, String description) {
        Bilan bilan = new Bilan();
        bilan.setEntrepriseByIdEntreprise(entrepriseService.getEntrepriseById(entrepriseId));
        bilan.setCategorieByIdCategorie(categorieService.getCategorieById(categorieId));
        bilan.setSousCategorieByIdSousCategorie(sousCategorieService.getSousCategorieById(sousCategorieId));
        bilan.setSousSousCategorieByIdSousSousCategorie(sousSousCategorieService.getSousSousCategorieById(sousSousCategorieId));
        bilan.setDescriptionNote(description);
        bilan.setValeur(valeur);
        bilan.setDateEnregistrement(Date.valueOf(LocalDate.parse(date)));
        bilanRepository.save(bilan);
    }

    public List<Bilan> getAllBilans() {
        return bilanRepository.findAll();
    }

}