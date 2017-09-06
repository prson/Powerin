package main.java.dao;

import java.util.ArrayList;
import java.util.List;

import main.java.model.Customer;


public interface CustomerDAO {
	
		public void insert(Customer customer);
		public Customer findByCustomerId(int custId);
		public List<Customer> findByCustomerName(String custName);
	}

