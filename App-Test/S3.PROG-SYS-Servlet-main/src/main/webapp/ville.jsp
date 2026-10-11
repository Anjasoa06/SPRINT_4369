<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>

<% 
    List<String> villes = (List<String>) request.getAttribute("villes");
%>
<!DOCTYPE html>
<html>
<head>
    <title>TEST</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<a href="${pageContext.request.contextPath}/index" class="link-hello"> Retour</a>
<h2>Listes villes : </h2>

<ul>
<%
    if (villes != null) {
        for (String ville : villes) {
%>
    <li><%= ville %></li>
<%
        }
    }
%>
</ul>

</body>
</html>