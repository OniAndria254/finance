package itu.p16.finance.entity;

import jakarta.persistence.*;

@Entity
public class CompteGestion {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_compte", nullable = false)
    private Integer idCompte;
    @Basic
    @Column(name = "compte", nullable = false)
    private Integer compte;
    @Basic
    @Column(name = "nom_compte", nullable = false, length = 100)
    private String nomCompte;
    @Basic
    @Column(name = "type_compte", nullable = false, length = 50)
    private String typeCompte;

    public Integer getIdCompte() {
        return idCompte;
    }

    public void setIdCompte(Integer idCompte) {
        this.idCompte = idCompte;
    }

    public Integer getCompte() {
        return compte;
    }

    public void setCompte(Integer compte) {
        this.compte = compte;
    }

    public String getNomCompte() {
        return nomCompte;
    }

    public void setNomCompte(String nomCompte) {
        this.nomCompte = nomCompte;
    }

    public String getTypeCompte() {
        return typeCompte;
    }

    public void setTypeCompte(String typeCompte) {
        this.typeCompte = typeCompte;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CompteGestion that = (CompteGestion) o;

        if (idCompte != null ? !idCompte.equals(that.idCompte) : that.idCompte != null) return false;
        if (compte != null ? !compte.equals(that.compte) : that.compte != null) return false;
        if (nomCompte != null ? !nomCompte.equals(that.nomCompte) : that.nomCompte != null) return false;
        if (typeCompte != null ? !typeCompte.equals(that.typeCompte) : that.typeCompte != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idCompte != null ? idCompte.hashCode() : 0;
        result = 31 * result + (compte != null ? compte.hashCode() : 0);
        result = 31 * result + (nomCompte != null ? nomCompte.hashCode() : 0);
        result = 31 * result + (typeCompte != null ? typeCompte.hashCode() : 0);
        return result;
    }
}
