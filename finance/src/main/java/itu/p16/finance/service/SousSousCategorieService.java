package itu.p16.finance.service;

import itu.p16.finance.entity.SousSousCategorie;
import itu.p16.finance.repository.SousCategorieRepository;
import itu.p16.finance.repository.SousSousCategorieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SousSousCategorieService {

    @Autowired
    private SousSousCategorieRepository sousSousCategorieRepository;
    @Autowired
    private SousCategorieRepository sousCategorieRepository;


    public List<SousSousCategorie> getSousSousCategoriesBySousCategorie(Integer sousCategorieId) {
        return sousSousCategorieRepository.findBySousCategorieByIdSousCategorie(sousCategorieRepository.findById(sousCategorieId).orElseThrow());
    }

    public SousSousCategorie getSousSousCategorieById(Integer id) {
        return sousSousCategorieRepository.findById(id).orElseThrow(() -> new RuntimeException("Sous-sous-catégorie non trouvée"));
    }
}