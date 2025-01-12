package itu.p16.finance.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.lang.Double;
import java.sql.Date;

@Entity
public class Bilan {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_bilan", nullable = false)
    private Integer idBilan;
    @Basic
    @Column(name = "description_note", nullable = true, length = 50)
    private String descriptionNote;
    @Basic
    @Column(name = "valeur", nullable = false, precision = 2)
    private Double valeur;
    @Basic
    @Column(name = "date_enregistrement", nullable = false)
    private Date dateEnregistrement;
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "id_entreprise", referencedColumnName = "id_entreprise", nullable = false)
    private Entreprise entrepriseByIdEntreprise;
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "id_sous_sous_categorie", referencedColumnName = "id_sous_sous_categorie")
    private SousSousCategorie sousSousCategorieByIdSousSousCategorie;
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "id_sous_categorie", referencedColumnName = "id_sous_categorie")
    private SousCategorie sousCategorieByIdSousCategorie;
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "id_categorie", referencedColumnName = "id_categorie", nullable = false)
    private Categorie categorieByIdCategorie;

    public Integer getIdBilan() {
        return idBilan;
    }

    public void setIdBilan(Integer idBilan) {
        this.idBilan = idBilan;
    }

    public String getDescriptionNote() {
        return descriptionNote;
    }

    public void setDescriptionNote(String descriptionNote) {
        this.descriptionNote = descriptionNote;
    }

    public Double getValeur() {
        return valeur;
    }

    public void setValeur(Double valeur) {
        this.valeur = valeur;
    }

    public Date getDateEnregistrement() {
        return dateEnregistrement;
    }

    public void setDateEnregistrement(Date dateEnregistrement) {
        this.dateEnregistrement = dateEnregistrement;
    }

    
    public Entreprise getEntrepriseByIdEntreprise() {
        return entrepriseByIdEntreprise;
    }

    public void setEntrepriseByIdEntreprise(Entreprise entrepriseByIdEntreprise) {
        this.entrepriseByIdEntreprise = entrepriseByIdEntreprise;
    }

    public SousSousCategorie getSousSousCategorieByIdSousSousCategorie() {
        return sousSousCategorieByIdSousSousCategorie;
    }

    public void setSousSousCategorieByIdSousSousCategorie(SousSousCategorie sousSousCategorieByIdSousSousCategorie) {
        this.sousSousCategorieByIdSousSousCategorie = sousSousCategorieByIdSousSousCategorie;
    }

    public SousCategorie getSousCategorieByIdSousCategorie() {
        return sousCategorieByIdSousCategorie;
    }

    public void setSousCategorieByIdSousCategorie(SousCategorie sousCategorieByIdSousCategorie) {
        this.sousCategorieByIdSousCategorie = sousCategorieByIdSousCategorie;
    }

    public Categorie getCategorieByIdCategorie() {
        return categorieByIdCategorie;
    }

    public void setCategorieByIdCategorie(Categorie categorieByIdCategorie) {
        this.categorieByIdCategorie = categorieByIdCategorie;
    }
}
