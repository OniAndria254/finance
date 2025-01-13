package itu.p16.finance.repository;

import itu.p16.finance.entity.Bilan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
public interface CompteResultatRepository extends JpaRepository<Bilan, Integer> {

    @Query(value = "SELECT * FROM vue_production_exercice(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getProductionExercice(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_consommation_exercice(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getConsommationExercice(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_valeur_ajoutee(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getValeurAjoutee(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_ebe(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getEBE(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_operationnel(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatOperationnel(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_financier(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatFinancier(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_avant_impots(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatAvantImpots(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_net_ordinaire(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatNetOrdinaire(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_extraordinaire(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatExtraordinaire(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_net(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatNet(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_impots_exigibles(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getImpotsExigibles(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_impots_differes(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getImpotsDifferes(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_produits_extraordinaires(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getProduitsExtraordinaires(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_charges_extraordinaires(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getChargesExtraordinaires(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);






    // Récupérer le résultat net
//    @Query(value = "SELECT resultat_net FROM vue_resultat_net WHERE annee = :annee AND entreprise_id = :entrepriseId", nativeQuery = true)
//    BigDecimal getResultatNet(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer les revenus (chiffre d'affaires)
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '71%') AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getRevenus(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer le total des actifs
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Categorie IN (1, 2) AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getTotalActifs(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer les capitaux propres
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Categorie = 3 AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getCapitauxPropres(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer les actifs courants
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Categorie = 2 AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getActifsCourants(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer les passifs courants
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Categorie = 5 AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getPassifsCourants(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer les stocks
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '3%') AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getStocks(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer le total des dettes
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Categorie IN (4, 5) AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getTotalDettes(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer le résultat d'exploitation
    @Query(value = "SELECT resultat_operationnel FROM vue_resultat_operationnel WHERE annee = :annee AND entreprise_id = :entrepriseId", nativeQuery = true)
    BigDecimal getResultatExploitation(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    // Récupérer les charges financières
    @Query(value = "SELECT COALESCE(SUM(valeur), 0) FROM Bilan WHERE Id_Sous_Categorie IN (SELECT Id_Sous_Categorie FROM Sous_Categorie WHERE compte::text LIKE '66%') AND EXTRACT(YEAR FROM date_enregistrement) = :annee AND Id_Entreprise = :entrepriseId", nativeQuery = true)
    BigDecimal getChargesFinancieres(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);
}