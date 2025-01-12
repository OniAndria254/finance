<%@ page import="itu.p16.finance.entity.CompteResultatDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h2 class="text-center mb-4">Afficher le Compte Résultat</h2>

<!-- Formulaire de sélection -->
<form action="/compte_resultat/afficher" method="GET">
  <div class="row">
    <!-- Sélectionner une Entreprise -->
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="idEntreprise" class="form-label">Entreprise :</label>
        <select class="form-select" id="idEntreprise" name="idEntreprise" required>
          <option value="" disabled selected>-- Sélectionnez une entreprise --</option>
          <%
            // Récupération de la liste des entreprises passée par le contrôleur
            List<Entreprise> entreprises =
                    (List<Entreprise>) request.getAttribute("entreprises");

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
    </div>

    <!-- Saisir une Année -->
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="annee" class="form-label">Année :</label>
        <input type="number" class="form-control" id="annee" name="annee" required placeholder="Ex: 2024">
      </div>
    </div>
  </div>

  <button type="submit" class="btn btn-primary">Afficher le Compte Résultat</button>
</form>

<hr>

<!-- Affichage des résultats -->
<%
  // Récupération des détails du compte résultat
  List<CompteResultatDetails> details =
          (List<CompteResultatDetails>) request.getAttribute("details");

  if (details != null && !details.isEmpty()) {
%>
<h4 class="mt-4">Compte Résultat pour l'année <%= request.getParameter("annee") %></h4>
<table class="table table-bordered">
  <thead class="">
  <tr>
    <th>Catégorie</th>
    <th>Sous-catégorie</th>
    <th>Montant (€)</th>
  </tr>
  </thead>
  <tbody>
  <%
    // Boucle pour afficher chaque détail du compte résultat
    for (CompteResultatDetails detail : details) {
  %>
  <tr>
    <td><%= detail.getCategorie() %></td>
    <td><%= detail.getSousCategorie() %></td>
    <td><%= String.format("%.2f", detail.getMontant()) %></td>
  </tr>
  <%
    }
  %>
  </tbody>
</table>
<%
} else if (request.getParameter("idEntreprise") != null) {
%>
<p class="text-danger">Aucun résultat trouvé pour l'entreprise sélectionnée et l'année spécifiée.</p>
<%
  }
%>
