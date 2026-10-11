<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Personne" %>

<%
    List<Personne> personnes = (List<Personne>) request.getAttribute("personnes");
    Integer total = (Integer) request.getAttribute("total");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Personnes</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<a href="${pageContext.request.contextPath}/index" class="link-hello"> Retour</a>
<h1>Liste des personnes (<%= total %>)</h1>

<table border="1" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
    </tr>
    <%
        if (personnes != null) {
            for (Personne p : personnes) {
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getNom() %></td>
        <td><%= p.getPrenom() %></td>
        <td><%= p.getEmail() %></td>
    </tr>
    <%
            }
        }
    %>
</table>

</body>
</html>