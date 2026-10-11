import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import mg.itu.myframework.annotation.Controller;

@Controller
public class HelloWorld extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();
        out.println("<HTML>");
        out.println("<HEAD>    <meta charset=\"UTF-8\">\n" + //
                        "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" + //
                        "    <title>Document</title>\n" + //
                        "    <link href=\"assets/css/bootstrap/bootstrap.min.css\" rel=\"stylesheet\">\n" + //
                        "    <link href=\"assets/icons/bootstrap-icons.min.css\" rel=\"stylesheet\">\n" + //
                        "    <link href=\"assets/css/styles.css\" rel=\"stylesheet\">\n" + //
                        "    <script src=\"assets/css/bootstrap/bootstrap.bundle.js\"></script>\n" + //
                        "<TITLE>Bonjour tout le monde</TITLE></HEAD>");
        out.println("<BODY class=\"container pt-3\">");
        out.println("<H1 class=\"text-center\">Bonjour tout le monde <i class=\"bi bi-person-raised-hand\"></i></H1>");
        out.println("</BODY></HTML>");
    }

    public HelloWorld(){

    }
}
