package itu.p16.finance.service;

import itu.p16.finance.entity.Categorie;
import itu.p16.finance.repository.CategorieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategorieService {

    @Autowired
    private CategorieRepository categorieRepository;

    public List<Categorie> getAllCategories() {
        return categorieRepository.findAll();
    }

    public List<Categorie> getPostesBilan() {
        return categorieRepository.findByCompteBetween(100, 500);
    }

    /**
     * Récupère toutes les catégories de type "produits et charges" (comptes 600 et 700).
     */
    public List<Categorie> getProduitsEtCharges() {
        return categorieRepository.findByCompteIn(List.of(600, 700));
    }

    public Categorie getCategorieById(Integer id) {
        return categorieRepository.findById(id).orElseThrow(() -> new RuntimeException("Catégorie non trouvée"));
    }
}