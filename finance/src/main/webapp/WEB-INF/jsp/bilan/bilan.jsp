<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h2 class="text-center mb-4">Ajouter un Bilan</h2>

<!-- Formulaire pour ajouter un bilan -->
<form action="/bilan/add" method="POST">

  <!-- ID Entreprise et Année -->
  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="idEntreprise" class="form-label">Entreprise :</label>
        <select class="form-select" id="idEntreprise" name="idEntreprise" required>
          <option value="" disabled selected>-- Sélectionnez une entreprise --</option>
          <%
            // Récupérer la liste des entreprises depuis la requête (setAttribute dans le contrôleur)
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

  <!-- Détails du Bilan -->
  <h4>Détails du Bilan</h4>

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="categorie" class="form-label">Catégorie :</label>
        <select class="form-select" id="categorie" name="categorie" required>
          <option value="" disabled selected>-- Sélectionnez une catégorie --</option>
          <option value="Actifs">Actifs</option>
          <option value="Passifs">Passifs</option>
          <option value="Capitaux Propres">Capitaux Propres</option>
        </select>
      </div>
    </div><!-- Col -->

    <div class="col-sm-6">
      <div class="mb-3">
        <label for="sousCategorie" class="form-label">Sous-catégorie :</label>
        <select class="form-select" id="sousCategorie" name="sousCategorie" required>
          <option value="" disabled selected>-- Sélectionnez une sous-catégorie --</option>
          <option value="Actifs courants">Actifs courants</option>
          <option value="Actifs immobilises">Actifs immobilisés</option>
          <option value="Passifs courants">Passifs courants</option>
          <option value="Passifs non courants">Passifs non courants</option>
          <option value="">Passifs non courants</option>

        </select>
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="montant" class="form-label">Montant :</label>
        <input type="number" step="0.01" class="form-control" id="montant" name="montant" required placeholder="Entrez le montant en euros">
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <hr>

  <!-- Bouton de soumission -->
  <button type="submit" class="btn btn-primary submit">Ajouter le Bilan</button>
</form>