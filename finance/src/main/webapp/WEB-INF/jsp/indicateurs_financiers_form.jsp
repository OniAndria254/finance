<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h2 class="text-center mb-4">Afficher les Indicateurs Financiers</h2>

<form action="/indicateurs_financiers/indicateurs" method="GET">
  <div class="row">
    <div class="col-sm-6">
      <label for="idEntreprise" class="form-label">Entreprise :</label>
      <select class="form-select" id="idEntreprise" name="idEntreprise" required>
        <option value="" disabled selected>-- Sélectionner une entreprise --</option>
        <%
          List<Entreprise> entreprises = (List<Entreprise>) request.getAttribute("entreprises");
          if (entreprises != null) {
            for (Entreprise entreprise : entreprises) {
        %>
        <option value="<%= entreprise.getIdEntreprise() %>">
          <%= entreprise.getNomEntreprise() %>
        </option>
        <%
            }
          }
        %>
      </select>
    </div>

    <div class="col-sm-6">
      <label for="annee" class="form-label">Année :</label>
      <input type="number" class="form-control" id="annee" name="annee" required placeholder="Ex: 2024">
    </div>
    <br>
    <br>
    <br>
    <br>

      <div class="col-sm-6">
        <label for="stock" class="form-label">Stock (en €) :</label>
        <input type="number" class="form-control" id="stock" name="stock" value="0" required>
      </div>

      <div class="col-sm-6">
        <label for="taux" class="form-label">Taux d'intéret de la dette :</label>
        <input type="number" class="form-control" id="taux" name="taux" value="0" required>
      </div>
  </div>
<br>
  <button type="submit" class="btn btn-primary">Afficher les Indicateurs Financiers</button>
</form>

<hr>

<!-- Affichage des indicateurs financiers -->
<%
  Object roaObj = request.getAttribute("roa");
  Object margeNetteObj = request.getAttribute("margeNette");
  Object rentabiliteCapitauxPropresObj = request.getAttribute("rentabiliteCapitauxPropres");
  Object ratioLiquiditeObj = request.getAttribute("ratioLiquidite");
  Object ratioLiquiditeReduiteObj = request.getAttribute("ratioLiquiditeReduite");

  Object levierFinancierObj = request.getAttribute("levierFinancier");
  Object roeAvecLevierObj = request.getAttribute("roeAvecLevier");

  Object interpretationLevierObj = request.getAttribute("interpretationLevier");

  if (roaObj != null && margeNetteObj != null && rentabiliteCapitauxPropresObj != null && ratioLiquiditeObj != null && ratioLiquiditeReduiteObj != null && levierFinancierObj != null && roeAvecLevierObj != null && interpretationLevierObj != null) {
    double roa = (Double) roaObj;
    double margeNette = (Double) margeNetteObj;
    double rentabiliteCapitauxPropres = (Double) rentabiliteCapitauxPropresObj;
    double ratioLiquidite = (Double) ratioLiquiditeObj;
    double ratioLiquiditeReduite = (Double) ratioLiquiditeReduiteObj;

    double levierFinancier = (Double) levierFinancierObj;
    double roeAvecLevier = (Double) roeAvecLevierObj;

    // Interprétations
    String interpretationLevier = (String) interpretationLevierObj;

    String interpretationROA = (roa > 5) ? "Bon retour sur actifs." : "Le ROA est faible, l'entreprise pourrait améliorer l'efficacité de ses actifs.";
    String interpretationMargeNette = (margeNette > 10) ? "Bonne rentabilité nette." : "La marge nette est faible, l'entreprise pourrait optimiser ses coûts.";
    String interpretationRentabilite = (rentabiliteCapitauxPropres > 15) ? "Bonne rentabilité des capitaux propres." : "Rentabilité des capitaux propres faible, l'entreprise pourrait avoir des difficultés à générer des bénéfices pour les actionnaires.";
    String interpretationRatioLiquidite = (ratioLiquidite > 1) ? "L'entreprise a suffisamment de liquidités pour couvrir ses passifs courants." : "L'entreprise pourrait rencontrer des difficultés à couvrir ses passifs courants.";
    String interpretationLiquiditeReduite = (ratioLiquiditeReduite > 1) ? "L'entreprise a une bonne liquidité réduite." : "La liquidité réduite est faible, l'entreprise pourrait rencontrer des problèmes en cas de crise de liquidité.";
%>
<h5 class="mt-4">Marge Nette : <%= margeNette %>%</h5>
<p><%= interpretationMargeNette %></p>

<h5 class="mt-4">Retour sur Actifs (ROA) : <%= roa %>%</h5>
<p><%= interpretationROA %></p>

<h5 class="mt-4">Retour sur Capitaux Propres (ROE): <%= rentabiliteCapitauxPropres %>%</h5>
<p><%= interpretationRentabilite %></p>

<h5 class="mt-4">Ratio de Liquidité générale : <%= ratioLiquidite %></h5>
<p><%= interpretationRatioLiquidite %></p>

<h5 class="mt-4">Ratio de Liquidité Réduite : <%= ratioLiquiditeReduite %></h5>
<p><%= interpretationLiquiditeReduite %></p>
<hr>
<h5 class="mt-4">Levier financier : <%= levierFinancier %></h5>
<p><%= interpretationLevier %></p>

<h5 class="mt-4">ROE avec Levier Financier : <%= roeAvecLevier %>%</h5>

<%
} else if (request.getParameter("idEntreprise") != null) {
%>
<p class="text-danger">Aucun résultat trouvé pour l'entreprise et l'année spécifiées.</p>
<%
  }
%>
