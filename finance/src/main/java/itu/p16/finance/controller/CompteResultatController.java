package itu.p16.finance.controller;

import itu.p16.finance.entity.CompteResultat;
import itu.p16.finance.entity.CompteResultatDetails;
import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.service.CompteResultatService;
import itu.p16.finance.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/compte_resultat")
public class CompteResultatController {

    @Autowired
    private CompteResultatService compteResultatService;
    @Autowired
    private EntrepriseService entrepriseService;

    // Afficher le formulaire d'insertion
    @GetMapping("/ajout")
    public ModelAndView showForm() {
        ModelAndView mv = new ModelAndView("layout");
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);
        mv.addObject("page", "compte_resultat/compte_resultat_form");
        return mv;
    }

    // Traiter le formulaire d'insertion
    @PostMapping("/add")
    public String addCompteResultat(@RequestParam("idEntreprise") Integer idEntreprise,
                                    @RequestParam("annee") Integer annee,
                                    @RequestParam("categorie") String categorie,
                                    @RequestParam("sousCategorie") String sousCategorie,
                                    @RequestParam("montant") Double montant) {

        // Ajouter un compte résultat
        CompteResultat resultat = new CompteResultat();
        resultat.setIdEntreprise(idEntreprise);
        resultat.setAnnee(annee);
        CompteResultat savedResultat = compteResultatService.ajouterCompteResultat(resultat);

        // Ajouter les détails associés
        CompteResultatDetails details = new CompteResultatDetails();
        details.setIdResultat(savedResultat.getIdResultat());
        details.setCategorie(categorie);
        details.setSousCategorie(sousCategorie);
        details.setMontant(BigDecimal.valueOf(montant));
        compteResultatService.ajouterCompteResultatDetails(details);

        return "redirect:/compte_resultat/afficher";
    }

    // Affiche le formulaire pour sélectionner une entreprise et une année
    @GetMapping("/afficher")
    public ModelAndView listCompteResultat(@RequestParam(value = "idEntreprise", required = false) Integer idEntreprise,
                                           @RequestParam(value = "annee", required = false) Integer annee) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "compte_resultat/compte_resultat_list");

        // Récupérer la liste des entreprises pour le select
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);

        // Récupérer les détails du compte résultat si des paramètres sont fournis
        if (idEntreprise != null && annee != null) {
            List<CompteResultatDetails> details = compteResultatService.getCompteResultatDetailsByEntrepriseAndYear(idEntreprise, annee);
            mv.addObject("details", details);
        }

        return mv;
    }
}