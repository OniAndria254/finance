package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "sous_categorie", schema = "public", catalog = "finance2")
public class SousCategorie {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_sous_categorie", nullable = false)
    private Integer idSousCategorie;
    @Basic
    @Column(name = "compte", nullable = false)
    private Integer compte;
    @Basic
    @Column(name = "nom_sous_categorie", nullable = false, length = 50)
    private String nomSousCategorie;
    @OneToMany(mappedBy = "sousCategorieByIdSousCategorie")
    private List<Bilan> bilansByIdSousCategorie;
    @ManyToOne
    @JoinColumn(name = "id_categorie", referencedColumnName = "id_categorie", nullable = false)
    private Categorie categorieByIdCategorie;
    @OneToMany(mappedBy = "sousCategorieByIdSousCategorie")
    private List<SousSousCategorie> sousSousCategoriesByIdSousCategorie;

    public Integer getIdSousCategorie() {
        return idSousCategorie;
    }

    public void setIdSousCategorie(Integer idSousCategorie) {
        this.idSousCategorie = idSousCategorie;
    }

    public Integer getCompte() {
        return compte;
    }

    public void setCompte(Integer compte) {
        this.compte = compte;
    }

    public String getNomSousCategorie() {
        return nomSousCategorie;
    }

    public void setNomSousCategorie(String nomSousCategorie) {
        this.nomSousCategorie = nomSousCategorie;
    }

    public List<Bilan> getBilansByIdSousCategorie() {
        return bilansByIdSousCategorie;
    }

    public void setBilansByIdSousCategorie(List<Bilan> bilansByIdSousCategorie) {
        this.bilansByIdSousCategorie = bilansByIdSousCategorie;
    }

    public Categorie getCategorieByIdCategorie() {
        return categorieByIdCategorie;
    }

    public void setCategorieByIdCategorie(Categorie categorieByIdCategorie) {
        this.categorieByIdCategorie = categorieByIdCategorie;
    }

    public List<SousSousCategorie> getSousSousCategoriesByIdSousCategorie() {
        return sousSousCategoriesByIdSousCategorie;
    }

    public void setSousSousCategoriesByIdSousCategorie(List<SousSousCategorie> sousSousCategoriesByIdSousCategorie) {
        this.sousSousCategoriesByIdSousCategorie = sousSousCategoriesByIdSousCategorie;
    }
}
