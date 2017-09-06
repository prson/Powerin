package main.java.model;

import main.java.jsonview.Views;

import com.fasterxml.jackson.annotation.JsonView;

public class State {
	
	@JsonView(Views.Public.class)
	public String stateName;
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
	
	

	public State(String stateName, float res, float hydro, float nuclear,
			float coal, float gas, float diesel, float misc) {
		super();
		this.stateName = stateName;
		this.res = res;
		this.hydro = hydro;
		this.nuclear = nuclear;
		this.coal = coal;
		this.gas = gas;
		this.diesel = diesel;
		this.misc = misc;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
	
	

}
