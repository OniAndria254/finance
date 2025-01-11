package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
public class Categorie {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_categorie", nullable = false)
    private Integer idCategorie;
    @Basic
    @Column(name = "compte", nullable = false)
    private Integer compte;
    @Basic
    @Column(name = "nom_categorie", nullable = false, length = 50)
    private String nomCategorie;
    @OneToMany(mappedBy = "categorieByIdCategorie")
    private List<Bilan> bilansByIdCategorie;
    @OneToMany(mappedBy = "categorieByIdCategorie")
    private List<SousCategorie> sousCategoriesByIdCategorie;

    public Integer getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(Integer idCategorie) {
        this.idCategorie = idCategorie;
    }

    public Integer getCompte() {
        return compte;
    }

    public void setCompte(Integer compte) {
        this.compte = compte;
    }

    public String getNomCategorie() {
        return nomCategorie;
    }

    public void setNomCategorie(String nomCategorie) {
        this.nomCategorie = nomCategorie;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Categorie categorie = (Categorie) o;

        if (idCategorie != null ? !idCategorie.equals(categorie.idCategorie) : categorie.idCategorie != null)
            return false;
        if (compte != null ? !compte.equals(categorie.compte) : categorie.compte != null) return false;
        if (nomCategorie != null ? !nomCategorie.equals(categorie.nomCategorie) : categorie.nomCategorie != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idCategorie != null ? idCategorie.hashCode() : 0;
        result = 31 * result + (compte != null ? compte.hashCode() : 0);
        result = 31 * result + (nomCategorie != null ? nomCategorie.hashCode() : 0);
        return result;
    }

    public List<Bilan> getBilansByIdCategorie() {
        return bilansByIdCategorie;
    }

    public void setBilansByIdCategorie(List<Bilan> bilansByIdCategorie) {
        this.bilansByIdCategorie = bilansByIdCategorie;
    }

    public List<SousCategorie> getSousCategoriesByIdCategorie() {
        return sousCategoriesByIdCategorie;
    }

    public void setSousCategoriesByIdCategorie(List<SousCategorie> sousCategoriesByIdCategorie) {
        this.sousCategoriesByIdCategorie = sousCategoriesByIdCategorie;
    }
}
