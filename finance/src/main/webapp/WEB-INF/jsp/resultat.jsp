<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Résultats Financiers</title>
</head>
<body>
    <h1>Résultats Financiers</h1>
    <table>
        <tr>
            <td>Production de l'exercice:</td>
            <td><%=request.getAttribute("resultats.productionExercice")%></td>
        </tr>
        <tr>
            <td>Consommation de l'exercice:</td>
            <td><%=request.getAttribute("resultats.consommationExercice")%></td>
        </tr>
        <tr>
            <td>Valeur Ajoutée:</td>
            <td><%=request.getAttribute("resultats.valeurAjoutee")%></td>
        </tr>
        <tr>
            <td>EBE:</td>
            <td><%=request.getAttribute("resultats.ebe")%></td>
        </tr>
        <tr>
            <td>Résultat Opérationnel:</td>
            <td><%=request.getAttribute("resultats.resultatOperationnel")%></td>
        </tr>
        <tr>
            <td>Résultat Financier:</td>
            <td><%=request.getAttribute("resultats.resultatFinancier")%></td>
        </tr>
        <tr>
            <td>Résultat Avant Impôts:</td>
            <td><%=request.getAttribute("resultats.resultatAvantImpots")%></td>
        </tr>
        <tr>
            <td>Résultat Net Ordinaire:</td>
            <td><%=request.getAttribute("resultats.resultatNetOrdinaire")%></td>
        </tr>
        <tr>
            <td>Résultat Extraordinaire:</td>
            <td><%=request.getAttribute("resultats.resultatExtraordinaire")%></td>
        </tr>
        <tr>
            <td>Résultat Net:</td>
            <td><%=request.getAttribute("resultats.resultatNet")%></td>
        </tr>
    </table>
</body>
</html>
