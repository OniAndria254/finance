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

    public void addBilan(Integer entrepriseId, Integer categorieId, Integer sousCategorieId,
                         Integer sousSousCategorieId, Double valeur, String date, String description) {
        Bilan bilan = new Bilan();

        // Vérifications et affectations conditionnelles
        bilan.setEntrepriseByIdEntreprise(entrepriseService.getEntrepriseById(entrepriseId)); // Non nullable
        bilan.setCategorieByIdCategorie(categorieService.getCategorieById(categorieId)); // Non nullable

        // Vérifier si sousCategorieId est non nul avant d'appeler le service
        if (sousCategorieId != null) {
            bilan.setSousCategorieByIdSousCategorie(sousCategorieService.getSousCategorieById(sousCategorieId));
        } else {
            bilan.setSousCategorieByIdSousCategorie(null); // Permet de définir explicitement la valeur comme null
        }

        // Vérifier si sousSousCategorieId est non nul avant d'appeler le service
        if (sousSousCategorieId != null) {
            bilan.setSousSousCategorieByIdSousSousCategorie(sousSousCategorieService.getSousSousCategorieById(sousSousCategorieId));
        } else {
            bilan.setSousSousCategorieByIdSousSousCategorie(null); // Permet de définir explicitement la valeur comme null
        }

        // Vérifier si description est non nulle
        if (description != null && !description.trim().isEmpty()) {
            bilan.setDescriptionNote(description);
        } else {
            bilan.setDescriptionNote(null); // Permet de définir explicitement la valeur comme null
        }

        // Champs obligatoires
        bilan.setValeur(valeur); // Non nullable
        bilan.setDateEnregistrement(Date.valueOf(LocalDate.parse(date))); // Date est obligatoire

        // Enregistrer l'objet dans le repository
        bilanRepository.save(bilan);
    }

    public List<Bilan> getAllBilans() {
        return bilanRepository.findAll();
    }

}