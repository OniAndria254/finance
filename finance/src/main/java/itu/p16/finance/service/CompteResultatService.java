package itu.p16.finance.service;

import itu.p16.finance.repository.CompteResultatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class CompteResultatService {

    @Autowired
    private CompteResultatRepository compteResultatRepository;

    public Map<String, Object> getCompteResultat(int annee, Integer entrepriseId) {
        Map<String, Object> compteResultat = new LinkedHashMap<>();

        // Récupérer les données des fonctions SQL
        BigDecimal productionExercice = compteResultatRepository.getProductionExercice(annee, entrepriseId);
        BigDecimal consommationExercice = compteResultatRepository.getConsommationExercice(annee, entrepriseId);
        BigDecimal valeurAjoutee = compteResultatRepository.getValeurAjoutee(annee, entrepriseId);
        BigDecimal ebe = compteResultatRepository.getEBE(annee, entrepriseId);
        BigDecimal resultatOperationnel = compteResultatRepository.getResultatOperationnel(annee, entrepriseId);
        BigDecimal resultatFinancier = compteResultatRepository.getResultatFinancier(annee, entrepriseId);
        BigDecimal resultatAvantImpots = compteResultatRepository.getResultatAvantImpots(annee, entrepriseId);
        BigDecimal resultatNetOrdinaire = compteResultatRepository.getResultatNetOrdinaire(annee, entrepriseId);
        BigDecimal resultatExtraordinaire = compteResultatRepository.getResultatExtraordinaire(annee, entrepriseId);
        BigDecimal resultatNet = compteResultatRepository.getResultatNet(annee, entrepriseId);
        BigDecimal impotsExigibles = compteResultatRepository.getImpotsExigibles(annee, entrepriseId);
        BigDecimal impotsDifferes = compteResultatRepository.getImpotsDifferes(annee, entrepriseId);
        BigDecimal produitsExtraordinaires = compteResultatRepository.getProduitsExtraordinaires(annee, entrepriseId);
        BigDecimal chargesExtraordinaires = compteResultatRepository.getChargesExtraordinaires(annee, entrepriseId);

        // Ajouter les données au compte de résultat
        compteResultat.put("Production de l'exercice", productionExercice);
        compteResultat.put("Consommation de l'exercice", consommationExercice);
        compteResultat.put("Valeur ajoutée", valeurAjoutee);
        compteResultat.put("EBE", ebe);
        compteResultat.put("Résultat opérationnel", resultatOperationnel);
        compteResultat.put("Résultat financier", resultatFinancier);
        compteResultat.put("Résultat avant impôts", resultatAvantImpots);
        compteResultat.put("Résultat net ordinaire", resultatNetOrdinaire);
        compteResultat.put("Résultat extraordinaire", resultatExtraordinaire);
        compteResultat.put("Résultat net", resultatNet);
        compteResultat.put("Impôts exigibles", impotsExigibles);
        compteResultat.put("Impôts différés", impotsDifferes);
        compteResultat.put("Produits extraordinaires", produitsExtraordinaires);
        compteResultat.put("Charges extraordinaires", chargesExtraordinaires);

        return compteResultat;
    }

//    public Map<String, Object> getCompteResultat(int annee, Integer entrepriseId) {
//        Map<String, Object> compteResultat = new LinkedHashMap<>();
//
//        // Récupérer les données des vues SQL
//        BigDecimal productionExercice = compteResultatRepository.getProductionExercice(annee, entrepriseId);
//        BigDecimal consommationExercice = compteResultatRepository.getConsommationExercice(annee, entrepriseId);
//        BigDecimal valeurAjoutee = compteResultatRepository.getValeurAjoutee(annee, entrepriseId);
//        BigDecimal ebe = compteResultatRepository.getEBE(annee, entrepriseId);
//
//        // Ajouter les données au compte de résultat
//        compteResultat.put("Production de l'exercice", productionExercice);
//        compteResultat.put("Consommation de l'exercice", consommationExercice);
//        compteResultat.put("Valeur ajoutée d'exploitation", valeurAjoutee);
//        compteResultat.put("Excédent brut d'exploitation (EBE)", ebe);
//
//        return compteResultat;
//    }

    public Map<String, BigDecimal> calculateIndicateursFinanciers(int annee, Integer entrepriseId) {
        Map<String, BigDecimal> indicateurs = new HashMap<>();

        // Récupérer les données du repository
        BigDecimal resultatNet = compteResultatRepository.getResultatNet(annee, entrepriseId);
        BigDecimal revenus = compteResultatRepository.getRevenus(annee, entrepriseId);
        BigDecimal totalActifs = compteResultatRepository.getTotalActifs(annee, entrepriseId);
        BigDecimal capitauxPropres = compteResultatRepository.getCapitauxPropres(annee, entrepriseId);
        BigDecimal actifsCourants = compteResultatRepository.getActifsCourants(annee, entrepriseId);
        BigDecimal passifsCourants = compteResultatRepository.getPassifsCourants(annee, entrepriseId);
        BigDecimal stocks = compteResultatRepository.getStocks(annee, entrepriseId);
        BigDecimal totalDettes = compteResultatRepository.getTotalDettes(annee, entrepriseId);
        BigDecimal resultatExploitation = compteResultatRepository.getResultatOperationnel(annee, entrepriseId);
        BigDecimal chargesFinancieres = compteResultatRepository.getChargesFinancieres(annee, entrepriseId);

        // Calculer les indicateurs
        MathContext mc = new MathContext(6, RoundingMode.HALF_UP); // 6 chiffres de précision, arrondi HALF_UP

// Calculer les indicateurs
        BigDecimal margeNette = BigDecimal.ZERO;
        if (revenus.compareTo(BigDecimal.ZERO) != 0) {
            margeNette = resultatNet.divide(revenus, mc).multiply(BigDecimal.valueOf(100));
        }

        BigDecimal roa = BigDecimal.ZERO;
        if (totalActifs.compareTo(BigDecimal.ZERO) != 0) {
            roa = resultatNet.divide(totalActifs, mc).multiply(BigDecimal.valueOf(100));
        }

        BigDecimal roe = BigDecimal.ZERO;
        if (capitauxPropres.compareTo(BigDecimal.ZERO) != 0) {
            roe = resultatNet.divide(capitauxPropres, mc).multiply(BigDecimal.valueOf(100));
        }

        BigDecimal liquiditeGenerale = BigDecimal.ZERO;
        if (passifsCourants.compareTo(BigDecimal.ZERO) != 0) {
            liquiditeGenerale = actifsCourants.divide(passifsCourants, mc);
        }

        BigDecimal liquiditeReduite = BigDecimal.ZERO;
        if (passifsCourants.compareTo(BigDecimal.ZERO) != 0) {
            liquiditeReduite = (actifsCourants.subtract(stocks)).divide(passifsCourants, mc);
        }

        BigDecimal endettementGlobal = BigDecimal.ZERO;
        if (totalActifs.compareTo(BigDecimal.ZERO) != 0) {
            endettementGlobal = totalDettes.divide(totalActifs, mc).multiply(BigDecimal.valueOf(100));
        }

        BigDecimal couvertureInterets = BigDecimal.ZERO;
        if (chargesFinancieres.compareTo(BigDecimal.ZERO) != 0) {
            couvertureInterets = resultatExploitation.divide(chargesFinancieres, mc);
        }
        // Ajouter les indicateurs à la map
        indicateurs.put("Marge Nette", margeNette);
        indicateurs.put("ROA", roa);
        indicateurs.put("ROE", roe);
        indicateurs.put("Liquidité Générale", liquiditeGenerale);
        indicateurs.put("Liquidité Réduite", liquiditeReduite);
        indicateurs.put("Endettement Global", endettementGlobal);
        indicateurs.put("Couverture des Intérêts", couvertureInterets);

        return indicateurs;
    }
}