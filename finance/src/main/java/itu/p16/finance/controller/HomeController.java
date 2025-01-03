package itu.p16.finance.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @GetMapping("/")
    public ModelAndView afficheLayout() {
        ModelAndView mv = new ModelAndView("layout");
        mv.addObject("page", "test");
        return mv;
    }
}
