<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h2>Ajouter une nouvelle Entreprise</h2>

<form action="/entreprises" method="POST">
    <div class="row">
        <div class="col-sm-6">
            <div class="mb-3">
                <label for="nomEntreprise" class="form-label">Nom de l'Entreprise:</label>
                <input type="text" class="form-control" id="nomEntreprise" name="nomEntreprise" required placeholder="Nom de l'entreprise">
            </div>
        </div><!-- Col -->

        <div class="col-sm-6">
            <div class="mb-3">
                <label for="secteurActivite" class="form-label">Secteur d'Activité:</label>
                <input type="text" class="form-control" id="secteurActivite" name="secteurActivite" required placeholder="Secteur d'activité">
            </div>
        </div><!-- Col -->
    </div><!-- Row -->

    <hr>

    <div class="row">
        <div class="col-sm-6">
            <div class="mb-3">
                <label for="dateCreation" class="form-label">Date de Création:</label>
                <input type="date" class="form-control" id="dateCreation" name="dateCreation" required>
            </div>
        </div><!-- Col -->
    </div><!-- Row -->

    <hr>

    <button type="submit" class="btn btn-primary submit">Ajouter</button>
</form>

<br>
<a href="/entreprises/list" class="btn btn-link">Retour à la liste des entreprises</a>
