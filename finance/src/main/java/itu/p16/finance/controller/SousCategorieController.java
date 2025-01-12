package itu.p16.finance.controller;
import itu.p16.finance.entity.SousCategorie;
import itu.p16.finance.service.SousCategorieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/sousCategories")
public class SousCategorieController {

    @Autowired
    private SousCategorieService sousCategorieService;

    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
    public List<SousCategorie> getSousCategoriesByCategorie(@RequestParam Integer categorieId) {
        return sousCategorieService.getSousCategoriesByCategorie(categorieId);
    }
}