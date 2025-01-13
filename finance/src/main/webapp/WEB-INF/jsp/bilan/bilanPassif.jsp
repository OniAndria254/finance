<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>

<html>
<head>
  <title>Bilan Passif</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
<div class="container">
  <h2>Bilan Passif</h2>
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
            Map<String, Object> categorieMap = (Map<String, Object>) categorieEntry.getValue();
    %>
    <tr>
      <td><strong><%= categorieEntry.getKey() %></strong></td>
      <td><strong><%= categorieMap.get("total") %></strong></td>
    </tr>
    <%
      for (Map.Entry<String, Object> sousCategorieEntry : categorieMap.entrySet()) {
        if (!sousCategorieEntry.getKey().equals("total")) {
          Map<String, Object> sousCategorieMap = (Map<String, Object>) sousCategorieEntry.getValue();
    %>
    <tr>
      <td style="padding-left: 60px;"><%= sousCategorieEntry.getKey() %></td>
      <td><%= sousCategorieMap.get("total") %></td>
    </tr>
    <%
      for (Map.Entry<String, Object> sousSousCategorieEntry : sousCategorieMap.entrySet()) {
        if (!sousSousCategorieEntry.getKey().equals("total")) {
    %>
    <tr>
      <td style="padding-left: 120px;"><%= sousSousCategorieEntry.getKey() %></td>
      <td><%= sousSousCategorieEntry.getValue() %></td>
    </tr>
    <%
                }
              }
            }
          }
        }
      }
    %>
    <tr>
      <td><strong>Total Passif</strong></td>
      <td><strong><%= passifs.get("total") %></strong></td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>