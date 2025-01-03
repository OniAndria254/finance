package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
public class Bilan {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_bilan", nullable = false)
    private Integer idBilan;
    @Basic
    @Column(name = "id_entreprise", nullable = false)
    private Integer idEntreprise;
    @Basic
    @Column(name = "annee", nullable = false)
    private Integer annee;
    @Basic
    @Column(name = "date_creation", nullable = true)
    private Date dateCreation;

    public Integer getIdBilan() {
        return idBilan;
    }

    public void setIdBilan(Integer idBilan) {
        this.idBilan = idBilan;
    }

    public Integer getIdEntreprise() {
        return idEntreprise;
    }

    public void setIdEntreprise(Integer idEntreprise) {
        this.idEntreprise = idEntreprise;
    }

    public Integer getAnnee() {
        return annee;
    }

    public void setAnnee(Integer annee) {
        this.annee = annee;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Bilan bilan = (Bilan) o;

        if (idBilan != null ? !idBilan.equals(bilan.idBilan) : bilan.idBilan != null) return false;
        if (idEntreprise != null ? !idEntreprise.equals(bilan.idEntreprise) : bilan.idEntreprise != null) return false;
        if (annee != null ? !annee.equals(bilan.annee) : bilan.annee != null) return false;
        if (dateCreation != null ? !dateCreation.equals(bilan.dateCreation) : bilan.dateCreation != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idBilan != null ? idBilan.hashCode() : 0;
        result = 31 * result + (idEntreprise != null ? idEntreprise.hashCode() : 0);
        result = 31 * result + (annee != null ? annee.hashCode() : 0);
        result = 31 * result + (dateCreation != null ? dateCreation.hashCode() : 0);
        return result;
    }
}
