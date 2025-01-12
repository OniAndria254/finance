package itu.p16.finance.controller;

import itu.p16.finance.entity.SousSousCategorie;
import itu.p16.finance.service.SousSousCategorieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/sousSousCategories")
public class SousSousCategorieController {

    @Autowired
    private SousSousCategorieService sousSousCategorieService;

    @GetMapping
    public List<SousSousCategorie> getSousSousCategoriesBySousCategorie(@RequestParam Integer sousCategorieId) {
        return sousSousCategorieService.getSousSousCategoriesBySousCategorie(sousCategorieId);
    }
}