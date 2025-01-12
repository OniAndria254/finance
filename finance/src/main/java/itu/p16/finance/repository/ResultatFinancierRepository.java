package itu.p16.finance.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import itu.p16.finance.entity.ResultatFinancier;

import org.springframework.data.jpa.repository.JpaRepository;


@Repository
public interface ResultatFinancierRepository extends JpaRepository<ResultatFinancier, Long> {
    @Query(nativeQuery = true, value = "SELECT * FROM vue_production_exercice(:annee)")
    Double getProductionExercice(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_consommation_exercice(:annee)")
    Double getConsommationExercice(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_valeur_ajoutee(:annee)")
    Double getValeurAjoutee(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_ebe(:annee)")
    Double getEbe(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_resultat_operationnel(:annee)")
    Double getResultatOperationnel(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_resultat_financier(:annee)")
    Double getResultatFinancier(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_resultat_avant_impots(:annee)")
    Double getResultatAvantImpots(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_resultat_net_ordinaire(:annee)")
    Double getResultatNetOrdinaire(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_resultat_extraordinaire(:annee)")
    Double getResultatExtraordinaire(@Param("annee") int annee);

    @Query(nativeQuery = true, value = "SELECT * FROM vue_resultat_net(:annee)")
    Double getResultatNet(@Param("annee") int annee);
}

