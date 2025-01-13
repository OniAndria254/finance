<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.math.BigDecimal" %>

<div class="container">
  <h2>Bilan de ${entreprise} pour l'année ${annee}</h2>
  <br>

  <!-- Afficher l'alerte si les totaux ne sont pas égaux -->
  <%
    String alertMessage = (String) request.getAttribute("alertMessage");
    if (alertMessage != null) {
  %>
  <div class="alert alert-danger" role="alert">
    <%= alertMessage %>
  </div>
  <%
    }
  %>

  <!-- Section Actif -->
  <h4>Bilan ACTIF</h4>
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Actif</th>
      <th>Montant (N Net)</th>
    </tr>
    </thead>
    <tbody>
    <%
      Map<String, Object> actifs = (Map<String, Object>) request.getAttribute("actifs");
      if (actifs != null) {
        for (Map.Entry<String, Object> categorieEntry : actifs.entrySet()) {
          if (!categorieEntry.getKey().equals("total")) {
            Object categorieValue = categorieEntry.getValue();
            if (categorieValue instanceof Map) {
              Map<String, Object> categorieMap = (Map<String, Object>) categorieValue;
    %>
    <tr>
      <td><strong><%= categorieEntry.getKey() %></strong></td>
      <td><strong><%= ((BigDecimal) categorieMap.get("total")).doubleValue() %></strong></td>
    </tr>
    <%
      for (Map.Entry<String, Object> sousCategorieEntry : categorieMap.entrySet()) {
        if (!sousCategorieEntry.getKey().equals("total")) {
          Object sousCategorieValue = sousCategorieEntry.getValue();
          if (sousCategorieValue instanceof Map) {
            Map<String, Object> sousCategorieMap = (Map<String, Object>) sousCategorieValue;
    %>
    <tr>
      <td style="padding-left: 60px;"><%= sousCategorieEntry.getKey() %></td>
      <td><%= ((BigDecimal) sousCategorieMap.get("total")).doubleValue() %></td>
    </tr>
    <%
      for (Map.Entry<String, Object> sousSousCategorieEntry : sousCategorieMap.entrySet()) {
        if (!sousSousCategorieEntry.getKey().equals("total")) {
          Object sousSousCategorieValue = sousSousCategorieEntry.getValue();
          if (sousSousCategorieValue instanceof BigDecimal) {
    %>
    <tr>
      <td style="padding-left: 120px;"><%= sousSousCategorieEntry.getKey() %></td>
      <td><%= ((BigDecimal) sousSousCategorieValue).doubleValue() %></td>
    </tr>
    <%
    } else if (sousSousCategorieValue instanceof Map) {
      // Si la valeur est une Map, ignorer ou afficher un message
    %>
    <tr>
      <td style="padding-left: 120px;"><%= sousSousCategorieEntry.getKey() %></td>
      <td>N/A (Structure complexe)</td>
    </tr>
    <%
          }
        }
      }
    } else if (sousCategorieValue instanceof BigDecimal) {
      // Si la valeur est un BigDecimal, l'afficher directement
    %>
    <tr>
      <td style="padding-left: 60px;"><%= sousCategorieEntry.getKey() %></td>
      <td><%= ((BigDecimal) sousCategorieValue).doubleValue() %></td>
    </tr>
    <%
          }
        }
      }
    } else if (categorieValue instanceof BigDecimal) {
      // Si la valeur est un BigDecimal, l'afficher directement
    %>
    <tr>
      <td><strong><%= categorieEntry.getKey() %></strong></td>
      <td><strong><%= ((BigDecimal) categorieValue).doubleValue() %></strong></td>
    </tr>
    <%
          }
        }
      }
    %>
    <tr>
      <td><strong>Total Actif</strong></td>
      <td><strong><%= ((BigDecimal) actifs.get("total")).doubleValue() %></strong></td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>

  <hr>
  <hr>
  <!-- Section Passif -->
  <h4>Bilan CAPITAUX PROPRES ET PASSIFS</h4>
  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Passif</th>
      <th>Montant (N Net)</th>
    </tr>
    </thead>
    <tbody>
    <%
      Map<String, Object> passifs = (Map<String, Object>) request.getAttribute("passifs");
      if (passifs != null) {
        for (Map.Entry<String, Object> categorieEntry : passifs.entrySet()) {
          if (!categorieEntry.getKey().equals("total")) {
            Object categorieValue = categorieEntry.getValue();
            if (categorieValue instanceof Map) {
              Map<String, Object> categorieMap = (Map<String, Object>) categorieValue;
    %>
    <tr>
      <td><strong><%= categorieEntry.getKey() %></strong></td>
      <td><strong><%= ((BigDecimal) categorieMap.get("total")).doubleValue() %></strong></td>
    </tr>
    <%
      for (Map.Entry<String, Object> sousCategorieEntry : categorieMap.entrySet()) {
        if (!sousCategorieEntry.getKey().equals("total")) {
          Object sousCategorieValue = sousCategorieEntry.getValue();
          if (sousCategorieValue instanceof Map) {
            Map<String, Object> sousCategorieMap = (Map<String, Object>) sousCategorieValue;
    %>
    <tr>
      <td style="padding-left: 60px;"><%= sousCategorieEntry.getKey() %></td>
      <td><%= ((BigDecimal) sousCategorieMap.get("total")).doubleValue() %></td>
    </tr>
    <%
      for (Map.Entry<String, Object> sousSousCategorieEntry : sousCategorieMap.entrySet()) {
        if (!sousSousCategorieEntry.getKey().equals("total")) {
          Object sousSousCategorieValue = sousSousCategorieEntry.getValue();
          if (sousSousCategorieValue instanceof BigDecimal) {
    %>
    <tr>
      <td style="padding-left: 120px;"><%= sousSousCategorieEntry.getKey() %></td>
      <td><%= ((BigDecimal) sousSousCategorieValue).doubleValue() %></td>
    </tr>
    <%
    } else if (sousSousCategorieValue instanceof Map) {
      // Si la valeur est une Map, ignorer ou afficher un message
    %>
    <tr>
      <td style="padding-left: 120px;"><%= sousSousCategorieEntry.getKey() %></td>
      <td>N/A (Structure complexe)</td>
    </tr>
    <%
          }
        }
      }
    } else if (sousCategorieValue instanceof BigDecimal) {
      // Si la valeur est un BigDecimal, l'afficher directement
    %>
    <tr>
      <td style="padding-left: 60px;"><%= sousCategorieEntry.getKey() %></td>
      <td><%= ((BigDecimal) sousCategorieValue).doubleValue() %></td>
    </tr>
    <%
          }
        }
      }
    } else if (categorieValue instanceof BigDecimal) {
      // Si la valeur est un BigDecimal, l'afficher directement
    %>
    <tr>
      <td><strong><%= categorieEntry.getKey() %></strong></td>
      <td><strong><%= ((BigDecimal) categorieValue).doubleValue() %></strong></td>
    </tr>
    <%
          }
        }
      }
    %>
    <tr>
      <td><strong>Total Passif</strong></td>
      <td><strong><%= ((BigDecimal) passifs.get("total")).doubleValue() %></strong></td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>