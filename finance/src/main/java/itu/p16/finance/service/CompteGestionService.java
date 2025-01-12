package itu.p16.finance.service;

import itu.p16.finance.entity.CompteGestion;
import itu.p16.finance.repository.CompteGestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompteGestionService {

    @Autowired
    private CompteGestionRepository compteGestionRepository;

    public void addCompteGestion(CompteGestion compteGestion) {
        compteGestionRepository.save(compteGestion);
    }

    public List<CompteGestion> getAllComptesGestion() {
        return compteGestionRepository.findAll();
    }
}