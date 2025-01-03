package itu.p16.finance.service;

import itu.p16.finance.entity.BilanDetails;
import itu.p16.finance.entity.CompteResultatDetails;
import itu.p16.finance.repository.BilanDetailsRepository;
import itu.p16.finance.repository.CompteResultatDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IndicateursFinanciersService {

    @Autowired
    private CompteResultatDetailsRepository compteResultatDetailsRepository;

    @Autowired
    private BilanDetailsRepository bilanDetailsRepository;

    // Calcul du Retour sur Actifs (ROA)
    public double calculerROA(Integer idEntreprise, Integer annee) {
        double resultatNet = getResultatNet(idEntreprise, annee);
        double actifsTotaux = getActifsTotaux(idEntreprise, annee);

        if (actifsTotaux == 0) {
            return 0; // Eviter la division par zéro
        }
        return (resultatNet / actifsTotaux) * 100;
    }

    // Calcul de la Marge nette
    public double calculerMargeNette(Integer idEntreprise, Integer annee) {
        double resultatNet = getResultatNet(idEntreprise, annee);
        double revenus = getRevenus(idEntreprise, annee);

        if (revenus == 0) {
            return 0;
        }
        return (resultatNet / revenus) * 100;
    }

    // Calcul de la rentabilité des capitaux propres
    public double calculerRentabiliteCapitauxPropres(Integer idEntreprise, Integer annee) {
        double resultatNet = getResultatNet(idEntreprise, annee);
        double capitauxPropres = getCapitauxPropres(idEntreprise, annee);

        if (capitauxPropres == 0) {
            return 0;
        }
        return (resultatNet / capitauxPropres) * 100;
    }

    // Calcul du ratio de liquidité
    public double calculerRatioLiquidite(Integer idEntreprise, Integer annee) {
        double actifsCourants = getActifsCourants(idEntreprise, annee);
        double passifsCourants = getPassifsCourants(idEntreprise, annee);

        if (passifsCourants == 0) {
            return 0;
        }
        return actifsCourants / passifsCourants;
    }

    // Méthodes pour récupérer les valeurs spécifiques depuis la base de données

    public double getResultatNet(Integer idEntreprise, Integer annee) {
        List<CompteResultatDetails> details = compteResultatDetailsRepository.findByEntrepriseAndAnnee(idEntreprise, annee);
        double resultatNet = 0;

        for (CompteResultatDetails detail : details) {
            if ("Resultat net".equalsIgnoreCase(detail.getSousCategorie())) {
                resultatNet += detail.getMontant().doubleValue();
            }
        }
        return resultatNet;
    }

    public double getRevenus(Integer idEntreprise, Integer annee) {
        List<CompteResultatDetails> details = compteResultatDetailsRepository.findByEntrepriseAndAnnee(idEntreprise, annee);
        double revenus = 0;

        for (CompteResultatDetails detail : details) {
            if ("Revenus".equalsIgnoreCase(detail.getSousCategorie())) {
                revenus += detail.getMontant().doubleValue();
            }
        }
        return revenus;
    }

    public double getActifsTotaux(Integer idEntreprise, Integer annee) {
        List<BilanDetails> bilanDetails = bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
        double actifsTotaux = 0;

        for (BilanDetails detail : bilanDetails) {
            if ("Actifs".equalsIgnoreCase(detail.getCategorie())) {
                actifsTotaux += detail.getMontant().doubleValue();
            }
        }
        return actifsTotaux;
    }

    public double getCapitauxPropres(Integer idEntreprise, Integer annee) {
        List<BilanDetails> bilanDetails = bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
        double capitauxPropres = 0;

        for (BilanDetails detail : bilanDetails) {
            if ("Capitaux propres".equalsIgnoreCase(detail.getCategorie())) {
                capitauxPropres += detail.getMontant().doubleValue();
            }
        }
        return capitauxPropres;
    }

    public double getActifsCourants(Integer idEntreprise, Integer annee) {
        List<BilanDetails> bilanDetails = bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
        double actifsCourants = 0;

        for (BilanDetails detail : bilanDetails) {
            if ("Actifs courants".equals(detail.getSousCategorie())) {
                actifsCourants += detail.getMontant().doubleValue();
            }
        }
        return actifsCourants;
    }

    public double getPassifsCourants(Integer idEntreprise, Integer annee) {
        List<BilanDetails> bilanDetails = bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
        double passifsCourants = 0;

        for (BilanDetails detail : bilanDetails) {
            if ("Passifs courants".equals(detail.getSousCategorie())) {
                passifsCourants += detail.getMontant().doubleValue();
            }
        }
        return passifsCourants;
    }

    // Calcul du Ratio de Liquidité Réduite
    public double calculerRatioLiquiditeReduite(Integer idEntreprise, Integer annee, double stock) {
        double actifsCourants = getActifsCourants(idEntreprise, annee);
        double passifsCourants = getPassifsCourants(idEntreprise, annee);

        // Exclure les stocks des actifs courants
        double actifsLiquides = actifsCourants - stock;

        if (passifsCourants == 0) {
            return 0; // Eviter la division par zéro
        }
        return actifsLiquides / passifsCourants;
    }

    public double calculerLevierFinancier(Integer idEntreprise, Integer annee) {
        double totalActifs = getActifsTotaux(idEntreprise, annee);
        double capitauxPropres = getCapitauxPropres(idEntreprise, annee);
        if (capitauxPropres == 0) {
            return 0; // Eviter la division par zéro
        }
        return totalActifs / capitauxPropres;
    }

    public double calculerROEAvecLevier(double roa, double tauxInteretDettes, double levierFinancier) {
        // Calcul de l'effet de levier sur le ROE
        return roa + ((roa - tauxInteretDettes) * levierFinancier);
    }

}
