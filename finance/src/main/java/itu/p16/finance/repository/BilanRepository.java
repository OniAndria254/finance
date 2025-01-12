package itu.p16.finance.repository;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.Entreprise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BilanRepository extends JpaRepository<Bilan, Integer> {
}
