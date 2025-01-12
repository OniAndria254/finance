<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h2>Modifier l'Entreprise</h2>
<br>
<%
  // Récupérer l'objet entreprise et la liste des postes
  Entreprise entreprise = (Entreprise) request.getAttribute("entreprise");
%>
<form action="/entreprises/edit/<%= entreprise.getIdEntreprise() %>" method="POST">

  <div class="row">
    <div class="col-sm-6">
      <div class="mb-3">
        <label for="nom" class="form-label">Nom de l'Entreprise:</label>
        <input type="text" class="form-control" id="nom" name="nom" value="<%= entreprise.getNom() %>" required placeholder="Nom de l'entreprise">
      </div>
    </div><!-- Col -->

  </div><!-- Row -->


  <hr>

  <button type="submit" class="btn btn-primary submit">Mettre à jour</button>
</form>

<br>
<a href="/entreprises/list" class="btn btn-link">Retour à la liste des entreprises</a>

