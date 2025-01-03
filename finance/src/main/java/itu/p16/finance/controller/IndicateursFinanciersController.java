package itu.p16.finance.controller;

import itu.p16.finance.entity.Entreprise;
import itu.p16.finance.service.IndicateursFinanciersService;
import itu.p16.finance.service.EntrepriseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/indicateurs_financiers")
public class IndicateursFinanciersController {

    @Autowired
    private IndicateursFinanciersService indicateursFinanciersService;

    @Autowired
    private EntrepriseService entrepriseService;

    // Affiche tous les indicateurs financiers pour une entreprise et une année spécifiques
    @GetMapping("/indicateurs")
    public ModelAndView afficherIndicateursFinanciers(@RequestParam(value = "idEntreprise", required = false) Integer idEntreprise,
                                                      @RequestParam(value = "annee", required = false) Integer annee,
                                                      @RequestParam(value = "stock", defaultValue = "0") double stock,
                                                      @RequestParam(value = "taux", required = false) Double taux) {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "indicateurs_financiers_form");

        // Récupérer la liste des entreprises pour le select
        List<Entreprise> entreprises = entrepriseService.getAllEntreprises();
        mv.addObject("entreprises", entreprises);

        // Vérifier que l'entreprise et l'année sont spécifiées
        if (idEntreprise != null && annee != null) {

            // Calculer les indicateurs financiers
            double roa = indicateursFinanciersService.calculerROA(idEntreprise, annee); // Retour sur Actifs
            double margeNette = indicateursFinanciersService.calculerMargeNette(idEntreprise, annee); // Marge nette
            double rentabiliteCapitauxPropres = indicateursFinanciersService.calculerRentabiliteCapitauxPropres(idEntreprise, annee); // Rentabilité des capitaux propres
            double ratioLiquidite = indicateursFinanciersService.calculerRatioLiquidite(idEntreprise, annee); // Ratio de liquidité
            double ratioLiquiditeReduite = indicateursFinanciersService.calculerRatioLiquiditeReduite(idEntreprise, annee, stock);
            // Calculer les indicateurs financiers
            double levierFinancier = indicateursFinanciersService.calculerLevierFinancier(idEntreprise, annee); // Levier financier

            double roeAvecLevier = indicateursFinanciersService.calculerROEAvecLevier(roa, taux, levierFinancier);


            // Interprétation du levier
            String interpretationLevier = "";
            if (levierFinancier < 1.5) {
                interpretationLevier = "Le levier financier est faible, ce qui signifie que l'entreprise utilise peu de dettes par rapport à ses capitaux propres. Cela peut indiquer une stratégie prudente.";
            } else if (levierFinancier >= 1.5 && levierFinancier <= 3) {
                interpretationLevier = "Le levier financier est modéré, l'entreprise utilise une quantité raisonnable de dettes pour financer ses actifs. Cela peut favoriser la rentabilité sans prendre trop de risques.";
            } else {
                interpretationLevier = "Le levier financier est élevé, l'entreprise utilise une grande partie de ses dettes pour financer ses actifs. Bien que cela puisse augmenter la rentabilité, cela comporte également un risque accru.";
            }

            mv.addObject("interpretationLevier", interpretationLevier);
            // Ajouter le levier financier au modèle
            mv.addObject("levierFinancier", levierFinancier);
            mv.addObject("roeAvecLevier", roeAvecLevier);

            // Ajouter les indicateurs calculés au modèle
            mv.addObject("roa", roa);
            mv.addObject("margeNette", margeNette);
            mv.addObject("rentabiliteCapitauxPropres", rentabiliteCapitauxPropres);
            mv.addObject("ratioLiquidite", ratioLiquidite);
            mv.addObject("ratioLiquiditeReduite", ratioLiquiditeReduite);
        }

        return mv;
    }
}
