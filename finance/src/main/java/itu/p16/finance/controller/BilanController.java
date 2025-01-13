package itu.p16.finance.controller;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.service.BilanService;
import itu.p16.finance.service.CategorieService;
import itu.p16.finance.service.EntrepriseService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bilans")
public class BilanController {

    @Autowired
    private BilanService bilanService;
    @Autowired
    private EntrepriseService entrepriseService;
    @Autowired
    private CategorieService categorieService;

    @GetMapping("/ajouter")
    public ModelAndView showAddBilanForm() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "bilan/ajouterBilan");
        mv.addObject("entreprises", entrepriseService.getAllEntreprises());
        mv.addObject("categories", categorieService.getPostesBilan());
        return mv;
    }

    @PostMapping
    public String addBilan(@RequestParam Integer entrepriseId, @RequestParam Integer categorieId,
                           @RequestParam(required = false) Integer sousCategorieId, @RequestParam(required = false) Integer sousSousCategorieId,
                           @RequestParam Double valeur, @RequestParam String date, @RequestParam String description) {
        bilanService.addBilan(entrepriseId, categorieId, sousCategorieId, sousSousCategorieId, valeur, date, description);
        return "redirect:/bilans/select";
    }

    @GetMapping("/select")
    public ModelAndView showSelectForm() {
        ModelAndView mv = new ModelAndView("layout");
        // Récupérer la liste des années disponibles
        List<Integer> annees = bilanService.getAnneesDisponibles();
        mv.addObject("annees", annees);

        // Récupérer la liste des entreprises
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);

        mv.addObject("page", "bilan/selectBilan");
        return mv;
    }

    /**
     * Affiche le bilan en fonction de l'année et de l'entreprise sélectionnées.
     */
    @GetMapping("/show")
    public ModelAndView showBilan(@RequestParam int annee, @RequestParam Integer entrepriseId) {
        ModelAndView mv = new ModelAndView("layout");

        // Récupérer les données du bilan pour l'année et l'entreprise sélectionnées
        Map<String, Object> actifs = bilanService.getBilanActif(annee, entrepriseId);
        Map<String, Object> passifs = bilanService.getBilanPassif(annee, entrepriseId);

        // Ajouter les données au modèle
        mv.addObject("actifs", actifs);
        mv.addObject("passifs", passifs);
        mv.addObject("annee", annee);

        // Récupérer le nom de l'entreprise
        Entreprise entreprise = entrepriseService.getEntrepriseById(entrepriseId);
        mv.addObject("entreprise", entreprise.getNom());
        mv.addObject("page", "bilan/all");

        // Vérifier si les totaux des actifs et des passifs sont égaux
        BigDecimal totalActifs = (BigDecimal) actifs.get("total");
        BigDecimal totalPassifs = (BigDecimal) passifs.get("total");

        if (totalActifs.compareTo(totalPassifs) != 0) {
            BigDecimal difference = totalActifs.subtract(totalPassifs).abs();
            String message;
            if (totalActifs.compareTo(totalPassifs) > 0) {
                message = "Le total des passifs est inférieur de " + difference + " par rapport au total des actifs.";
            } else {
                message = "Le total des actifs est inférieur de " + difference + " par rapport au total des passifs.";
            }
            mv.addObject("alertMessage", message);
        }

        return mv;
    }
}