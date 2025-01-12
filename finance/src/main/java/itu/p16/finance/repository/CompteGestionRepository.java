package itu.p16.finance.repository;

import itu.p16.finance.entity.CompteGestion;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CompteGestionRepository extends JpaRepository<CompteGestion, Integer> {
}