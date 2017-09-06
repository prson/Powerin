package main.java.model;

import java.util.List;

import main.java.jsonview.Views;

import com.fasterxml.jackson.annotation.JsonView;

public class BidAreaResponseBody {
	@JsonView(Views.Public.class)
	String msg;

	@JsonView(Views.Public.class)
	String code;

	@JsonView(Views.Public.class)
	List<BidArea> result;

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

	public List<BidArea> getResult() {
		return result;
	}

	public void setResult(List<BidArea> result) {
		this.result = result;
	}
	
	
}
