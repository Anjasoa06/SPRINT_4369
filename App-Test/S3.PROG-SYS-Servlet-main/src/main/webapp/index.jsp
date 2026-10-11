<%@page import="java.io.*"%>
<%@page import="jakarta.servlet.*"%>
<%@page import="jakarta.servlet.http.*"%>
<%@include file="inc/doctype.jsp" %>
<head>
    <title>Servlet Index</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>

<body class="container pt-3">
    <h1>PAGE INDEX <i class="bi bi-unity"></i></h1>
    <h1>ETU 004369 </h1>
    <ul>
        <li><a href="hellowrld.lk" class="link-hello"> lien vers servlet HELLO WORLD! <i class="bi bi-emoji-grin"></i> </a></li>
        <li><a href="test" class="link-hello"> VILLE </a></li>
        <li><a href="home" class="link-hello"> HOME </a></li>
        <h2> cliquer ci dessous pour tester Sprint 7-bis </h2>
        <li><a href="form" class="link-hello"> FORM </a></li>
        <h2> cliquer ci dessous pour tester Sprint 7 </h2>
        <li><a href="form2" class="link-hello"> FORM 2 </a></li>
        
    </ul>
</body>
</html>