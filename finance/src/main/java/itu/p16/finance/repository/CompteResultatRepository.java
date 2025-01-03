package itu.p16.finance.repository;

import itu.p16.finance.entity.CompteResultat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CompteResultatRepository extends JpaRepository<CompteResultat, Integer> {}