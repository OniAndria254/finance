package itu.p16.finance.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.util.List;

@Entity
public class Entreprise {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_entreprise", nullable = false)
    private Integer idEntreprise;
    @Basic
    @Column(name = "nom", nullable = true, length = 50)
    private String nom;
    @OneToMany(mappedBy = "entrepriseByIdEntreprise")
    @JsonIgnore
    private List<Bilan> bilansByIdEntreprise;

    public Integer getIdEntreprise() {
        return idEntreprise;
    }

    public void setIdEntreprise(Integer idEntreprise) {
        this.idEntreprise = idEntreprise;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Entreprise that = (Entreprise) o;

        if (idEntreprise != null ? !idEntreprise.equals(that.idEntreprise) : that.idEntreprise != null) return false;
        if (nom != null ? !nom.equals(that.nom) : that.nom != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idEntreprise != null ? idEntreprise.hashCode() : 0;
        result = 31 * result + (nom != null ? nom.hashCode() : 0);
        return result;
    }

    public List<Bilan> getBilansByIdEntreprise() {
        return bilansByIdEntreprise;
    }

    public void setBilansByIdEntreprise(List<Bilan> bilansByIdEntreprise) {
        this.bilansByIdEntreprise = bilansByIdEntreprise;
    }
}
