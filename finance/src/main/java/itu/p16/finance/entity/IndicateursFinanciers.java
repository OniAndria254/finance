package itu.p16.finance.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "indicateurs_financiers", schema = "public", catalog = "finance")
public class IndicateursFinanciers {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id_indicateur", nullable = false)
    private Integer idIndicateur;
    @Basic
    @Column(name = "id_bilan", nullable = false)
    private Integer idBilan;
    @Basic
    @Column(name = "id_resultat", nullable = false)
    private Integer idResultat;
    @Basic
    @Column(name = "marge_nette", nullable = true, precision = 2)
    private BigDecimal margeNette;
    @Basic
    @Column(name = "retour_actifs", nullable = true, precision = 2)
    private BigDecimal retourActifs;
    @Basic
    @Column(name = "retour_capitaux_propres", nullable = true, precision = 2)
    private BigDecimal retourCapitauxPropres;
    @Basic
    @Column(name = "ratio_liquidite_generale", nullable = true, precision = 2)
    private BigDecimal ratioLiquiditeGenerale;
    @Basic
    @Column(name = "ratio_liquidite_reduite", nullable = true, precision = 2)
    private BigDecimal ratioLiquiditeReduite;
    @Basic
    @Column(name = "ratio_endettement_global", nullable = true, precision = 2)
    private BigDecimal ratioEndettementGlobal;
    @Basic
    @Column(name = "couverture_interets", nullable = true, precision = 2)
    private BigDecimal couvertureInterets;
    @Basic
    @Column(name = "levier_financier", nullable = true, precision = 2)
    private BigDecimal levierFinancier;

    public Integer getIdIndicateur() {
        return idIndicateur;
    }

    public void setIdIndicateur(Integer idIndicateur) {
        this.idIndicateur = idIndicateur;
    }

    public Integer getIdBilan() {
        return idBilan;
    }

    public void setIdBilan(Integer idBilan) {
        this.idBilan = idBilan;
    }

    public Integer getIdResultat() {
        return idResultat;
    }

    public void setIdResultat(Integer idResultat) {
        this.idResultat = idResultat;
    }

    public BigDecimal getMargeNette() {
        return margeNette;
    }

    public void setMargeNette(BigDecimal margeNette) {
        this.margeNette = margeNette;
    }

    public BigDecimal getRetourActifs() {
        return retourActifs;
    }

    public void setRetourActifs(BigDecimal retourActifs) {
        this.retourActifs = retourActifs;
    }

    public BigDecimal getRetourCapitauxPropres() {
        return retourCapitauxPropres;
    }

    public void setRetourCapitauxPropres(BigDecimal retourCapitauxPropres) {
        this.retourCapitauxPropres = retourCapitauxPropres;
    }

    public BigDecimal getRatioLiquiditeGenerale() {
        return ratioLiquiditeGenerale;
    }

    public void setRatioLiquiditeGenerale(BigDecimal ratioLiquiditeGenerale) {
        this.ratioLiquiditeGenerale = ratioLiquiditeGenerale;
    }

    public BigDecimal getRatioLiquiditeReduite() {
        return ratioLiquiditeReduite;
    }

    public void setRatioLiquiditeReduite(BigDecimal ratioLiquiditeReduite) {
        this.ratioLiquiditeReduite = ratioLiquiditeReduite;
    }

    public BigDecimal getRatioEndettementGlobal() {
        return ratioEndettementGlobal;
    }

    public void setRatioEndettementGlobal(BigDecimal ratioEndettementGlobal) {
        this.ratioEndettementGlobal = ratioEndettementGlobal;
    }

    public BigDecimal getCouvertureInterets() {
        return couvertureInterets;
    }

    public void setCouvertureInterets(BigDecimal couvertureInterets) {
        this.couvertureInterets = couvertureInterets;
    }

    public BigDecimal getLevierFinancier() {
        return levierFinancier;
    }

    public void setLevierFinancier(BigDecimal levierFinancier) {
        this.levierFinancier = levierFinancier;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        IndicateursFinanciers that = (IndicateursFinanciers) o;

        if (idIndicateur != null ? !idIndicateur.equals(that.idIndicateur) : that.idIndicateur != null) return false;
        if (idBilan != null ? !idBilan.equals(that.idBilan) : that.idBilan != null) return false;
        if (idResultat != null ? !idResultat.equals(that.idResultat) : that.idResultat != null) return false;
        if (margeNette != null ? !margeNette.equals(that.margeNette) : that.margeNette != null) return false;
        if (retourActifs != null ? !retourActifs.equals(that.retourActifs) : that.retourActifs != null) return false;
        if (retourCapitauxPropres != null ? !retourCapitauxPropres.equals(that.retourCapitauxPropres) : that.retourCapitauxPropres != null)
            return false;
        if (ratioLiquiditeGenerale != null ? !ratioLiquiditeGenerale.equals(that.ratioLiquiditeGenerale) : that.ratioLiquiditeGenerale != null)
            return false;
        if (ratioLiquiditeReduite != null ? !ratioLiquiditeReduite.equals(that.ratioLiquiditeReduite) : that.ratioLiquiditeReduite != null)
            return false;
        if (ratioEndettementGlobal != null ? !ratioEndettementGlobal.equals(that.ratioEndettementGlobal) : that.ratioEndettementGlobal != null)
            return false;
        if (couvertureInterets != null ? !couvertureInterets.equals(that.couvertureInterets) : that.couvertureInterets != null)
            return false;
        if (levierFinancier != null ? !levierFinancier.equals(that.levierFinancier) : that.levierFinancier != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = idIndicateur != null ? idIndicateur.hashCode() : 0;
        result = 31 * result + (idBilan != null ? idBilan.hashCode() : 0);
        result = 31 * result + (idResultat != null ? idResultat.hashCode() : 0);
        result = 31 * result + (margeNette != null ? margeNette.hashCode() : 0);
        result = 31 * result + (retourActifs != null ? retourActifs.hashCode() : 0);
        result = 31 * result + (retourCapitauxPropres != null ? retourCapitauxPropres.hashCode() : 0);
        result = 31 * result + (ratioLiquiditeGenerale != null ? ratioLiquiditeGenerale.hashCode() : 0);
        result = 31 * result + (ratioLiquiditeReduite != null ? ratioLiquiditeReduite.hashCode() : 0);
        result = 31 * result + (ratioEndettementGlobal != null ? ratioEndettementGlobal.hashCode() : 0);
        result = 31 * result + (couvertureInterets != null ? couvertureInterets.hashCode() : 0);
        result = 31 * result + (levierFinancier != null ? levierFinancier.hashCode() : 0);
        return result;
    }
}
