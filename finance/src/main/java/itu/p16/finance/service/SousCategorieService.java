package itu.p16.finance.service;

import itu.p16.finance.entity.SousCategorie;
import itu.p16.finance.repository.CategorieRepository;
import itu.p16.finance.repository.SousCategorieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SousCategorieService {

    @Autowired
    private SousCategorieRepository sousCategorieRepository;
    @Autowired
    private CategorieRepository categorieRepository;

    public List<SousCategorie> getSousCategoriesByCategorie(Integer categorieId) {
        return sousCategorieRepository.findByCategorieByIdCategorie(categorieRepository.findById(categorieId).orElseThrow());
    }

    public SousCategorie getSousCategorieById(Integer id) {
        return sousCategorieRepository.findById(id).orElseThrow(() -> new RuntimeException("Sous-catégorie non trouvée"));
    }
}