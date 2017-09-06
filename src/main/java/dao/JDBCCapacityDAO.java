package main.java.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import main.java.model.BidArea;
import main.java.model.Region;
import main.java.model.State;

public class JDBCCapacityDAO {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public List<State> getAllStates() {

		String sql = "SELECT * FROM CapacityCea order by state";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			List<State> states = new ArrayList<State>();
			ResultSet rs = ps.executeQuery();
			System.out.println("Entering the datasource");
			System.out.println(sql);
			while (rs.next()) {
				System.out.println("State:" + rs.getString("state"));
				System.out.println(rs.getString("state").length());
				State s = new State(rs.getString("state"), rs.getFloat("res"),
						rs.getFloat("hydro"), rs.getFloat("nuclear"),
						rs.getFloat("coal"), rs.getFloat("gas"),
						rs.getFloat("diesel"), rs.getFloat("misc"));
				states.add(s);
			}
			rs.close();
			ps.close();
			return states;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public List<BidArea> getAllBidAreas() {

		String sql = "SELECT * FROM BidAreaCapacity  where BideaAreaCode is not Null order by BideaAreaCode";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			List<BidArea> bidAreas = new ArrayList<BidArea>();
			ResultSet rs = ps.executeQuery();
			System.out.println("Entering the datasource");
			System.out.println(sql);
			while (rs.next()) {
				System.out.println("State:" + rs.getString("BideaAreaCode"));
				System.out.println(rs.getString("BideaAreaCode").length());
				BidArea area = new BidArea(rs.getString("BideaAreaCode"),
						rs.getFloat("res"), rs.getFloat("hydro"),
						rs.getFloat("nuclear"), rs.getFloat("coal"),
						rs.getFloat("gas"), rs.getFloat("diesel"),
						rs.getFloat("misc"));
				bidAreas.add(area);
			}
			rs.close();
			ps.close();
			return bidAreas;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	public List<Region> getAllRegions() {

		String sql = "SELECT * FROM RegionCapacity  where Region is not Null order by Region";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			List<Region> regions = new ArrayList<Region>();
			ResultSet rs = ps.executeQuery();
			System.out.println("Entering the datasource");
			System.out.println(sql);
			while (rs.next()) {
				System.out.println("State:" + rs.getString("Region"));
				System.out.println(rs.getString("Region").length());
				Region r = new Region(rs.getString("Region"),
						rs.getFloat("res"), rs.getFloat("hydro"),
						rs.getFloat("nuclear"), rs.getFloat("coal"),
						rs.getFloat("gas"), rs.getFloat("diesel"),
						rs.getFloat("misc"));
				regions.add(r);
			}
			rs.close();
			ps.close();
			return regions;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
	public Region getTotalCapacity() {

		String sql = "Select * from TotalCapacity";

		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			Region r=null;
			ResultSet rs = ps.executeQuery();
			System.out.println("Entering the datasource");
			System.out.println(sql);
			while (rs.next()) {
				r = new Region("Total",
						rs.getFloat("res"), rs.getFloat("hydro"),
						rs.getFloat("nuclear"), rs.getFloat("coal"),
						rs.getFloat("gas"), rs.getFloat("diesel"),
						rs.getFloat("misc"));
			}
			rs.close();
			ps.close();
			return r;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				}
			}
		}
	}
	
}