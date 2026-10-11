package controller;

import mg.itu.myframework.annotation.UrlMapping;

public class B {
    
    @UrlMapping(url = "/b-home",method = "GET")
    public String home(){
        return "Home";
    }

    @UrlMapping(url = "/b-about",method = "GET")
    public String about(){
        return "About";
    }
}
