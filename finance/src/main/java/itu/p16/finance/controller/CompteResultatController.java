package itu.p16.finance.controller;

import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.repository.CompteResultatRepository;
import itu.p16.finance.service.BilanService;
import itu.p16.finance.service.CompteResultatService;
import itu.p16.finance.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/compteResultat")
public class CompteResultatController {

    @Autowired
    private CompteResultatService compteResultatService;
    @Autowired
    private EntrepriseService entrepriseService;
    @Autowired
    private BilanService bilanService;
    @Autowired
    private CompteResultatRepository compteResultatRepository;


    @GetMapping("/select")
    public ModelAndView showSelectForm() {
        ModelAndView mv = new ModelAndView("layout");
        // Récupérer la liste des années disponibles
        List<Integer> annees = bilanService.getAnneesDisponibles();
        mv.addObject("annees", annees);

        // Récupérer la liste des entreprises
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);

        mv.addObject("page", "compte_gestion/selectCompte");
        return mv;
    }

    @GetMapping("/select-indicateur")
    public ModelAndView showIndicateurForm() {
        ModelAndView mv = new ModelAndView("layout");
        // Récupérer la liste des années disponibles
        List<Integer> annees = bilanService.getAnneesDisponibles();
        mv.addObject("annees", annees);

        // Récupérer la liste des entreprises
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);

        mv.addObject("page", "compte_gestion/select_indicateur");
        return mv;
    }
    @GetMapping
    public ModelAndView showCompteResultat(@RequestParam int annee, @RequestParam Integer entrepriseId) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "compte_gestion/compteResultat");
        // Récupérer les données du compte de résultat
//        BigDecimal chiffreAffaires = compteResultatRepository.getProductionExercice(annee, entrepriseId);
//        BigDecimal productionStockee = compteResultatRepository.getProductionStockee(annee, entrepriseId);
//        BigDecimal productionImmobilisee = compteResultatRepository.getProductionImmobilisee(annee, entrepriseId);
        BigDecimal productionExercice = compteResultatRepository.getProductionExercice(annee, entrepriseId);
//        BigDecimal achatsConsommes = compteResultatRepository.getAchatsConsommes(annee, entrepriseId);
//        BigDecimal servicesExterieurs = compteResultatRepository.getServicesExterieurs(annee, entrepriseId);
        BigDecimal consommationExercice = compteResultatRepository.getConsommationExercice(annee, entrepriseId);
        BigDecimal valeurAjoutee = compteResultatRepository.getValeurAjoutee(annee, entrepriseId);
//        BigDecimal chargesPersonnel = compteResultatRepository.getChargesPersonnel(annee, entrepriseId);
//        BigDecimal impotsTaxes = compteResultatRepository.getImpotsTaxes(annee, entrepriseId);
        BigDecimal ebe = compteResultatRepository.getEBE(annee, entrepriseId);
//        BigDecimal autresProduits = compteResultatRepository.getAutresProduitsOperationnels(annee, entrepriseId);
//        BigDecimal autresCharges = compteResultatRepository.getAutresChargesOperationnelles(annee, entrepriseId);
//        BigDecimal dotations = compteResultatRepository.getDotations(annee, entrepriseId);
//        BigDecimal reprises = compteResultatRepository.getReprises(annee, entrepriseId);
        BigDecimal resultatOperationnel = compteResultatRepository.getResultatOperationnel(annee, entrepriseId);
//        BigDecimal produitsFinanciers = compteResultatRepository.getProduitsFinanciers(annee, entrepriseId);
//        BigDecimal chargesFinancieres = compteResultatRepository.getChargesFinancieres(annee, entrepriseId);
        BigDecimal resultatFinancier = compteResultatRepository.getResultatFinancier(annee, entrepriseId);
        BigDecimal resultatAvantImpots = compteResultatRepository.getResultatAvantImpots(annee, entrepriseId);
        BigDecimal resultatNetOrdinaire = compteResultatRepository.getResultatNetOrdinaire(annee, entrepriseId);
        BigDecimal resultatExtraordinaire = compteResultatRepository.getResultatExtraordinaire(annee, entrepriseId);
        BigDecimal resultatNet = compteResultatRepository.getResultatNet(annee, entrepriseId);

        // Ajouter les données au modèle
//        mv.addObject("chiffreAffaires", chiffreAffaires);
//        mv.addObject("productionStockee", productionStockee);
//        mv.addObject("productionImmobilisee", productionImmobilisee);
        mv.addObject("productionExercice", productionExercice);
//        mv.addObject("achatsConsommes", achatsConsommes);
//        mv.addObject("servicesExterieurs", servicesExterieurs);
        mv.addObject("consommationExercice", consommationExercice);
        mv.addObject("valeurAjoutee", valeurAjoutee);
//        mv.addObject("chargesPersonnel", chargesPersonnel);
//        mv.addObject("impotsTaxes", impotsTaxes);
        mv.addObject("ebe", ebe);
//        mv.addObject("autresProduits", autresProduits);
//        mv.addObject("autresCharges", autresCharges);
//        mv.addObject("dotations", dotations);
//        mv.addObject("reprises", reprises);
        mv.addObject("resultatOperationnel", resultatOperationnel);
//        mv.addObject("produitsFinanciers", produitsFinanciers);
//        mv.addObject("chargesFinancieres", chargesFinancieres);
        mv.addObject("resultatFinancier", resultatFinancier);
        mv.addObject("resultatAvantImpots", resultatAvantImpots);
        mv.addObject("resultatNetOrdinaire", resultatNetOrdinaire);
        mv.addObject("resultatExtraordinaire", resultatExtraordinaire);
        mv.addObject("resultatNet", resultatNet);

        return mv;
    }


    @GetMapping("/indicateurs-financiers")
    public ModelAndView getIndicateursFinanciers(
            @RequestParam int annee,
            @RequestParam Integer entrepriseId) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("annee", annee);
        mv.addObject("page", "compte_gestion/indicateurs");
        mv.addObject("indicateurs", compteResultatService.calculateIndicateursFinanciers(annee, entrepriseId));
        return mv;
    }
}