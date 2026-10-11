package controller;

import java.util.List;

import org.springframework.context.ApplicationContext;

import mg.itu.myframework.annotation.Controller;
import mg.itu.myframework.annotation.UrlMapping;
import mg.itu.myframework.annotation.WebApi;
import mg.itu.myframework.model.ModelAndView;

import model.Personne;
import service.PersonneService;

@Controller
public class TestController {

    @WebApi
    @UrlMapping(url = "/hi", method = "GET")
    public String hello() {
        return "{\"message\":\"Bonjour depuis mon API\"}";
    }

    @UrlMapping(url = "/test", method = "GET")
    public ModelAndView test1() {

        ModelAndView mv
                = new ModelAndView("ville");

        List<String> villes
                = List.of(
                        "Antananarivo",
                        "Toamasina"
                );

        mv.addObject("villes", villes);

        return mv;
    }

    @UrlMapping(url = "/test", method = "POST")
    public void test3() {

        System.out.println(
                "------\nCeci est une methode test POST\n"
        );
    }

    @UrlMapping(url = "/home")
    public ModelAndView home(ApplicationContext ctx) {

        PersonneService service
                = ctx.getBean(PersonneService.class);

        List<Personne> personnes
                = service.findAll();

        ModelAndView mv
                = new ModelAndView("home");

        mv.addObject(
                "personnes",
                personnes
        );

        mv.addObject(
                "total",
                personnes.size()
        );

        return mv;
    }

    @WebApi
    @UrlMapping(url = "/save", method = "POST")
    public Personne saveApi(ApplicationContext ctx, Personne personne) {
        PersonneService service = ctx.getBean(PersonneService.class);
        return service.save(personne);
    }

//     @UrlMapping(url = "/save", method = "POST")
//     public ModelAndView save(ApplicationContext ctx, Personne personne) {
//         PersonneService service = ctx.getBean(PersonneService.class);
//         Personne personneSave = service.save(personne);

//         ModelAndView mv = new ModelAndView("fiche");
//         mv.addObject("personne", personneSave);
//         return mv;
//     }

    @UrlMapping(url = "/form")
    public ModelAndView form() {

        return new ModelAndView("form");
    }

    @WebApi
    @UrlMapping(url = "/form2", method = "POST")
    public String testPost(
            String nom,
            Integer numero) {

        return "nom est "
                + nom
                + " et est numero "
                + numero;
    }

    @UrlMapping(url = "/form2")
    public ModelAndView form2() {

        return new ModelAndView("form2");
    }

     @UrlMapping(url = "/index")
    public ModelAndView index() {

        return new ModelAndView("index");
    }
}
