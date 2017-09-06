package main.java.model;

import main.java.jsonview.Views;

import com.fasterxml.jackson.annotation.JsonView;

public class TotalCapResponseBody {

	@JsonView(Views.Public.class)
	String msg;

	@JsonView(Views.Public.class)
	String code;

	@JsonView(Views.Public.class)
	Region result;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Region getResult() {
		return result;
	}

	public void setResult(Region result) {
		this.result = result;
	}
	
}
