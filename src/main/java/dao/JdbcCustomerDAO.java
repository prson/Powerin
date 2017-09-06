package main.java.dao;

import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import main.java.model.Customer;

public class JdbcCustomerDAO implements CustomerDAO{

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void insert(Customer customer){

		String sql = "INSERT INTO CUSTOMER " +
				"(CUST_ID, NAME, AGE) VALUES (?, ?, ?)";
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, customer.getCustId());
			ps.setString(2, customer.getName());
			ps.setInt(3, customer.getAge());
			ps.executeUpdate();
			ps.close();

		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {}
			}
		}
	}

	public Customer findByCustomerId(int custId){

		String sql = "SELECT * FROM CUSTOMER WHERE CUST_ID = ?";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, custId);
			Customer customer = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				customer = new Customer(
					rs.getInt("CUST_ID"),
					rs.getString("NAME"),
					rs.getInt("Age")
				);
			}
			rs.close();
			ps.close();
			return customer;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
	}
	
	public List<Customer> findByCustomerName(String custName){

		String sql = "SELECT * FROM CUSTOMER WHERE NAME = ?";

		Connection conn = null;

		try {
			System.out.println("Searching for the customer "+custName);
			
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, custName);
			System.out.println(ps.toString());
			List<Customer> customers= new ArrayList<Customer>();
			Customer customer=null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				customer = new Customer(
					rs.getInt("CUST_ID"),
					rs.getString("NAME"),
					rs.getInt("Age")
				);
				System.out.println(rs.getInt("CUST_ID"));
				customers.add(customer);
			}
			rs.close();
			ps.close();
			return customers;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
	}
}
