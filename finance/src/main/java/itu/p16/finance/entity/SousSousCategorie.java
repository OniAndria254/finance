package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "sous_sous_categorie", schema = "public", catalog = "finance2")
public class SousSousCategorie {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_sous_sous_categorie", nullable = false)
    private Integer idSousSousCategorie;
    @Basic
    @Column(name = "compte", nullable = false)
    private Integer compte;
    @Basic
    @Column(name = "nom", nullable = false, length = 50)
    private String nom;
    @OneToMany(mappedBy = "sousSousCategorieByIdSousSousCategorie")
    private List<Bilan> bilansByIdSousSousCategorie;
    @ManyToOne
    @JoinColumn(name = "id_sous_categorie", referencedColumnName = "id_sous_categorie", nullable = false)
    private SousCategorie sousCategorieByIdSousCategorie;

    public Integer getIdSousSousCategorie() {
        return idSousSousCategorie;
    }

    public void setIdSousSousCategorie(Integer idSousSousCategorie) {
        this.idSousSousCategorie = idSousSousCategorie;
    }

    public Integer getCompte() {
        return compte;
    }

    public void setCompte(Integer compte) {
        this.compte = compte;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public List<Bilan> getBilansByIdSousSousCategorie() {
        return bilansByIdSousSousCategorie;
    }

    public void setBilansByIdSousSousCategorie(List<Bilan> bilansByIdSousSousCategorie) {
        this.bilansByIdSousSousCategorie = bilansByIdSousSousCategorie;
    }

    public SousCategorie getSousCategorieByIdSousCategorie() {
        return sousCategorieByIdSousCategorie;
    }

    public void setSousCategorieByIdSousCategorie(SousCategorie sousCategorieByIdSousCategorie) {
        this.sousCategorieByIdSousCategorie = sousCategorieByIdSousCategorie;
    }
}
