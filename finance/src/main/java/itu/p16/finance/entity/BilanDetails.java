package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "bilan_details", schema = "public", catalog = "finance")
public class BilanDetails {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_detail_bilan", nullable = false)
    private Integer idDetailBilan;
    @Basic
    @Column(name = "id_bilan", nullable = false)
    private Integer idBilan;
    @Basic
    @Column(name = "categorie", nullable = false, length = 50)
    private String categorie;
    @Basic
    @Column(name = "sous_categorie", nullable = false, length = 50)
    private String sousCategorie;
    @Basic
    @Column(name = "montant", nullable = false, precision = 2)
    private BigDecimal montant;

    public Integer getIdDetailBilan() {
        return idDetailBilan;
    }

    public void setIdDetailBilan(Integer idDetailBilan) {
        this.idDetailBilan = idDetailBilan;
    }

    public Integer getIdBilan() {
        return idBilan;
    }

    public void setIdBilan(Integer idBilan) {
        this.idBilan = idBilan;
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

        BilanDetails that = (BilanDetails) o;

        if (idDetailBilan != null ? !idDetailBilan.equals(that.idDetailBilan) : that.idDetailBilan != null)
            return false;
        if (idBilan != null ? !idBilan.equals(that.idBilan) : that.idBilan != null) return false;
        if (categorie != null ? !categorie.equals(that.categorie) : that.categorie != null) return false;
        if (sousCategorie != null ? !sousCategorie.equals(that.sousCategorie) : that.sousCategorie != null)
            return false;
        if (montant != null ? !montant.equals(that.montant) : that.montant != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idDetailBilan != null ? idDetailBilan.hashCode() : 0;
        result = 31 * result + (idBilan != null ? idBilan.hashCode() : 0);
        result = 31 * result + (categorie != null ? categorie.hashCode() : 0);
        result = 31 * result + (sousCategorie != null ? sousCategorie.hashCode() : 0);
        result = 31 * result + (montant != null ? montant.hashCode() : 0);
        return result;
    }
}
