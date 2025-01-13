package itu.p16.finance.repository;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface BilanRepository extends JpaRepository<Bilan, Integer> {

    @Query(value = "SELECT b.Id_Bilan, c.Id_Categorie, c.compte AS compte_categorie, c.nom_categorie, " +
            "sc.Id_Sous_Categorie, sc.compte AS compte_sous_categorie, sc.nom_sous_categorie, " +
            "ssc.Id_Sous_Sous_Categorie, ssc.compte AS compte_sous_sous_categorie, ssc.nom, " +
            "b.description_note, b.valeur " +
            "FROM Bilan b " +
            "INNER JOIN Categorie c ON b.Id_Categorie = c.Id_Categorie " +
            "LEFT JOIN Sous_Categorie sc ON b.Id_Sous_Categorie = sc.Id_Sous_Categorie " +
            "LEFT JOIN Sous_Sous_Categorie ssc ON b.Id_Sous_Sous_Categorie = ssc.Id_Sous_Sous_Categorie " +
            "WHERE (c.compte::text LIKE '1%' OR c.compte::text LIKE '2%') " +
            "AND EXTRACT(YEAR FROM b.date_enregistrement) = :year", nativeQuery = true)
    List<Object[]> findActifsByYear(@Param("year") int year);

    @Query(value = "SELECT b.Id_Bilan, c.Id_Categorie, c.compte AS compte_categorie, c.nom_categorie, " +
            "sc.Id_Sous_Categorie, sc.compte AS compte_sous_categorie, sc.nom_sous_categorie, " +
            "ssc.Id_Sous_Sous_Categorie, ssc.compte AS compte_sous_sous_categorie, ssc.nom, " +
            "b.description_note, b.valeur " +
            "FROM Bilan b " +
            "INNER JOIN Categorie c ON b.Id_Categorie = c.Id_Categorie " +
            "LEFT JOIN Sous_Categorie sc ON b.Id_Sous_Categorie = sc.Id_Sous_Categorie " +
            "LEFT JOIN Sous_Sous_Categorie ssc ON b.Id_Sous_Sous_Categorie = ssc.Id_Sous_Sous_Categorie " +
            "WHERE (c.compte::text LIKE '3%' OR c.compte::text LIKE '4%' OR c.compte::text LIKE '5%') " +
            "AND EXTRACT(YEAR FROM b.date_enregistrement) = :year", nativeQuery = true)
    List<Object[]> findPassifsByYear(@Param("year") int year);


    /**
     * Récupère les années distinctes disponibles dans la base de données.
     */
    @Query(value = "SELECT DISTINCT EXTRACT(YEAR FROM date_enregistrement) AS annee FROM Bilan ORDER BY annee DESC", nativeQuery = true)
    List<Integer> findDistinctAnnees();

    /**
     * Récupère les actifs pour une année et une entreprise données.
     */
    @Query(value = "SELECT b.Id_Bilan, c.Id_Categorie, c.compte AS compte_categorie, c.nom_categorie, " +
            "sc.Id_Sous_Categorie, sc.compte AS compte_sous_categorie, sc.nom_sous_categorie, " +
            "ssc.Id_Sous_Sous_Categorie, ssc.compte AS compte_sous_sous_categorie, ssc.nom, " +
            "b.description_note, b.valeur " +
            "FROM Bilan b " +
            "INNER JOIN Categorie c ON b.Id_Categorie = c.Id_Categorie " +
            "LEFT JOIN Sous_Categorie sc ON b.Id_Sous_Categorie = sc.Id_Sous_Categorie " +
            "LEFT JOIN Sous_Sous_Categorie ssc ON b.Id_Sous_Sous_Categorie = ssc.Id_Sous_Sous_Categorie " +
            "WHERE (c.compte::text LIKE '1%' OR c.compte::text LIKE '2%') " +
            "AND EXTRACT(YEAR FROM b.date_enregistrement) = :annee " +
            "AND b.Id_Entreprise = :entrepriseId", nativeQuery = true)
    List<Object[]> findActifsByYearAndEntreprise(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    /**
     * Récupère les passifs pour une année et une entreprise données.
     */
    @Query(value = "SELECT b.Id_Bilan, c.Id_Categorie, c.compte AS compte_categorie, c.nom_categorie, " +
            "sc.Id_Sous_Categorie, sc.compte AS compte_sous_categorie, sc.nom_sous_categorie, " +
            "ssc.Id_Sous_Sous_Categorie, ssc.compte AS compte_sous_sous_categorie, ssc.nom, " +
            "b.description_note, b.valeur " +
            "FROM Bilan b " +
            "INNER JOIN Categorie c ON b.Id_Categorie = c.Id_Categorie " +
            "LEFT JOIN Sous_Categorie sc ON b.Id_Sous_Categorie = sc.Id_Sous_Categorie " +
            "LEFT JOIN Sous_Sous_Categorie ssc ON b.Id_Sous_Sous_Categorie = ssc.Id_Sous_Sous_Categorie " +
            "WHERE (c.compte::text LIKE '3%' OR c.compte::text LIKE '4%' OR c.compte::text LIKE '5%') " +
            "AND EXTRACT(YEAR FROM b.date_enregistrement) = :annee " +
            "AND b.Id_Entreprise = :entrepriseId", nativeQuery = true)
    List<Object[]> findPassifsByYearAndEntreprise(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

    @Query(value = "SELECT * FROM vue_resultat_net(:annee, :entrepriseId)", nativeQuery = true)
    BigDecimal getResultatNet(@Param("annee") int annee, @Param("entrepriseId") Integer entrepriseId);

}
