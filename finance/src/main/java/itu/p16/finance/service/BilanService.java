package itu.p16.finance.service;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.BilanDetails;
import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.repository.BilanDetailsRepository;
import itu.p16.finance.repository.BilanRepository;
import itu.p16.finance.repository.EntrepriseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BilanService {
    @Autowired
    private BilanRepository bilanRepository;
    @Autowired
    private BilanDetailsRepository bilanDetailsRepository;

    public Bilan addBilan(Bilan bilan) {
        return bilanRepository.save(bilan);
    }

    public BilanDetails addBilanDetails(BilanDetails bilanDetails) {
        return bilanDetailsRepository.save(bilanDetails);
    }

    public List<Bilan> getAllBilans() {
        return bilanRepository.findAll();
    }

    // Récupérer les détails du bilan pour une entreprise et une année spécifiques
    public List<BilanDetails> getBilanDetailsByEntrepriseAndYear(int idEntreprise, int annee) {
        return bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
    }

    public double getTotalActifs(int idEntreprise, int annee) {
        List<BilanDetails> all = bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
        double val = 0;
        for (BilanDetails b:all) {
            if (b.getCategorie().equalsIgnoreCase("Actifs")) {
                val += b.getMontant().doubleValue();
            }
        }
        return val;
    }

    public double getTotalPassifsCP(int idEntreprise, int annee) {
        List<BilanDetails> all = bilanDetailsRepository.findBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
        double val = 0;
        for (BilanDetails b:all) {
            if (b.getCategorie().equalsIgnoreCase("Passifs") || b.getCategorie().equalsIgnoreCase("Capitaux propres")) {
                val += b.getMontant().doubleValue();
            }
        }
        return val;
    }
}
