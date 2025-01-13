package itu.p16.finance.service;

import itu.p16.finance.entity.Bilan;
import itu.p16.finance.repository.BilanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@Service
public class BilanService {

    @Autowired
    private BilanRepository bilanRepository;

    @Autowired
    private EntrepriseService entrepriseService;

    @Autowired
    private CategorieService categorieService;

    @Autowired
    private SousCategorieService sousCategorieService;

    @Autowired
    private SousSousCategorieService sousSousCategorieService;

    public void addBilan(Integer entrepriseId, Integer categorieId, Integer sousCategorieId,
                         Integer sousSousCategorieId, Double valeur, String date, String description) {
        Bilan bilan = new Bilan();

        // Vérifications et affectations conditionnelles
        bilan.setEntrepriseByIdEntreprise(entrepriseService.getEntrepriseById(entrepriseId)); // Non nullable
        bilan.setCategorieByIdCategorie(categorieService.getCategorieById(categorieId)); // Non nullable

        // Vérifier si sousCategorieId est non nul avant d'appeler le service
        if (sousCategorieId != null) {
            bilan.setSousCategorieByIdSousCategorie(sousCategorieService.getSousCategorieById(sousCategorieId));
        } else {
            bilan.setSousCategorieByIdSousCategorie(null); // Permet de définir explicitement la valeur comme null
        }

        // Vérifier si sousSousCategorieId est non nul avant d'appeler le service
        if (sousSousCategorieId != null) {
            bilan.setSousSousCategorieByIdSousSousCategorie(sousSousCategorieService.getSousSousCategorieById(sousSousCategorieId));
        } else {
            bilan.setSousSousCategorieByIdSousSousCategorie(null); // Permet de définir explicitement la valeur comme null
        }

        // Vérifier si description est non nulle
        if (description != null && !description.trim().isEmpty()) {
            bilan.setDescriptionNote(description);
        } else {
            bilan.setDescriptionNote(null); // Permet de définir explicitement la valeur comme null
        }

        // Champs obligatoires
        bilan.setValeur(valeur); // Non nullable
        bilan.setDateEnregistrement(Date.valueOf(LocalDate.parse(date))); // Date est obligatoire

        // Enregistrer l'objet dans le repository
        bilanRepository.save(bilan);
    }

    public List<Bilan> getAllBilans() {
        return bilanRepository.findAll();
    }


    public Map<String, Object> getBilanActif(int year) {
        List<Object[]> actifsData = bilanRepository.findActifsByYear(year);
        return organizeBilanData(actifsData);
    }

    public Map<String, Object> getBilanPassif(int year) {
        List<Object[]> passifsData = bilanRepository.findPassifsByYear(year);
        return organizeBilanData(passifsData);
    }

    public List<Integer> getAnneesDisponibles() {
        return bilanRepository.findDistinctAnnees();
    }

    /**
     * Récupère le bilan actif pour une année et une entreprise données.
     */
    public Map<String, Object> getBilanActif(int annee, Integer entrepriseId) {
        List<Object[]> actifsData = bilanRepository.findActifsByYearAndEntreprise(annee, entrepriseId);
        return organizeBilanData(actifsData);
    }

    public Map<String, Object> getBilanPassif(int annee, Integer entrepriseId) {
        List<Object[]> passifsData = bilanRepository.findPassifsByYearAndEntreprise(annee, entrepriseId);
        Map<String, Object> bilan = organizeBilanData(passifsData);

        // Retrieve the Résultat Net
        BigDecimal resultatNet = bilanRepository.getResultatNet(annee, entrepriseId);

        if (bilan.containsKey("Capitaux propres")) {
            Map<String, Object> capitauxPropresMap = (Map<String, Object>) bilan.get("Capitaux propres");
            // Assuming "Résultat Net" is a subcategory; if it needs to be under a specific sous-sous-catégorie, adjust accordingly
            capitauxPropresMap.put("Résultat Net", resultatNet);

            // Update the total for Capitaux Propres
            BigDecimal totalCapitauxPropres = ((BigDecimal) capitauxPropresMap.get("total")).add(resultatNet);
            capitauxPropresMap.put("total", totalCapitauxPropres);
//            System.out.println(capitauxPropresMap.toString());

            // Update the general total
            BigDecimal total = (BigDecimal) bilan.get("total");
            bilan.put("total", total.add(resultatNet));
        } else {
            System.out.println(bilan.keySet());
            // If "Capitaux propres" does not exist, you may need to handle this case
        }

        return bilan;
    }

    private Map<String, Object> organizeBilanData(List<Object[]> data) {
        Map<String, Object> bilan = new LinkedHashMap<>(); // Pour conserver l'ordre d'insertion
        BigDecimal total = BigDecimal.ZERO; // Utiliser BigDecimal pour les calculs

        for (Object[] row : data) {
            String categorie = (String) row[3];
            String sousCategorie = (String) row[6];
            String sousSousCategorie = (String) row[9];
            BigDecimal valeur = (BigDecimal) row[11]; // Récupérer la valeur en tant que BigDecimal

            // Ajouter la catégorie si elle n'existe pas
            if (!bilan.containsKey(categorie)) {
                bilan.put(categorie, new LinkedHashMap<String, Object>());
                ((Map<String, Object>) bilan.get(categorie)).put("total", BigDecimal.ZERO);
            }

            // Ajouter la sous-catégorie si elle n'existe pas
            Map<String, Object> categorieMap = (Map<String, Object>) bilan.get(categorie);
            if (!categorieMap.containsKey(sousCategorie)) {
                categorieMap.put(sousCategorie, new LinkedHashMap<String, Object>());
                ((Map<String, Object>) categorieMap.get(sousCategorie)).put("total", BigDecimal.ZERO);
            }

            // Ajouter la sous-sous-catégorie
            Map<String, Object> sousCategorieMap = (Map<String, Object>) categorieMap.get(sousCategorie);
            sousCategorieMap.put(sousSousCategorie, valeur);

            // Mettre à jour les totaux
            BigDecimal sousCategorieTotal = ((BigDecimal) sousCategorieMap.get("total")).add(valeur);
            sousCategorieMap.put("total", sousCategorieTotal);

            BigDecimal categorieTotal = ((BigDecimal) categorieMap.get("total")).add(valeur);
            categorieMap.put("total", categorieTotal);

            total = total.add(valeur);
        }

        // Ajouter le total général
        bilan.put("total", total);

        return bilan;
    }
}