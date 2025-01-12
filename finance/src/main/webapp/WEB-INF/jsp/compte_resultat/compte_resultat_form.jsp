<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h2 class="text-center mb-4">Ajouter un Compte Résultat</h2>

<!-- Formulaire -->
<form action="/compte_resultat/add" method="POST">

  <!-- Sélection de l'Entreprise et Année -->
  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="idEntreprise" class="form-label">Entreprise :</label>
        <select class="form-select" id="idEntreprise" name="idEntreprise" required>
          <option value="" disabled selected>-- Sélectionnez une entreprise --</option>
          <%
            // Exemple pour charger les entreprises dynamiquement depuis le contrôleur
            List<Entreprise> entreprises = (List<Entreprise>) request.getAttribute("entreprises");

            if (entreprises != null) {
              for (Entreprise entreprise : entreprises) {
          %>
          <option value="<%= entreprise.getIdEntreprise() %>">
            <%= entreprise.getNomEntreprise() %> - <%= entreprise.getSecteurActivite() %>
          </option>
          <%
              }
            }
          %>
        </select>
      </div>
    </div><!-- Col -->

    <div class="col-sm-6">
      <div class="mb-3">
        <label for="annee" class="form-label">Année :</label>
        <input type="number" class="form-control" id="annee" name="annee" required placeholder="Ex: 2024">
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <hr>

  <!-- Catégorie et Sous-Catégorie -->
  <h4>Détails du Compte Résultat</h4>
  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="categorie" class="form-label">Catégorie :</label>
        <select class="form-select" id="categorie" name="categorie" required>
          <option value="" disabled selected>-- Sélectionnez une catégorie --</option>
          <option value="Revenus">Revenus</option>
          <option value="Charges">Charges</option>
          <option value="Resultat">Resultat</option>

        </select>
      </div>
    </div><!-- Col -->

    <div class="col-sm-6">
      <div class="mb-3">
        <label for="sousCategorie" class="form-label">Sous-catégorie :</label>
        <input type="text" class="form-control" id="sousCategorie" name="sousCategorie" required placeholder="Ex: Vente de produits">
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <!-- Montant -->
  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="montant" class="form-label">Montant :</label>
        <input type="number" step="0.01" class="form-control" id="montant" name="montant" required placeholder="Entrez le montant en euros">
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <hr>

    <button type="submit" class="btn btn-primary">Ajouter le Compte Résultat</button>
    <button type="reset" class="btn btn-secondary">Réinitialiser</button>
</form>
