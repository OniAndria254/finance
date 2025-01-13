package itu.p16.finance.controller;

import itu.p16.finance.service.BilanService;
import itu.p16.finance.service.CategorieService;
import itu.p16.finance.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/compteGestion")
public class CompteGestionController {

    @Autowired
    private BilanService bilanService;
    @Autowired
    private EntrepriseService entrepriseService;
    @Autowired
    private CategorieService categorieService;

    @GetMapping("/ajouter")
    public ModelAndView showAddCompteGestionForm() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "compte_gestion/ajouter_compte_gestion");
        mv.addObject("entreprises", entrepriseService.getAllEntreprises());
        mv.addObject("categories", categorieService.getProduitsEtCharges());
        return mv;
    }

    @PostMapping
    public String add(@RequestParam Integer entrepriseId, @RequestParam Integer categorieId,
                           @RequestParam(required = false) Integer sousCategorieId, @RequestParam(required = false) Integer sousSousCategorieId,
                           @RequestParam Double valeur, @RequestParam String date, @RequestParam String description) {
        bilanService.addBilan(entrepriseId, categorieId, sousCategorieId, sousSousCategorieId, valeur, date, description);
        return "redirect:/compteResultat/select";
    }
}