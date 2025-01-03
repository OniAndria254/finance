package itu.p16.finance.repository;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.BilanDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BilanRepository extends JpaRepository<Bilan, Long> {

}