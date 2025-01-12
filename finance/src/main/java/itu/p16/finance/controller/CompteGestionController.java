package itu.p16.finance.controller;

import itu.p16.finance.entity.CompteGestion;
import itu.p16.finance.service.CompteGestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/comptesGestion")
public class CompteGestionController {

    @Autowired
    private CompteGestionService compteGestionService;

    // Afficher le formulaire d'ajout
    @GetMapping("/ajouter")
    public String showAddCompteGestionForm(Model model) {
        model.addAttribute("compteGestion", new CompteGestion());
        return "ajouterCompteGestion"; // Nom de la page JSP
    }

    // Traiter l'ajout d'un compte de gestion
    @PostMapping
    public String addCompteGestion(@RequestParam Integer compte,
                                   @RequestParam String nomCompte,
                                   @RequestParam String typeCompte) {
        CompteGestion compteGestion = new CompteGestion();
        compteGestion.setCompte(compte);
        compteGestion.setNomCompte(nomCompte);
        compteGestion.setTypeCompte(typeCompte);
        compteGestionService.addCompteGestion(compteGestion);
        return "redirect:/comptesGestion/list";
    }

    // Afficher la liste des comptes de gestion
    @GetMapping("/list")
    public String listComptesGestion(Model model) {
        model.addAttribute("comptesGestion", compteGestionService.getAllComptesGestion());
        return "listeComptesGestion"; // Nom de la page JSP
    }
}