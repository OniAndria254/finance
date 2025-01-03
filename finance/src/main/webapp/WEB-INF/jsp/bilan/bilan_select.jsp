<%@ page import="itu.p16.finance.entity.Entreprise" %>
<%@ page import="java.util.List" %>
<%@ page import="itu.p16.finance.entity.BilanDetails" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h2 class="text-center mb-4">Afficher le Bilan</h2>

<!-- Formulaire de sélection -->
<form action="/bilan/afficher" method="GET">
    <div class="row">
        <!-- Sélectionner une Entreprise -->
        <div class="col-sm-6">
            <div class="mb-3">
                <label for="idEntreprise" class="form-label">Entreprise :</label>
                <select class="form-select" id="idEntreprise" name="idEntreprise" required>
                    <option value="" disabled selected>-- Sélectionnez une entreprise --</option>
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
        </div>

        <!-- Saisir une Année -->
        <div class="col-sm-6">
            <div class="mb-3">
                <label for="annee" class="form-label">Année :</label>
                <input type="number" class="form-control" id="annee" name="annee" required placeholder="Ex: 2024">
            </div>
        </div>
    </div>

    <button type="submit" class="btn btn-primary">Afficher le Bilan</button>
</form>

<hr>

<!-- Affichage des résultats -->
<%
    List<BilanDetails> details = (List<BilanDetails>) request.getAttribute("bilanDetails");
    double totalActifs = Double.parseDouble(request.getAttribute("totalActifs").toString());
    double totalPassifsCP = Double.parseDouble(request.getAttribute("totalPassifsCP").toString());

    if (details != null && !details.isEmpty()) {
        // Filtrer les données en deux sections : Actifs et Capitaux propres et passifs
        List<BilanDetails> actifs = details.stream()
                .filter(d -> d.getCategorie().equalsIgnoreCase("Actifs"))
                .toList();
        List<BilanDetails> capitauxPassifs = details.stream()
                .filter(d -> d.getCategorie().equalsIgnoreCase("Capitaux propres") || d.getCategorie().equalsIgnoreCase("Passifs"))
                .toList();
%>

<h4 class="mt-4 text-center">Bilan pour l'Année <%= request.getParameter("annee") %></h4>

<!-- Structure en deux colonnes -->
<div class="row">
    <!-- Colonne Actifs -->
    <div class="col-md-6">
        <h5 class="text-center">Actifs</h5>
        <table class="table table-bordered text-center">
            <thead>
            <tr>
                <th>Sous-catégorie</th>
                <th>Montant (€)</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (BilanDetails actif : actifs) {
            %>
            <tr>
                <td><%= actif.getSousCategorie() %></td>
                <td><%= String.format("%.2f", actif.getMontant()) %></td>
            </tr>
            <%
                }
            %>
            </tbody>
            <tfoot>
            <tr>
                <th>Total des Actifs</th>
                <th>
                    <%= String.format("%.2f", totalActifs) %> €
                </th>
            </tr>
            </tfoot>
        </table>
    </div>

    <!-- Colonne Capitaux propres et passifs -->
    <div class="col-md-6">
        <h5 class="text-center">Capitaux propres et passifs</h5>
        <table class="table table-bordered text-center">
            <thead>
            <tr>
                <th>Sous-catégorie</th>
                <th>Montant (€)</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (BilanDetails passif : capitauxPassifs) {
            %>
            <tr>
                <td><%= passif.getSousCategorie() %></td>
                <td><%= String.format("%.2f", passif.getMontant()) %></td>
            </tr>
            <%
                }
            %>
            </tbody>
            <tfoot>
            <tr>
                <th>Total des Capitaux propres et passifs</th>
                <th>
                    <%= String.format("%.2f", totalPassifsCP) %> €
                </th>
            </tr>
            </tfoot>
        </table>
    </div>
</div>

<%
} else if (request.getParameter("idEntreprise") != null) {
%>
<p class="text-danger text-center">Aucun bilan trouvé pour l'entreprise sélectionnée et l'année spécifiée.</p>
<%
    }
%>
