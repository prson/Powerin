package main.java.model;

import main.java.jsonview.Views;

import com.fasterxml.jackson.annotation.JsonView;

public class Region {
	
	@JsonView(Views.Public.class)
	public String regionName;
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
	
	public Region(String regionName, float res, float hydro, float nuclear,
			float coal, float gas, float diesel, float misc) {
		super();
		this.regionName = regionName;
		this.res = res;
		this.hydro = hydro;
		this.nuclear = nuclear;
		this.coal = coal;
		this.gas = gas;
		this.diesel = diesel;
		this.misc = misc;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

}
