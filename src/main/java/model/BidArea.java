package main.java.model;

import main.java.jsonview.Views;

import com.fasterxml.jackson.annotation.JsonView;

public class BidArea {
	
	@JsonView(Views.Public.class)
	public String bidAreaCode;
	@JsonView(Views.Public.class)
	public float res;
	@JsonView(Views.Public.class)
	public float hydro;
	@JsonView(Views.Public.class)
	public float nuclear;
	@JsonView(Views.Public.class)
	public float coal;
	@JsonView(Views.Public.class)
	public float gas;
	@JsonView(Views.Public.class)
	public float diesel;
	@JsonView(Views.Public.class)
	public float misc;
	
	public BidArea(String bidAreaCode, float res, float hydro, float nuclear,
			float coal, float gas, float diesel, float misc) {
		super();
		this.bidAreaCode = bidAreaCode;
		this.res = res;
		this.hydro = hydro;
		this.nuclear = nuclear;
		this.coal = coal;
		this.gas = gas;
		this.diesel = diesel;
		this.misc = misc;
	}

	public String getBidAreaName() {
		return bidAreaCode;
	}

	public void setStateName(String bidAreaName) {
		this.bidAreaCode = bidAreaName;
	}
	
	

}
