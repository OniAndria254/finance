<%@ page import="java.util.List" %>
<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
  <h2>Sélectionnez l'année et l'entreprise</h2>
  <hr>
  <form action="/compteResultat" method="GET">
    <div class="row">
      <div class="col-sm-6">
        <div class="mb-3">
          <label for="annee" class="form-label">Année :</label>
          <select class="form-control" id="annee" name="annee" required>
            <option value="">Sélectionnez une année</option>
            <%
              // Récupérer la liste des années disponibles
              List<Integer> annees = (List<Integer>) request.getAttribute("annees");
              if (annees != null) {
                for (Integer annee : annees) {
            %>
            <option value="<%= annee %>"><%= annee %></option>
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
          <label for="entreprise" class="form-label">Entreprise :</label>
          <select class="form-control" id="entreprise" name="entrepriseId" required>
            <option value="">Sélectionnez une entreprise</option>
            <%
              // Récupérer la liste des entreprises
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

    <hr>

    <button type="submit" class="btn btn-primary">Afficher le Compte de Résultat</button>
  </form>
</div>