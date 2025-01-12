package itu.p16.finance.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itu.p16.finance.entity.ResultatFinancier;
import itu.p16.finance.repository.ResultatFinancierRepository;

@Service
public class ResultatFinancierService {
    @Autowired
    private ResultatFinancierRepository resultatFinancierRepository;
    
    public ResultatFinancier getResultatsFinanciers(int annee) {
        ResultatFinancier resultats = new ResultatFinancier();
        resultats.setProductionExercice(resultatFinancierRepository.getProductionExercice(annee));
        resultats.setConsommationExercice(resultatFinancierRepository.getConsommationExercice(annee));
        resultats.setValeurAjoutee(resultatFinancierRepository.getValeurAjoutee(annee));
        resultats.setEbe(resultatFinancierRepository.getEbe(annee));
        resultats.setResultatOperationnel(resultatFinancierRepository.getResultatOperationnel(annee));
        resultats.setResultatFinancier(resultatFinancierRepository.getResultatFinancier(annee));
        resultats.setResultatAvantImpots(resultatFinancierRepository.getResultatAvantImpots(annee));
        resultats.setResultatNetOrdinaire(resultatFinancierRepository.getResultatNetOrdinaire(annee));
        resultats.setResultatExtraordinaire(resultatFinancierRepository.getResultatExtraordinaire(annee));
        resultats.setResultatNet(resultatFinancierRepository.getResultatNet(annee));
        return resultats;
    }
}

