package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
@Table(name = "compte_resultat", schema = "public", catalog = "finance")
public class CompteResultat {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_resultat", nullable = false)
    private Integer idResultat;
    @Basic
    @Column(name = "id_entreprise", nullable = false)
    private Integer idEntreprise;
    @Basic
    @Column(name = "annee", nullable = false)
    private Integer annee;
    @Basic
    @Column(name = "date_creation", nullable = true)
    private Date dateCreation;

    public Integer getIdResultat() {
        return idResultat;
    }

    public void setIdResultat(Integer idResultat) {
        this.idResultat = idResultat;
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

        CompteResultat that = (CompteResultat) o;

        if (idResultat != null ? !idResultat.equals(that.idResultat) : that.idResultat != null) return false;
        if (idEntreprise != null ? !idEntreprise.equals(that.idEntreprise) : that.idEntreprise != null) return false;
        if (annee != null ? !annee.equals(that.annee) : that.annee != null) return false;
        if (dateCreation != null ? !dateCreation.equals(that.dateCreation) : that.dateCreation != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idResultat != null ? idResultat.hashCode() : 0;
        result = 31 * result + (idEntreprise != null ? idEntreprise.hashCode() : 0);
        result = 31 * result + (annee != null ? annee.hashCode() : 0);
        result = 31 * result + (dateCreation != null ? dateCreation.hashCode() : 0);
        return result;
    }
}
