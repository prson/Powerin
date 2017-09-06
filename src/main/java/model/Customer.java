package main.java.model;

import main.java.jsonview.Views;

import com.fasterxml.jackson.annotation.JsonView;

public class Customer {
	
		@JsonView(Views.Public.class)
		int custId;
		
		@JsonView(Views.Public.class)
		String name;
		@JsonView(Views.Public.class)
		int age;
		
		
		public Customer(int custId, String name, int age) {
			super();
			this.custId = custId;
			this.name = name;
			this.age = age;
		}
		/**
		 * @return the custId
		 */
		public int getCustId() {
			return custId;
		}
		/**
		 * @param custId the custId to set
		 */
		public void setCustId(int custId) {
			this.custId = custId;
		}
		/**
		 * @return the name
		 */
		public String getName() {
			return name;
		}
		/**
		 * @param name the name to set
		 */
		public void setName(String name) {
			this.name = name;
		}
		/**
		 * @return the age
		 */
		public int getAge() {
			return age;
		}
		/**
		 * @param age the age to set
		 */
		public void setAge(int age) {
			this.age = age;
		}
		


}
