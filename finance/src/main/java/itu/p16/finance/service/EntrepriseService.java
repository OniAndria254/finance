package itu.p16.finance.service;

import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.repository.EntrepriseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EntrepriseService {

    @Autowired
    private EntrepriseRepository entrepriseRepository;

    // Créer une entreprise
    public Entreprise saveEntreprise(Entreprise entreprise) {
        return entrepriseRepository.save(entreprise);
    }

    // Lire toutes les entreprises
    public List<Entreprise> getAllEntreprises() {
        return entrepriseRepository.findAll();
    }

    // Lire une entreprise par ID
    public Optional<Entreprise> getEntrepriseById(Long id) {
        return entrepriseRepository.findById(id);
    }

    // Mettre à jour une entreprise
    public Entreprise updateEntreprise(Long id, Entreprise updatedEntreprise) {
        return entrepriseRepository.findById(id).map(entreprise -> {
            entreprise.setNomEntreprise(updatedEntreprise.getNomEntreprise());
            entreprise.setSecteurActivite(updatedEntreprise.getSecteurActivite());
            entreprise.setDateCreation(updatedEntreprise.getDateCreation());
            return entrepriseRepository.save(entreprise);
        }).orElseThrow(() -> new RuntimeException("Entreprise non trouvée"));
    }

    // Supprimer une entreprise
    public void deleteEntreprise(Long id) {
        entrepriseRepository.deleteById(id);
    }
}