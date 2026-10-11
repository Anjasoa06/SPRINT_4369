package controller;

import mg.itu.myframework.annotation.Controller;
import mg.itu.myframework.annotation.UrlMapping;
import java.util.List;

@Controller
public class C {
  
    @UrlMapping(url = "/andrana" , method = "GET")
    public void andrana1(){
        System.out.println("------\nMethode andrana GET\n");
    }

    // @UrlMapping(url = "/test")
    // public void test1(){
    //     System.out.println("------\nCeci est une methode test GET\n");

    // }

    @UrlMapping(url = "/hello" , method = "GET")
    public void andrana2(){
        System.out.println("------\nMethode andrana POST\n");
    }

    @UrlMapping(url = "/list")
    public List<String> getAll(){
        System.out.println("------\nMethode getAll\n");
        return List.of("Item 1", "Item 2", "Item 3");
    }

}
