<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<html>
<head>
  <title>Compte de Résultat</title>
  <style>
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
  </style>
</head>
<body>
<h2>Compte de Résultat pour l'année ${annee}</h2>

<table>
  <thead>
  <tr>
    <th>Libellé</th>
    <th>Montant (N)</th>
  </tr>
  </thead>
  <tbody>
  <%
    // Récupérer les données du modèle
    BigDecimal productionExercice = (BigDecimal) request.getAttribute("productionExercice");
    BigDecimal consommationExercice = (BigDecimal) request.getAttribute("consommationExercice");
    BigDecimal valeurAjoutee = (BigDecimal) request.getAttribute("valeurAjoutee");
    BigDecimal ebe = (BigDecimal) request.getAttribute("ebe");
    BigDecimal resultatOperationnel = (BigDecimal) request.getAttribute("resultatOperationnel");
    BigDecimal resultatFinancier = (BigDecimal) request.getAttribute("resultatFinancier");
    BigDecimal resultatAvantImpots = (BigDecimal) request.getAttribute("resultatAvantImpots");
    BigDecimal resultatNetOrdinaire = (BigDecimal) request.getAttribute("resultatNetOrdinaire");
    BigDecimal resultatExtraordinaire = (BigDecimal) request.getAttribute("resultatExtraordinaire");
    BigDecimal resultatNet = (BigDecimal) request.getAttribute("resultatNet");

    if (productionExercice != null) {
  %>
  <tr>
    <td><strong>I- Production de l'exercice</strong></td>
    <td><%= productionExercice.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>II- Consommation de l'exercice</strong></td>
    <td><%= consommationExercice.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>III- Valeur ajoutée d'exploitation</strong></td>
    <td><%= valeurAjoutee.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>IV- Excédent brut d'exploitation (EBE)</strong></td>
    <td><%= ebe.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>V- Résultat opérationnel</strong></td>
    <td><%= resultatOperationnel.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>VI- Résultat financier</strong></td>
    <td><%= resultatFinancier.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>VII- Résultat avant impôts</strong></td>
    <td><%= resultatAvantImpots.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>VIII- Résultat net des activités ordinaires</strong></td>
    <td><%= resultatNetOrdinaire.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>IX- Résultat extraordinaire</strong></td>
    <td><%= resultatExtraordinaire.doubleValue() %></td>
  </tr>
  <tr>
    <td><strong>X- Résultat net de l'exercice</strong></td>
    <td><%= resultatNet.doubleValue() %></td>
  </tr>
  <%
  } else {
  %>
  <tr>
    <td colspan="2">Aucune donnée disponible pour le compte de résultat.</td>
  </tr>
  <%
    }
  %>
  </tbody>
</table>
</body>
</html>