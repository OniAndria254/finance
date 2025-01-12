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

    public Categorie getCategorieById(Integer id) {
        return categorieRepository.findById(id).orElseThrow(() -> new RuntimeException("Catégorie non trouvée"));
    }
}