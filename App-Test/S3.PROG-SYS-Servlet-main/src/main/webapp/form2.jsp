<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%-- <%@ page import="model.Personne" %> --%>

<!DOCTYPE html>
<html>
<head>
    <title>Formulaire de saisie de la personne</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <a href="${pageContext.request.contextPath}/index" class="link-hello"> Retour</a>
    <h1>Formulaire de personne</h1>
    <form action="form2" method="post">
        <label for="nom">Nom:</label>
        <input type="text" id="nom" name="nom" required><br><br>

        <label for="prenom">Numero</label>
        <input type="number" id="numero" name="numero" required><br><br>

        <input type="submit" value="Enregistrer">
    </form>

</body>
</html>