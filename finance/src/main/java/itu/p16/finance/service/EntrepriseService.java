package itu.p16.finance.service;

import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.repository.EntrepriseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EntrepriseService {

    @Autowired
    private EntrepriseRepository entrepriseRepository;

    // Créer une entreprise
    public void saveEntreprise(Entreprise entreprise) {
        entrepriseRepository.save(entreprise);
    }

    // Lire toutes les entreprises
    public List<Entreprise> getAllEntreprises() {
        return entrepriseRepository.findAll();
    }


    // Mettre à jour une entreprise
    public void updateEntreprise(Integer id, Entreprise updatedEntreprise) {
        entrepriseRepository.findById(id).map(entreprise -> {
            entreprise.setNom(updatedEntreprise.getNom());
            return entrepriseRepository.save(entreprise);
        }).orElseThrow(() -> new RuntimeException("Entreprise non trouvée"));
    }

    // Supprimer une entreprise
    public void deleteEntreprise(Integer id) {
        entrepriseRepository.deleteById(id);
    }

    public Entreprise getEntrepriseById(Integer id) {
        return entrepriseRepository.findById(id).orElseThrow(() -> new RuntimeException("Entreprise non trouvée"));
    }
}