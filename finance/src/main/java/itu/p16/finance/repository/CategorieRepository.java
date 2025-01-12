package itu.p16.finance.repository;

import itu.p16.finance.entity.Categorie;
import itu.p16.finance.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategorieRepository  extends JpaRepository<Categorie, Integer> {
}
