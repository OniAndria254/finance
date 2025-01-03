package itu.p16.finance.repository;

import itu.p16.finance.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EntrepriseRepository extends JpaRepository<Entreprise, Long> {
    // CRUD standard fourni par JpaRepository
}