package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.sql.Date;

@Entity
public class Entreprise {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_entreprise", nullable = false)
    private Integer idEntreprise;
    @Basic
    @Column(name = "nom_entreprise", nullable = false, length = 100)
    private String nomEntreprise;
    @Basic
    @Column(name = "secteur_activite", nullable = true, length = 50)
    private String secteurActivite;
    @Basic
    @Column(name = "date_creation", nullable = true)
    private Date dateCreation;

    public Integer getIdEntreprise() {
        return idEntreprise;
    }

    public void setIdEntreprise(Integer idEntreprise) {
        this.idEntreprise = idEntreprise;
    }

    public String getNomEntreprise() {
        return nomEntreprise;
    }

    public void setNomEntreprise(String nomEntreprise) {
        this.nomEntreprise = nomEntreprise;
    }

    public String getSecteurActivite() {
        return secteurActivite;
    }

    public void setSecteurActivite(String secteurActivite) {
        this.secteurActivite = secteurActivite;
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

        Entreprise that = (Entreprise) o;

        if (idEntreprise != null ? !idEntreprise.equals(that.idEntreprise) : that.idEntreprise != null) return false;
        if (nomEntreprise != null ? !nomEntreprise.equals(that.nomEntreprise) : that.nomEntreprise != null)
            return false;
        if (secteurActivite != null ? !secteurActivite.equals(that.secteurActivite) : that.secteurActivite != null)
            return false;
        if (dateCreation != null ? !dateCreation.equals(that.dateCreation) : that.dateCreation != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idEntreprise != null ? idEntreprise.hashCode() : 0;
        result = 31 * result + (nomEntreprise != null ? nomEntreprise.hashCode() : 0);
        result = 31 * result + (secteurActivite != null ? secteurActivite.hashCode() : 0);
        result = 31 * result + (dateCreation != null ? dateCreation.hashCode() : 0);
        return result;
    }
}
