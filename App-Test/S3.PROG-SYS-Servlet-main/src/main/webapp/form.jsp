<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
       <head>
              <title>Formulaire de saisie de la personne</title>
              <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
       </head>

       <body>

              <h1>Formulaire de saisie de la personne</h1>
              <a href="${pageContext.request.contextPath}/index" class="link-hello"> Retour</a>
              <form action="${pageContext.request.contextPath}/save" method="post">

                     <label for="nom">Nom:</label>
                     <input type="text"
                     id="nom"
                     name="nom"
                     required>

                     <br><br>

                     <label for="prenom">Prénom:</label>
                     <input type="text"
                     id="prenom"
                     name="prenom"
                     required>

                     <br><br>

                     <label for="email">Email:</label>
                     <input type="email"
                     id="email"
                     name="email"
                     required>

                     <br><br>

                     <input type="submit"
                     value="Enregistrer">

              </form>

       </body>
</html>