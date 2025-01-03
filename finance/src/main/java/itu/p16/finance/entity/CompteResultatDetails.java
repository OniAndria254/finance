package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "compte_resultat_details", schema = "public", catalog = "finance")
public class CompteResultatDetails {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_detail_resultat", nullable = false)
    private Integer idDetailResultat;
    @Basic
    @Column(name = "id_resultat", nullable = false)
    private Integer idResultat;
    @Basic
    @Column(name = "categorie", nullable = false, length = 50)
    private String categorie;
    @Basic
    @Column(name = "sous_categorie", nullable = false, length = 50)
    private String sousCategorie;
    @Basic
    @Column(name = "montant", nullable = false, precision = 2)
    private BigDecimal montant;

    public Integer getIdDetailResultat() {
        return idDetailResultat;
    }

    public void setIdDetailResultat(Integer idDetailResultat) {
        this.idDetailResultat = idDetailResultat;
    }

    public Integer getIdResultat() {
        return idResultat;
    }

    public void setIdResultat(Integer idResultat) {
        this.idResultat = idResultat;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getSousCategorie() {
        return sousCategorie;
    }

    public void setSousCategorie(String sousCategorie) {
        this.sousCategorie = sousCategorie;
    }

    public BigDecimal getMontant() {
        return montant;
    }

    public void setMontant(BigDecimal montant) {
        this.montant = montant;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CompteResultatDetails that = (CompteResultatDetails) o;

        if (idDetailResultat != null ? !idDetailResultat.equals(that.idDetailResultat) : that.idDetailResultat != null)
            return false;
        if (idResultat != null ? !idResultat.equals(that.idResultat) : that.idResultat != null) return false;
        if (categorie != null ? !categorie.equals(that.categorie) : that.categorie != null) return false;
        if (sousCategorie != null ? !sousCategorie.equals(that.sousCategorie) : that.sousCategorie != null)
            return false;
        if (montant != null ? !montant.equals(that.montant) : that.montant != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetailResultat != null ? idDetailResultat.hashCode() : 0;
        result = 31 * result + (idResultat != null ? idResultat.hashCode() : 0);
        result = 31 * result + (categorie != null ? categorie.hashCode() : 0);
        result = 31 * result + (sousCategorie != null ? sousCategorie.hashCode() : 0);
        result = 31 * result + (montant != null ? montant.hashCode() : 0);
        return result;
    }
}
