package itu.p16.finance.controller;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.BilanDetails;
import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.service.BilanService;
import itu.p16.finance.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/bilan")
public class BilanController {

    @Autowired
    private BilanService bilanService;
    @Autowired
    private EntrepriseService entrepriseService;

    // Affiche le formulaire JSP pour ajouter un bilan
    @GetMapping("/add")
    public ModelAndView showBilanForm() {
        ModelAndView mv = new ModelAndView("layout");
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);
        mv.addObject("page", "bilan/bilan"); // Inclure bilan.jsp dans le layout
        return mv;
    }

    // Traite l'insertion d'un bilan et de ses détails
    @PostMapping("/add")
    public String addBilan(
            @RequestParam("idEntreprise") int idEntreprise,
            @RequestParam("annee") int annee,
            @RequestParam("categorie") String categorie,
            @RequestParam("sousCategorie") String sousCategorie,
            @RequestParam("montant") double montant
    ) {
        // Insérer le bilan
        Bilan bilan = new Bilan();
        bilan.setIdEntreprise(idEntreprise);
        bilan.setAnnee(annee);
        Bilan savedBilan = bilanService.addBilan(bilan);

        // Insérer les détails du bilan
        BilanDetails detail = new BilanDetails();
        detail.setIdBilan(savedBilan.getIdBilan());
        detail.setCategorie(categorie);
        detail.setSousCategorie(sousCategorie);
        detail.setMontant(BigDecimal.valueOf(montant));
        bilanService.addBilanDetails(detail);

        // Redirection vers la liste des bilans
        return "redirect:/bilan/afficher";
    }

    // Affiche la liste des bilans
    @GetMapping("/list")
    public ModelAndView listBilans() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "bilan_list"); // Inclure bilan_list.jsp
        mv.addObject("bilans", bilanService.getAllBilans());
        return mv;
    }

    // Afficher le formulaire de sélection et les résultats du bilan
    @GetMapping("/afficher")
    public ModelAndView afficherBilan(@RequestParam(value = "idEntreprise", required = false) Integer idEntreprise,
                                      @RequestParam(value = "annee", required = false) Integer annee) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "bilan/bilan_select");

        // Ajouter la liste des entreprises pour le select
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);

        // Récupérer les détails du bilan si des paramètres sont fournis
        if (idEntreprise != null && annee != null) {
            List<BilanDetails> bilanDetails = bilanService.getBilanDetailsByEntrepriseAndYear(idEntreprise, annee);
            double totalActifs = bilanService.getTotalActifs(idEntreprise, annee);
            double totalPassifsCP = bilanService.getTotalPassifsCP(idEntreprise, annee);
            mv.addObject("totalActifs", totalActifs);
            mv.addObject("totalPassifsCP", totalPassifsCP);
            mv.addObject("bilanDetails", bilanDetails);
        }

        return mv;
    }
}