package main.java.controller;

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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

@RestController
public class AjaxController {

	List<Customer> customers;

	// @ResponseBody, not necessary, since class is annotated with @RestController
	// @RequestBody - Convert the json data into object (SearchCriteria) mapped by field name.
	// @JsonView(Views.Public.class) - Optional, filters json data to display.
	@ResponseBody
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/search/api/getSearchResult", method = RequestMethod.POST)
	public AjaxResponseBody getSearchResultViaAjax(@RequestBody SearchCriteria search) {
		System.out.println("Entering the get result via ajax");
		AjaxResponseBody result = new AjaxResponseBody();

		if (isValidSearchCriteria(search)) {
			List<Customer> customers = findByName(search.getName());

			if (customers.size() > 0) {
				result.setCode("200");
				result.setMsg("");
				result.setResult(customers);
			} else {
				result.setCode("204");
				result.setMsg("No customer!");
			}

		} else {
			result.setCode("400");
			result.setMsg("Search criteria is empty!");
		}

		//AjaxResponseBody will be converted into json format and send back to the request.
		return result;

	}
	
	private boolean isValidSearchCriteria(SearchCriteria search) {

		boolean valid = true;

		if (search == null) {
			valid = false;
		}

		if ((StringUtils.isEmpty(search.getName()))) {
			valid = false;
		}

		return valid;
	}

	// Simulate the search function
	private List<Customer> findByName(String name) {
		ApplicationContext context =
	    		new ClassPathXmlApplicationContext("Spring-Module.xml");
	    CustomerDAO customerDAO = (CustomerDAO) context.getBean("customerDAO");
		List<Customer> result = customerDAO.findByCustomerName(name);
		return result;
	}
	
}
