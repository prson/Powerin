<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/site.css" type="text/css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/d3/4.7.2/d3.min.js"></script>
<script src="scripts/d3pie.min.js"></script>
<script type="text/javascript">

	jQuery(document).ready(function($) {
		getStates();
		getBidAreas();
		getRegions();
		rsvpEvent(3, 4);
	});

	function rsvpEvent(rsvp, id) {
		var dataStates;
		if (id == 1) {
			document.getElementById("selectState").style.display = 'inline-block';
			document.getElementById("selectBidArea").style.display = 'none';
			document.getElementById("selectRegion").style.display = 'none';
			$('#canvas').remove();
		} else if (id == 2) {
			getBidAreas();
			document.getElementById("selectState").style.display = 'none';
			document.getElementById("selectBidArea").style.display = 'inline-block';
			document.getElementById("selectRegion").style.display = 'none';
			$('#canvas').remove();
		} else if (id == 3) {
			getRegions();
			document.getElementById("selectState").style.display = 'none';
			document.getElementById("selectBidArea").style.display = 'none';
			document.getElementById("selectRegion").style.display = 'inline-block';
			$('#canvas').remove();
		} else if (id == 0) {
			document.getElementById("selectState").style.display = 'none';
			document.getElementById("selectBidArea").style.display = 'none';
			document.getElementById("selectRegion").style.display = 'none';
			$('#canvas').remove();
		}
		else if (id == 4) {
			document.getElementById("selectState").style.display = 'inline-block';
			document.getElementById("selectBidArea").style.display = 'inline-block';
			document.getElementById("selectRegion").style.display = 'inline-block';
		}
	}
	
	function getBidAreas() {
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "${home}rest/search/api/getBidAreas",
			data : null,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				dataStates = data;
				console.log("SUCCESS: ", data);
				displayBidAreaData(data);
			},
			error : function(e) {
				console.log("ERROR: ", e);
				display(e);
			},
			done : function(e) {
				console.log("DONE");
				enableSearchButton(true);
			}
		});
	}
	
	function getRegions() {
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "${home}rest/search/api/getRegions",
			data : null,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				dataStates = data;
				console.log("SUCCESS: ", data);
				displayRegionData(data);
			},
			error : function(e) {
				console.log("ERROR: ", e);
				display(e);
			},
			done : function(e) {
				console.log("DONE");
				enableSearchButton(true);
			}
		});
	}

	function getStates() {
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "${home}rest/search/api/getStates",
			data : null,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				dataStates = data;
				console.log("SUCCESS: ", data);
				displayStatesData(data);
			},
			error : function(e) {
				console.log("ERROR: ", e);
				display(e);
			},
			done : function(e) {
				console.log("DONE");
				enableSearchButton(true);
			}
		});
	}

	function displayStatesData(data) {
		if (data.result != null) {
			var text = '';
			for (var i = 0; i < data.result.length; i++) {
				text += '<div><input type="radio" name="loadcapBy" value="State" onclick="displayStateCapacity(\''
						+ data.result[i]["stateName"]
						+ '\','
						+ data.result[i]["res"]
						+ ','
						+ data.result[i]["hydro"]
						+ ','
						+ data.result[i]["nuclear"]
						+ ','
						+ data.result[i]["coal"]
						+ ','
						+ data.result[i]["gas"]
						+ ','
						+ data.result[i]["diesel"]
						+ ','
						+ data.result[i]["misc"]
						+ ');">'
						+ data.result[i]["stateName"]+'</div>';
			}
			document.getElementById("radioInputStates").innerHTML = text;
		}
	}
	
	function displayBidAreaData(data) {
		if (data.result != null) {
			var text = '';
			for (var i = 0; i < data.result.length; i++) {
				text += '<div><input type="radio" name="loadcapBy" value="State" onclick="displayBidAreaCapacity(\''
						+ data.result[i]["bidAreaCode"]
						+ '\','
						+ data.result[i]["res"]
						+ ','
						+ data.result[i]["hydro"]
						+ ','
						+ data.result[i]["nuclear"]
						+ ','
						+ data.result[i]["coal"]
						+ ','
						+ data.result[i]["gas"]
						+ ','
						+ data.result[i]["diesel"]
						+ ','
						+ data.result[i]["misc"]
						+ ');">'
						+ data.result[i]["bidAreaCode"]+'</div>';
			}
			document.getElementById("radioInputBidArea").innerHTML = text;
		}
	}
	
	function displayRegionData(data) {
		if (data.result != null) {
			var text = '';
			for (var i = 0; i < data.result.length; i++) {
				text += '<div><input type="radio" name="loadcapBy" value="State" onclick="displayRegionCapacity(\''
						+ data.result[i]["regionName"]
						+ '\','
						+ data.result[i]["res"]
						+ ','
						+ data.result[i]["hydro"]
						+ ','
						+ data.result[i]["nuclear"]
						+ ','
						+ data.result[i]["coal"]
						+ ','
						+ data.result[i]["gas"]
						+ ','
						+ data.result[i]["diesel"]
						+ ','
						+ data.result[i]["misc"]
						+ ');">'
						+ data.result[i]["regionName"]+'</div>';
			}
			document.getElementById("radioInputRegion").innerHTML = text;
		}
	}

	function displayStateCapacity(statename, res, hydro, nuclear, coal, gas, diesel,
			others) {
		if (statename != null) {
			
			var totalCap=res+hydro+nuclear+coal+gas+diesel+others;
			var table = "<thead><th>Source</th><th>Renewable</th><th>Hydro</th><th>Nuclear</th><th>Coal</th><th>Gas</th><th>Diesel</th><th>Others</th><th>Total</th></thead><tbody><tr><td>Capacity (MW)</td>"
				table += "<td>" + res
				+ "</td><td>" + hydro
				+ "</td><td>" + nuclear
				+ "</td><td>" + coal
				+ "</td><td>" + gas
				+ "</td><td>" + diesel
				+ "</td><td>" + others
				+ "</td><th>" + totalCap
				+ "</th></tr>"
				table += "</tbody>";
				document.getElementsByName("table1")[0].innerHTML = table;
			
			
			
			$('#canvasState').remove(); // this is my <canvas> element
			$('#canvasStateContainer').append('<canvas id="canvasState" class="canvas"><canvas>');

			var canvas = document.getElementById("canvasState");
			var ctx = canvas.getContext("2d");
			var myChart = new Chart(ctx,
					{
						type : 'doughnut',
						data : {
							labels : [ "RES", "Hydro", "Nuclear", "Coal",
									"Gas", "Diesel", "Others" ],
							datasets : [ {
								backgroundColor : [ "#2ecc71", "#3498db",
										"#95a5a6", "#9b59b6", "#f1c40f",
										"#e74c3c", "#34495e" ],
								data : [ res, hydro, nuclear, coal, gas,
										diesel, others ]
							}]
						},
						options : {
							title:{
								display: true,
								text: statename,
							},
						}
					});
			
			google.charts.load("current", {packages:["corechart"]});
		      google.charts.setOnLoadCallback(drawChart);
		      function drawChart() {
		        var data = google.visualization.arrayToDataTable([
		          ['Source', 'Capacity'],
		          ['RES',     11],
		          ['Hydro',      2],
		          ['Nuclear',  2],
		          ['Coal', 2],
		          ['Gas',    7],
		          ['Diesel',      2],
		          ['Others',  2]
		        ]);

		        var options = {
		          title: 'Capacity by Source ('+statename+')',
		          tooltip: { trigger: 'none' },
		          pieHole: 0.4,
		        };

		    var chart = new google.visualization.PieChart(document.getElementById('stateGoogleChart'));
// 		   chart.draw(data, options);
		      }
		}
	}
	
	function displayBidAreaCapacity(statename, res, hydro, nuclear, coal, gas, diesel,
			others) {
		if (statename != null) {
			var totalCap=res+hydro+nuclear+coal+gas+diesel+others;
			var table = "<thead><th>Source</th><th>Renewable</th><th>Hydro</th><th>Nuclear</th><th>Coal</th><th>Gas</th><th>Diesel</th><th>Others</th><th>Total</th></thead><tbody><tr><td>Capacity (MW)</td>"
				table += "<td>" + res
				+ "</td><td>" + hydro
				+ "</td><td>" + nuclear
				+ "</td><td>" + coal
				+ "</td><td>" + gas
				+ "</td><td>" + diesel
				+ "</td><td>" + others
				+ "</td><th>" + totalCap
				+ "</th></tr>"
				table += "</tbody>";
				document.getElementsByName("tableBidArea")[0].innerHTML = table;
			
			
			$('#canvasBA').remove(); // this is my <canvas> element
			$('#canvasBAContainer').append('<canvas id="canvasBA" class="canvas"><canvas>');

			var canvas = document.getElementById("canvasBA");
			var ctx = canvas.getContext("2d");
			var myChart = new Chart(ctx,
					{
						type : 'pie',
						data : {
							labels : [ "RES", "Hydro", "Nuclear", "Coal",
									"Gas", "Diesel", "Others" ],
							datasets : [ {
								backgroundColor : [ "#2ecc71", "#3498db",
										"#95a5a6", "#9b59b6", "#f1c40f",
										"#e74c3c", "#34495e" ],
								data : [ res, hydro, nuclear, coal, gas,
										diesel, others ]
							} ]
						},
						options : {
							title:{
								display: true,
								text: 'Area ' + statename,
							},
						}
					});
		}
	}
	
	function displayRegionCapacity(statename, res, hydro, nuclear, coal, gas, diesel,
			others) {
		if (statename != null) {
			
			var totalCap=res+hydro+nuclear+coal+gas+diesel+others;
			var table = "<thead><th>Source</th><th>Renewable</th><th>Hydro</th><th>Nuclear</th><th>Coal</th><th>Gas</th><th>Diesel</th><th>Others</th><th>Total</th></thead><tbody><tr><td>Capacity (MW)</td>"
				table += "<td>" + res
				+ "</td><td>" + hydro
				+ "</td><td>" + nuclear
				+ "</td><td>" + coal
				+ "</td><td>" + gas
				+ "</td><td>" + diesel
				+ "</td><td>" + others
				+ "</td><th>" + totalCap
				+ "</th></tr>"
				table += "</tbody>";
				document.getElementsByName("tableRegion")[0].innerHTML = table;
				
				
			$('#canvasRegion').remove(); // this is my <canvas> element
			$('#canvasRegionContainer').append('<canvas id="canvasRegion" class="canvas"><canvas>');

			var canvas = document.getElementById("canvasRegion");
			var ctx = canvas.getContext("2d");
			var myChart = new Chart(ctx,
					{
						type : 'pie',
						data : {
							labels : [ "RES", "Hydro", "Nuclear", "Coal",
									"Gas", "Diesel", "Others" ],
							datasets : [ {
								backgroundColor : [ "#2ecc71", "#3498db",
										"#95a5a6", "#9b59b6", "#f1c40f",
										"#e74c3c", "#34495e" ],
								data : [ res, hydro, nuclear, coal, gas,
										diesel, others ]
							} ]
						},
						options : {
							title:{
								display: true,
								text: statename + ' Region',
							},
						}
					});
		}
	}
	
