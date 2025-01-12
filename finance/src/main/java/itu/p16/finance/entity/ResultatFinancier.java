package itu.p16.finance.entity;
import jakarta.persistence.*;

@Entity
public class ResultatFinancier {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    private Double productionExercice;
    private Double consommationExercice;
    private Double valeurAjoutee;
    private Double ebe;
    private Double resultatOperationnel;
    private Double resultatFinancier;
    private Double resultatAvantImpots;
    private Double resultatNetOrdinaire;
    private Double resultatExtraordinaire;
    private Double resultatNet;
    public Double getProductionExercice() {
        return productionExercice;
    }
    public void setProductionExercice(Double productionExercice) {
        this.productionExercice = productionExercice;
    }
    public Double getConsommationExercice() {
        return consommationExercice;
    }
    public void setConsommationExercice(Double consommationExercice) {
        this.consommationExercice = consommationExercice;
    }
    public Double getValeurAjoutee() {
        return valeurAjoutee;
    }
    public void setValeurAjoutee(Double valeurAjoutee) {
        this.valeurAjoutee = valeurAjoutee;
    }
    public Double getEbe() {
        return ebe;
    }
    public void setEbe(Double ebe) {
        this.ebe = ebe;
    }
    public Double getResultatOperationnel() {
        return resultatOperationnel;
    }
    public void setResultatOperationnel(Double resultatOperationnel) {
        this.resultatOperationnel = resultatOperationnel;
    }
    public Double getResultatFinancier() {
        return resultatFinancier;
    }
    public void setResultatFinancier(Double resultatFinancier) {
        this.resultatFinancier = resultatFinancier;
    }
    public Double getResultatAvantImpots() {
        return resultatAvantImpots;
    }
    public void setResultatAvantImpots(Double resultatAvantImpots) {
        this.resultatAvantImpots = resultatAvantImpots;
    }
    public Double getResultatNetOrdinaire() {
        return resultatNetOrdinaire;
    }
    public void setResultatNetOrdinaire(Double resultatNetOrdinaire) {
        this.resultatNetOrdinaire = resultatNetOrdinaire;
    }
    public Double getResultatExtraordinaire() {
        return resultatExtraordinaire;
    }
    public void setResultatExtraordinaire(Double resultatExtraordinaire) {
        this.resultatExtraordinaire = resultatExtraordinaire;
    }
    public Double getResultatNet() {
        return resultatNet;
    }
    public void setResultatNet(Double resultatNet) {
        this.resultatNet = resultatNet;
    }
    
    
}
