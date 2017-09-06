package main.java;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import main.java.dao.CustomerDAO;
import main.java.jsonview.Views;
import main.java.model.AjaxResponseBody;
import main.java.model.Customer;
import main.java.model.SearchCriteria;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonView;

@Controller 
public class AjaxController {
	   
	    @RequestMapping(value = "/hello", method = RequestMethod.GET)  
		public String printWelcome(ModelMap model) {  
	        model.addAttribute("message", "Hello! This is Spring MVC Web Controller.");  
	        return "output";  
	    }
	    
	    @RequestMapping(value = "/hello/{name:.+}", method = RequestMethod.GET)
		public ModelAndView hello(@PathVariable("name") String name) {

			ModelAndView model = new ModelAndView();
			model.setViewName("hello");
			model.addObject("msg", name);

			return model;

		}
	}
	
