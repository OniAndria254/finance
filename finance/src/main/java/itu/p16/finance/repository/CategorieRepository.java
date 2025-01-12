package itu.p16.finance.repository;

import itu.p16.finance.entity.Categorie;
import itu.p16.finance.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategorieRepository  extends JpaRepository<Categorie, Integer> {
    /**
     * Récupère les catégories dont le compte est compris entre deux valeurs.
     */
    List<Categorie> findByCompteBetween(Integer start, Integer end);

    /**
     * Récupère les catégories dont le compte est dans une liste spécifique.
     */
    List<Categorie> findByCompteIn(List<Integer> comptes);
}
