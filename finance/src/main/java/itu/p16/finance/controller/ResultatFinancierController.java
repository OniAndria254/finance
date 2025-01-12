package itu.p16.finance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import itu.p16.finance.service.ResultatFinancierService;

@Controller
@RequestMapping("/resultats")
public class ResultatFinancierController {
    @Autowired
    private ResultatFinancierService resultatFinancierService;
   
    @GetMapping("/{annee}")
    public ModelAndView getResultatsFinanciers(@PathVariable int annee) {
        ModelAndView mv = new ModelAndView("resultats");
        mv.addObject("resultats", resultatFinancierService.getResultatsFinanciers(annee));
        return mv;
    }
}
