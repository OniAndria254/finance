<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>
<%@ page import="itu.p16.finance.entity.Entreprise" %>
<html>
<head>
  <title>Indicateurs Financiers</title>
  <style>
    #suggestions {
      margin-top: 20px;
      padding: 20px;
      background-color: #f9f9f9;
      border: 1px solid #ddd;
      border-radius: 8px;
    }

    #suggestions h3 {
      margin-bottom: 15px;
      color: #333;
    }

    #suggestion-text {
      font-size: 14px;
      line-height: 1.6;
      color: #555;
    }

    #suggestion-text strong {
      color: #000;
    }

    #suggestion-text ul {
      list-style-type: disc;
      margin-left: 20px;
    }

    #suggestion-text li {
      margin-bottom: 10px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    table, th, td {
      border: 1px solid black;
    }
    th, td {
      padding: 8px;
      text-align: left;
    }
    th {
      background-color: #f2f2f2;
    }
    #suggestions {
      margin-top: 20px;
      padding: 10px;
      background-color: #f9f9f9;
      border: 1px solid #ddd;
    }
  </style>
</head>
<body>
<h2>Indicateurs Financiers pour l'année <%= request.getAttribute("annee")%></h2>
<hr>
<table>
  <thead>
  <tr>
    <th>Indicateur</th>
    <th>Valeur</th>
    <th>Interprétation</th>
  </tr>
  </thead>
  <tbody>
  <%
    // Récupérer les données du modèle
    Map<String, BigDecimal> indicateurs = (Map<String, BigDecimal>) request.getAttribute("indicateurs");
    if (indicateurs != null) {
  %>
  <tr>
    <td><strong>Marge Nette</strong></td>
    <td><%= indicateurs.get("Marge Nette") %> %</td>
    <td>
      <% if (indicateurs.get("Marge Nette").compareTo(BigDecimal.valueOf(10)) > 0) { %>
      La marge nette est élevée, ce qui indique une bonne rentabilité.
      <% } else { %>
      La marge nette est faible, ce qui peut indiquer des difficultés à générer des bénéfices.
      <% } %>
    </td>
  </tr>
  <tr>
    <td><strong>ROA (Return on Assets)</strong></td>
    <td><%= indicateurs.get("ROA") %> %</td>
    <td>
      <% if (indicateurs.get("ROA").compareTo(BigDecimal.valueOf(10)) > 0) { %>
      Le ROA est élevé, ce qui montre une utilisation efficace des actifs.
      <% } else { %>
      Le ROA est faible, ce qui peut indiquer une mauvaise utilisation des ressources.
      <% } %>
    </td>
  </tr>
  <tr>
    <td><strong>ROE (Return on Equity)</strong></td>
    <td><%= indicateurs.get("ROE") %> %</td>
    <td>
      <% if (indicateurs.get("ROE").compareTo(BigDecimal.valueOf(20)) > 0) { %>
      Le ROE est élevé, ce qui montre une bonne rentabilité pour les actionnaires.
      <% } else { %>
      Le ROE est faible, ce qui peut indiquer un rendement insuffisant pour les actionnaires.
      <% } %>
    </td>
  </tr>
  <tr>
    <td><strong>Liquidité Générale</strong></td>
    <td><%= indicateurs.get("Liquidité Générale") %></td>
    <td>
      <% if (indicateurs.get("Liquidité Générale").compareTo(BigDecimal.valueOf(2)) > 0) { %>
      La liquidité générale est confortable, ce qui montre une bonne capacité à couvrir les dettes à court terme.
      <% } else { %>
      La liquidité générale est faible, ce qui peut indiquer des difficultés à couvrir les dettes à court terme.
      <% } %>
    </td>
  </tr>
  <tr>
    <td><strong>Liquidité Réduite</strong></td>
    <td><%= indicateurs.get("Liquidité Réduite") %></td>
    <td>
      <% if (indicateurs.get("Liquidité Réduite").compareTo(BigDecimal.valueOf(1.5)) > 0) { %>
      La liquidité réduite est bonne, ce qui indique une capacité à couvrir les dettes sans dépendre des stocks.
      <% } else { %>
      La liquidité réduite est faible, ce qui peut indiquer une dépendance excessive aux stocks.
      <% } %>
    </td>
  </tr>
  <tr>
    <td><strong>Endettement Global</strong></td>
    <td><%= indicateurs.get("Endettement Global") %> %</td>
    <td>
      <% if (indicateurs.get("Endettement Global").compareTo(BigDecimal.valueOf(50)) > 0) { %>
      L'endettement global est élevé, ce qui peut accroître le risque financier.
      <% } else { %>
      L'endettement global est acceptable, ce qui montre une structure financière équilibrée.
      <% } %>
    </td>
  </tr>
  <%
  } else {
  %>
  <tr>
    <td colspan="3">Aucune donnée disponible pour les indicateurs financiers.</td>
  </tr>
  <%
    }
  %>
  </tbody>
</table>
<!-- Section pour afficher les suggestions -->
<div id="suggestions">
  <h3>Suggestions de l'IA :</h3>
  <div id="suggestion-text">
    Chargement des suggestions...
  </div>
</div>

  <%
if (indicateurs != null) {
  String phrase = "Analyse des indicateurs financiers pour l'année " + 2023 + ". " +
          "Marge Nette: " + indicateurs.get("Marge Nette") + " %, " +
          "ROA: " + indicateurs.get("ROA") + " %, " +
          "ROE: " + indicateurs.get("ROE") + " %, " +
          "Liquidité Générale: " + indicateurs.get("Liquidité Générale") + ", " +
          "Liquidité Réduite: " + indicateurs.get("Liquidité Réduite") + ", " +
          "Endettement Global: " + indicateurs.get("Endettement Global") + " %, ";
  String encodedPhrase = java.net.URLEncoder.encode(phrase, "UTF-8");
%>
<script>
  fetch(`http://127.0.0.1:8000/suggestions?phrase=<%= encodedPhrase %>`)
          .then(response => {
            if (!response.ok) {
              throw new Error('Erreur réseau');
            }
            return response.json();
          })
          .then(data => {
            // Nettoyer et formater le texte des suggestions
            let suggestionText = data.solution
                    .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>') // Remplacer **texte** par <strong>texte</strong>
                    .replace(/\*/g, '•') // Remplacer les astérisques par des puces
                    .replace(/\n/g, '<br>'); // Remplacer les sauts de ligne par des balises <br>

            // Afficher le texte formaté
            document.getElementById("suggestion-text").innerHTML = suggestionText;
          })
          .catch(error => {
            console.error("Erreur lors de la récupération des suggestions :", error);
            document.getElementById("suggestion-text").innerText = "Erreur lors de la récupération des suggestions.";
          });
</script>
  <%
} else {
%>
<script>
  document.getElementById("suggestion-text").innerText = "Aucune donnée disponible pour les indicateurs financiers.";
</script>
<%
  }
%>