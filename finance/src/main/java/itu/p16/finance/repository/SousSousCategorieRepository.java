package itu.p16.finance.repository;

import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.entity.SousCategorie;
import itu.p16.finance.entity.SousSousCategorie;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SousSousCategorieRepository extends JpaRepository<SousSousCategorie, Integer> {
    List<SousSousCategorie> findBySousCategorieByIdSousCategorie(SousCategorie sousCategorie);
}
