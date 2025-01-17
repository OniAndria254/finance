<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="itu.p16.finance.entity.*" %>

<html>
<head>
  <title>Ajouter un poste de bilan</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h2>Ajouter un poste de bilan</h2>

<form action="/bilans" method="POST">
  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="entreprise" class="form-label">Société:</label>
        <select class="form-control" id="entreprise" name="entrepriseId" required>
          <option value="">Sélectionnez une société</option>
          <%
            List<Entreprise> entreprises = (List<Entreprise>) request.getAttribute("entreprises");
            if (entreprises != null) {
              for (Entreprise entreprise : entreprises) {
          %>
          <option value="<%= entreprise.getIdEntreprise() %>"><%= entreprise.getNom() %></option>
          <%
              }
            }
          %>
        </select>
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="categorie" class="form-label">Classe de bilan:</label>
        <select class="form-control" id="categorie" name="categorieId" required>
          <option value="">Sélectionnez une classe de bilan</option>
          <%
            List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
            if (categories != null) {
              for (Categorie categorie : categories) {
          %>
          <option value="<%= categorie.getIdCategorie() %>"><%= categorie.getNomCategorie() %></option>
          <%
              }
            }
          %>
        </select>
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="sousCategorie" class="form-label">Sous-rubrique:</label>
        <select class="form-control" id="sousCategorie" name="sousCategorieId">
          <option value="">Sélectionnez une sous-rubrique</option>
        </select>
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="sousSousCategorie" class="form-label">Détail du poste:</label>
        <select class="form-control" id="sousSousCategorie" name="sousSousCategorieId">
          <option value="">Sélectionnez un détail du poste</option>
        </select>
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="description" class="form-label">Description:</label>
        <input type="text" class="form-control" id="description" name="description">
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="valeur" class="form-label">Montant:</label>
        <input type="number" class="form-control" id="valeur" name="valeur" required step="0.01">
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="date" class="form-label">Date d'enregistrement:</label>
        <input type="date" class="form-control" id="date" name="date" required>
      </div>
    </div><!-- Col -->
  </div><!-- Row -->

  <hr>

  <button type="submit" class="btn btn-primary submit">Ajouter</button>
</form>

<script>
  $(document).ready(function() {
    $('#categorie').change(function() {
      var categorieId = $(this).val();
      if (categorieId) {
        console.log("Envoi de la requête AJAX pour les sous-catégories..."); // Debug
        $.ajax({
          url: '/sousCategories',
          type: 'GET',
          data: { categorieId: categorieId },
          success: function(data) {
            console.log("Réponse reçue :", data); // Debug
            $('#sousCategorie').empty().append('<option value="">Sélectionnez une sous-rubrique</option>');
            $.each(data, function(key, value) {
              $('#sousCategorie').append('<option value="' + value.idSousCategorie + '">' + value.nomSousCategorie + '</option>');
            });
          },
          error: function(xhr, status, error) {
            console.error("Erreur lors de la requête AJAX :", error); // Debug
          }
        });
      } else {
        $('#sousCategorie').empty().append('<option value="">Sélectionnez une sous-rubrique</option>');
      }
    });

    // Mettre à jour les sous-sous-catégories lorsque la sous-catégorie est sélectionnée
    $('#sousCategorie').change(function() {
      var sousCategorieId = $(this).val();
      if (sousCategorieId) {
        $.ajax({
          url: '/sousSousCategories',
          type: 'GET',
          data: { sousCategorieId: sousCategorieId },
          success: function(data) {
            $('#sousSousCategorie').empty().append('<option value="">Sélectionnez un détail du poste</option>');
            $.each(data, function(key, value) {
              $('#sousSousCategorie').append('<option value="' + value.idSousSousCategorie + '">' + value.nom + '</option>');
            });
          }
        });
      } else {
        $('#sousSousCategorie').empty().append('<option value="">Sélectionnez un détail du poste</option>');
      }
    });
  });
</script>
</body>
</html>