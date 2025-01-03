package itu.p16.finance.service;

import itu.p16.finance.entity.CompteResultat;
import itu.p16.finance.entity.CompteResultatDetails;
import itu.p16.finance.repository.CompteResultatDetailsRepository;
import itu.p16.finance.repository.CompteResultatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompteResultatService {

    @Autowired
    private CompteResultatRepository compteResultatRepository;

    @Autowired
    private CompteResultatDetailsRepository compteResultatDetailsRepository;

    // Ajouter un compte résultat
    public CompteResultat ajouterCompteResultat(CompteResultat resultat) {
        return compteResultatRepository.save(resultat);
    }

    // Ajouter un détail de compte résultat
    public void ajouterCompteResultatDetails(CompteResultatDetails details) {
        compteResultatDetailsRepository.save(details);
    }

    // Récupérer tous les détails d'un compte résultat par ID résultat
    public List<CompteResultatDetails> getDetailsByResultatId(Integer idResultat) {
        return compteResultatDetailsRepository.findAll()
                .stream()
                .filter(d -> d.getIdResultat().equals(idResultat))
                .toList();
    }

    public List<CompteResultatDetails> getCompteResultatDetailsByEntrepriseAndYear(Integer idEntreprise, Integer annee) {
        return compteResultatDetailsRepository.findByEntrepriseAndAnnee(idEntreprise, annee);
    }

    // Calculer la marge nette
    public double calculateMargeNette(Integer idEntreprise, Integer annee) {
        // Récupérer tous les détails du compte résultat pour l'entreprise et l'année spécifiées
        List<CompteResultatDetails> details = getCompteResultatDetailsByEntrepriseAndYear(idEntreprise, annee);

        double revenus = 0;
        double resultatNet = 0;

        // Rechercher les valeurs des revenus et du résultat net dans les détails du compte résultat
        for (CompteResultatDetails detail : details) {
            if ("Revenus".equals(detail.getSousCategorie())) {
                revenus += detail.getMontant().doubleValue();
            }
            if ("Resultat net".equals(detail.getSousCategorie())) {
                resultatNet += detail.getMontant().doubleValue();
            }
        }

        // Si les revenus sont égaux à 0, éviter la division par zéro
        if (revenus == 0) {
            return 0;
        }

        // Calcul de la marge nette
        return (resultatNet / revenus) * 100;
    }
}