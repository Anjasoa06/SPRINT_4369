<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Personne" %>

<%
    Personne pers = (Personne) request.getAttribute("personne");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Informations sur la personne</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<h1>Informations sur la personne</h1>

<ul>
    <li>ID: <%= pers.getId() %></li>
    <li>Nom: <%= pers.getNom() %></li>
    <li>Prénom: <%= pers.getPrenom() %></li>
    <li>Email: <%= pers.getEmail() %></li>
</ul>

</body>
</html>