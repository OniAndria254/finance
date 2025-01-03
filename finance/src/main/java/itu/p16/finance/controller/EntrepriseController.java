package itu.p16.finance.controller;

import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/entreprises")
public class EntrepriseController {

    @Autowired
    private EntrepriseService entrepriseService;

    // Afficher la liste des entreprises
    @GetMapping("/list")
    public ModelAndView getAllEntreprises() {
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "entreprise/index");  // Définir la page spécifique
        mv.addObject("entreprises", entreprises); // Ajouter les entreprises au modèle
        return mv;
    }

    // Créer une nouvelle entreprise
    @GetMapping("/create")
    public ModelAndView createEntrepriseForm() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "entreprise/create");
        return mv;
    }

    @PostMapping
    public ModelAndView createEntreprise(@ModelAttribute Entreprise entreprise) {
        entrepriseService.saveEntreprise(entreprise);
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "entreprise/index");  // Définir la page spécifique
        mv.addObject("entreprises", entreprises); // Ajouter les entreprises au modèle
        return mv;
    }

    // Modifier une entreprise existante
    @GetMapping("/edit/{id}")
    public ModelAndView editEntrepriseForm(@PathVariable Long id) {
        Optional<Entreprise> entreprise = entrepriseService.getEntrepriseById(id);
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "entreprise/edit");
        entreprise.ifPresent(value -> mv.addObject("entreprise", value));
        return mv;
    }

    @PostMapping("/edit/{id}")
    public ModelAndView updateEntreprise(@PathVariable Long id, @ModelAttribute Entreprise entreprise) {
        entrepriseService.updateEntreprise(id, entreprise);
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "entreprise/index");  // Définir la page spécifique
        mv.addObject("entreprises", entreprises); // Ajouter les entreprises au modèle
        return mv;
    }

    // Supprimer une entreprise
    @GetMapping("/delete/{id}")
    public ModelAndView deleteEntrepriseForm(@PathVariable Long id) {
        entrepriseService.deleteEntreprise(id);
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "entreprise/index");  // Définir la page spécifique
        mv.addObject("entreprises", entreprises); // Ajouter les entreprises au modèle
        return mv;
    }

}