</script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Capacity in India</title>
</head>
<body>
	<%@include file="tabs.jsp"%>
<!-- 	<form> -->
<!-- 		<div class="form-group form-group-lg"> -->
<!-- 			<label class="col-sm-2 control-label">Load capacity by</label> -->
<!-- 			<div class="col-sm-10"> -->
<!-- 				<input type="radio" name="loadcapBy" value="State" -->
<!-- 					onclick="rsvpEvent(3, 4);"> State<br> <input -->
<!-- 					type="radio" name="loadcapBy" value="Bid Area" -->
<!-- 					onclick="rsvpEvent(3, 4);"> Bid Area<br> <input -->
<!-- 					type="radio" name="loadcapBy" value="Region" -->
<!-- 					onclick="rsvpEvent(3, 4);"> Region<br> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</form> -->
	<div class="category-group" id="StateGroup">
	<div style="clear:both; font-size:0px;"></div>
		<form>
		<div class="form-group" id="selectState">
			<label class="col-sm-2 control-label">States</label>
			<div type="states" class="col-sm-10" id="radioInputStates"></div>
			<div class="capacityTablesWrap"><table name="table1" class="capacityTables" id="stateCapacityTable"></table></div>
		</div>
		</form>
		<div class="canvasContainer" id="canvasStateContainer">
		<canvas id="canvasState"></canvas>
		</div>
		<div class="canvasContainer" id="stateGoogleChart"></div>
	</div>
	<div style="clear:both; font-size:0px;"></div>
	
	<div class="category-group" id="BidAreaGroup">
	<div style="clear:both; font-size:0px;"></div>
		<form>
		<div class="form-group" id="selectBidArea">
		<label class="col-sm-2 control-label">Bid Areas</label>
		<div type="bidArea" class="col-sm-10" id="radioInputBidArea"></div>
		<div class="capacityTablesWrap"><table name="tableBidArea" class="capacityTables" id="stateCapacityTable"></table></div>
		</div>
		</form>
		<div class="canvasContainer" id="canvasBAContainer">
		<canvas id="canvasBA"></canvas>
		</div>
		
	</div>
	<div style="clear:both; font-size:0px;"></div>
	<div class="category-group" id="RegionGroup">
			<div style="clear:both; font-size:0px;"></div>
			<form>
			<div class="form-group" id="selectRegion">
			<label class="col-sm-2 control-label">Regions</label>
			<div type="region" class="col-sm-10" id="radioInputRegion"></div>
			<div class="capacityTablesWrap"><table name="tableRegion" class="capacityTables" id="stateCapacityTable"></table></div>
		</div>
			</form>
			
		<div class="canvasContainer" id="canvasRegionContainer">
		<canvas id="canvasRegion"></canvas>
		</div>
	</div>
	<div style="clear:both; font-size:0px;"></div>
	<%@include file="footer.jsp"%>
</body>
</html>