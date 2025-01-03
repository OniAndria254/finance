package itu.p16.finance.repository;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.BilanDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BilanDetailsRepository extends JpaRepository<BilanDetails, Long> {
    // CRUD standard fourni par JpaRepository
    @Query(value = "SELECT bd.* FROM bilan_details bd " +
            "JOIN bilan b ON bd.id_bilan = b.id_bilan " +
            "WHERE b.id_entreprise = :idEntreprise AND b.annee = :annee", nativeQuery = true)
    List<BilanDetails> findBilanDetailsByEntrepriseAndYear(@Param("idEntreprise") int idEntreprise,
                                                           @Param("annee") int annee);


}
