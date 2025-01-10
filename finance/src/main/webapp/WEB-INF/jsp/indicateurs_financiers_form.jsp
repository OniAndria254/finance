<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
  #suggestionModal {
    max-height: 70vh; /* Limite la hauteur maximale pour activer le défilement */
    overflow-y: auto; /* Active le défilement vertical si nécessaire */
    position: fixed;
    top: 20%;
    left: 50%;
    transform: translate(-50%, -20%);
    background: #060c17; /* Fond sombre */
    color: #f5f5f5; /* Texte clair */
    padding: 20px;
    border: 1px solid #333; /* Bordure légèrement plus claire que le fond */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.6); /* Ombre subtile pour plus de profondeur */
    border-radius: 8px; /* Coins arrondis */
    z-index: 1000;
  }

  #modalOverlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.8); /* Overlay encore plus sombre */
    z-index: 999;
  }

  #suggestionModal h4 {
    margin-top: 0;
    color: #ffa726; /* Titre dans une couleur vive (orange) */
  }

  #suggestionModal p {
    margin-bottom: 20px;
    color: #d3d3d3; /* Texte légèrement moins lumineux pour le contraste */
  }

  #suggestionModal button {
    background: #5660d9; /* Bouton avec un fond orange */
    color: #FFFFFF; /* Texte foncé pour contraste */
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
  }

  #suggestionModal button:hover {
    background: #5660d9; /* Fond orange légèrement plus vif au survol */
  }



</style>
<h2 class="text-center mb-4">Afficher les Indicateurs Financiers</h2>

<form action="/indicateurs_financiers/indicateurs" method="GET">
  <div class="row">
    <div class="col-sm-6 mb-3">
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

    <div class="col-sm-6 mb-3">
      <label for="annee" class="form-label">Année :</label>
      <input type="number" class="form-control" id="annee" name="annee" required placeholder="Ex: 2024">
    </div>

    <div class="col-sm-6 mb-3">
      <label for="stock" class="form-label">Stock (en €) :</label>
      <input type="number" class="form-control" id="stock" name="stock" value="0" required>
    </div>

    <div class="col-sm-6 mb-3">
      <label for="taux" class="form-label">Taux d'intérêt de la dette :</label>
      <input type="number" class="form-control" id="taux" name="taux" value="0" required>
    </div>
  </div>

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

  if (roaObj != null && margeNetteObj != null && rentabiliteCapitauxPropresObj != null && ratioLiquiditeObj != null && ratioLiquiditeReduiteObj != null && levierFinancierObj != null && roeAvecLevierObj != null) {
    double roa = (Double) roaObj;
    double margeNette = (Double) margeNetteObj;
    double rentabiliteCapitauxPropres = (Double) rentabiliteCapitauxPropresObj;
    double ratioLiquidite = (Double) ratioLiquiditeObj;
    double ratioLiquiditeReduite = (Double) ratioLiquiditeReduiteObj;
    double levierFinancier = (Double) levierFinancierObj;
    double roeAvecLevier = (Double) roeAvecLevierObj;
%>
<h4 class="mt-4">Résultats des Indicateurs Financiers</h4>
<table class="table table-bordered table-striped mt-3">
  <thead class="table-dark">
  <tr>
    <th>Indicateur</th>
    <th>Valeur</th>
    <th>Voir suggestion</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td>Marge Nette (%)</td>
    <td><%= margeNette %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('margeNette')">Voir suggestion</button>
    </td>
  </tr>
  <tr>
    <td>Retour sur Actifs (ROA, %)</td>
    <td><%= roa %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('roa')">Voir suggestion</button>
    </td>
  </tr>
  <tr>
    <td>Retour sur Capitaux Propres (ROE, %)</td>
    <td><%= rentabiliteCapitauxPropres %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('rentabiliteCapitauxPropres')">Voir suggestion</button>
    </td>
  </tr>
  <tr>
    <td>Ratio de Liquidité Générale</td>
    <td><%= ratioLiquidite %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('ratioLiquidite')">Voir suggestion</button>
    </td>
  </tr>
  <tr>
    <td>Ratio de Liquidité Réduite</td>
    <td><%= ratioLiquiditeReduite %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('ratioLiquiditeReduite')">Voir suggestion</button>
    </td>
  </tr>
  <tr>
    <td>Levier Financier</td>
    <td><%= levierFinancier %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('levierFinancier')">Voir suggestion</button>
    </td>
  </tr>
  <tr>
    <td>ROE avec Levier Financier (%)</td>
    <td><%= roeAvecLevier %></td>
    <td>
      <button class="btn btn-primary" onclick="showSuggestion('roeAvecLevier')">Voir suggestion</button>
    </td>
  </tr>
  </tbody>
</table>

<!-- Boîte de dialogue -->
<div id="suggestionModal">
  <h4>Suggestion</h4>
  <p id="suggestionText"></p>
  <button onclick="closeModal()" class="btn btn-secondary">Fermer</button>
</div>
<div
    id="modalOverlay"
    onclick="closeModal()">
</div>


<script>
  const interpretations = <%= new org.json.JSONObject((Map) request.getAttribute("interpretations")).toString() %>;

  function showSuggestion(indicator) {
    const modal = document.getElementById('suggestionModal');
    const overlay = document.getElementById('modalOverlay');
    const suggestionText = document.getElementById('suggestionText');

    // Définit le texte de suggestion et affiche le modal
    suggestionText.innerText = interpretations[indicator] || "Aucune suggestion disponible.";
    modal.style.display = 'block';
    overlay.style.display = 'block';
  }

  function closeModal() {
    // Cache le modal et l'overlay
    document.getElementById('suggestionModal').style.display = 'none';
    document.getElementById('modalOverlay').style.display = 'none';
  }

</script>

<%
} else if (request.getParameter("idEntreprise") != null) {
%>
<p class="text-danger">Aucun résultat trouvé pour l'entreprise et l'année spécifiées.</p>

<%
  }
%>
