package itu.p16.finance.repository;

import itu.p16.finance.entity.CompteResultatDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompteResultatDetailsRepository extends JpaRepository<CompteResultatDetails, Integer> {
    // Jointure entre compte_resultat et compte_resultat_details pour obtenir les détails
    @Query("SELECT crd FROM CompteResultatDetails crd " +
            "JOIN CompteResultat cr ON crd.idResultat = cr.idResultat " +
            "WHERE cr.idEntreprise = :idEntreprise AND cr.annee = :annee")
    List<CompteResultatDetails> findByEntrepriseAndAnnee(@Param("idEntreprise") Integer idEntreprise,
                                                         @Param("annee") Integer annee);
}