<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page import="java.util.List" %>

<div class="card-body">

<h3 class="card-title">Liste des Entreprises</h3>
<div class="table-responsive">
<table class="table table-hover">
    <thead>
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        // Récupérer la liste des entreprises depuis le scope de la requête
        List<Entreprise> entreprises = (List<Entreprise>) request.getAttribute("entreprises");

        // Vérifier si la liste n'est pas nulle et non vide
        if (entreprises != null) {
            for (Entreprise entreprise : entreprises) {
    %>
    <tr>
        <td><%= entreprise.getIdEntreprise() %></td>
        <td><%= entreprise.getNom() %></td>
        <td>
            <a href="<%= "/entreprises/edit/" + entreprise.getIdEntreprise() %>">Modifier</a> |
            <a href="<%= "/entreprises/delete/" + entreprise.getIdEntreprise() %>"
               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette entreprise ?');">Supprimer</a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
</div>
</div>
