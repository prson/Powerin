package main.java.controller;

import java.util.List;

import main.java.dao.CustomerDAO;
import main.java.dao.JDBCCapacityDAO;
import main.java.jsonview.Views;
import main.java.model.BidArea;
import main.java.model.BidAreaResponseBody;
import main.java.model.Customer;
import main.java.model.Region;
import main.java.model.RegionResponseBody;
import main.java.model.SearchCriteria;
import main.java.model.State;
import main.java.model.StateResponseBody;
import main.java.model.TotalCapResponseBody;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

@RestController
public class CapacityController {
	
	@ResponseBody
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/search/api/getStates", method = RequestMethod.POST)
	public StateResponseBody getStates() {
		System.out.println("Entering the get states via ajax");
		StateResponseBody result = new StateResponseBody();

		ApplicationContext context =
	    		new ClassPathXmlApplicationContext("Spring-Module.xml");
	    JDBCCapacityDAO capDAO = (JDBCCapacityDAO) context.getBean("IndiaPowerCapacityDAO");
		List<State> states = capDAO.getAllStates();

			if (states.size() > 0) {
				result.setCode("200");
				result.setMsg("");
				result.setResult(states);
			} else {
				result.setCode("204");
				result.setMsg("No states!");

		} 
		//AjaxResponseBody will be converted into json format and send back to the request.
			System.out.println(result.getResult().get(0).stateName);
			System.out.println(result.getResult().get(0).stateName.length());
		return result;
	}
	
	@ResponseBody
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/search/api/getBidAreas", method = RequestMethod.POST)
	public BidAreaResponseBody getBidAreas() {
		System.out.println("Entering the get bid areas via ajax");
		BidAreaResponseBody result = new BidAreaResponseBody();

		ApplicationContext context =
	    		new ClassPathXmlApplicationContext("Spring-Module.xml");
	    JDBCCapacityDAO capDAO = (JDBCCapacityDAO) context.getBean("IndiaPowerCapacityDAO");
		List<BidArea> bidAreas = capDAO.getAllBidAreas();

			if (bidAreas.size() > 0) {
				result.setCode("200");
				result.setMsg("");
				result.setResult(bidAreas);
			} else {
				result.setCode("204");
				result.setMsg("No states!");

		} 
		//AjaxResponseBody will be converted into json format and send back to the request.
//			System.out.println(result.getResult().get(0).stateName);
//			System.out.println(result.getResult().get(0).stateName.length());
		return result;
	}
	
	@ResponseBody
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/search/api/getRegions", method = RequestMethod.POST)
	public RegionResponseBody getRegions() {
		System.out.println("Entering the get bid areas via ajax");
		RegionResponseBody result = new RegionResponseBody();

		ApplicationContext context =
	    		new ClassPathXmlApplicationContext("Spring-Module.xml");
	    JDBCCapacityDAO capDAO = (JDBCCapacityDAO) context.getBean("IndiaPowerCapacityDAO");
		List<Region> regions = capDAO.getAllRegions();

			if (regions.size() > 0) {
				result.setCode("200");
				result.setMsg("");
				result.setResult(regions);
			} else {
				result.setCode("204");
				result.setMsg("No regions!");

		} 
		return result;
	}
	
	@ResponseBody
	@JsonView(Views.Public.class)
	@RequestMapping(value = "/search/api/getTotalCapacity", method = RequestMethod.POST)
	public TotalCapResponseBody getTotalCapacity() {
		System.out.println("Entering the get bid areas via ajax");
		TotalCapResponseBody result = new TotalCapResponseBody();

		ApplicationContext context =
	    		new ClassPathXmlApplicationContext("Spring-Module.xml");
	    JDBCCapacityDAO capDAO = (JDBCCapacityDAO) context.getBean("IndiaPowerCapacityDAO");
		Region totalCap = capDAO.getTotalCapacity();

			if (totalCap!=null) {
				result.setCode("200");
				result.setMsg("");
				result.setResult(totalCap);
			} else {
				result.setCode("204");
				result.setMsg("No regions!");

		} 
		return result;
	}

}
