package itu.p16.finance.repository;

import itu.p16.finance.entity.Categorie;
import itu.p16.finance.entity.SousCategorie;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SousCategorieRepository  extends JpaRepository<SousCategorie, Integer> {
    List<SousCategorie> findByCategorieByIdCategorie(Categorie categorie);
}
