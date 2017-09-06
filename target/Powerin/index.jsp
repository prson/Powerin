<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/site.css" type="text/css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/d3/4.7.2/d3.min.js"></script>
<script src="scripts/d3pie.js"></script>
<script>

$(document).ready(function(){
	getTotalCapacity();
	jQuery(document).ready(function($) {
		$("#search-form").submit(function(event) {
			// Disble the search button
			enableSearchButton(false);
			// Prevent the form from submitting via the browser.
			event.preventDefault();
			searchViaAjax();
		});

	});
});

// Chart.pluginService.register({
// 	  beforeRender: function (chart) {
// 	    if (chart.config.options.showAllTooltips) {
// 	        // create an array of tooltips
// 	        // we can't use the chart tooltip because there is only one tooltip per chart
// 	        chart.pluginTooltips = [];
// 	        chart.config.data.datasets.forEach(function (dataset, i) {
// 	            chart.getDatasetMeta(i).data.forEach(function (sector, j) {
// 	                chart.pluginTooltips.push(new Chart.Tooltip({
// 	                    _chart: chart.chart,
// 	                    _chartInstance: chart,
// 	                    _data: chart.data,
// 	                    _options: chart.options.tooltips,
// 	                    _active: [sector]
// 	                }, chart));
// 	            });
// 	        });

// 	        // turn off normal tooltips
// 	        chart.options.tooltips.enabled = false;
// 	    }
// 	},
// 	  afterDraw: function (chart, easing) {
// 	    if (chart.config.options.showAllTooltips) {
// 	        // we don't want the permanent tooltips to animate, so don't do anything till the animation runs atleast once
// 	        if (!chart.allTooltipsOnce) {
// 	            if (easing !== 1)
// 	                return;
// 	            chart.allTooltipsOnce = true;
// 	        }

// 	        // turn on tooltips
// 	        chart.options.tooltips.enabled = true;
// 	        Chart.helpers.each(chart.pluginTooltips, function (tooltip) {
// 	            tooltip.initialize();
// 	            tooltip.update();
// 	            // we don't actually need this since we are not animating tooltips
// 	            tooltip.pivot();
// 	            tooltip.transition(easing).draw();
// 	        });
// 	        chart.options.tooltips.enabled = false;
// 	    }
// 	  }
// 	});



	function displayTotalCapacity(data) {
	var totalCapJs=data.result;
		var totalCap=totalCapJs.res+totalCapJs.hydro+totalCapJs.nuclear+totalCapJs.coal+totalCapJs.gas+totalCapJs.diesel+totalCapJs.misc;
	var table = "<thead><tr><th>Source</th><th>Capacity (MW)</th></thead><tbody>"
	if (data.result != null) {
		table += "<tr><td>Renewable</td><td>" + data.result.res
		+ "</td></tr><tr><td>Hydro</td><td>" + data.result.hydro
		+ "</td></tr><tr><td>Nuclear</td><td>" + data.result.nuclear
		+ "</td></tr><tr><td>Coal</td><td>" + data.result.coal
		+ "</td></tr><tr><td>Gas</td><td>" + data.result.gas
		+ "</td></tr><tr><td>Diesel</td><td>" + data.result.diesel
		+ "</td></tr><tr><td>Others</td><td>" + data.result.misc
		+ "</td></tr><tr><th>Total</th><th>" + totalCap
		+ "</th></tr>"
	}
		table += "</tbody>";
		document.getElementsByName("table1")[0].innerHTML = table;
		
		
		if (data != null) {
			$('#canvasTotal').remove(); // this is my <canvas> element
			$('#canvasTotalContainer').append(
					'<canvas id="canvasTotal" class="canvas"><canvas>');

			var canvas = document.getElementById("canvasTotal");
			var ctx = canvas.getContext("2d");
			var myChart = new Chart(ctx, {
				type : 'pie',
				data : {
					labels : [ "RES", "Hydro", "Nuclear", "Coal", "Gas",
							"Diesel", "Others" ],
					datasets : [ {
						backgroundColor : [ "#2ecc71", "#3498db", "#95a5a6",
								"#9b59b6", "#f1c40f", "#e74c3c", "#34495e" ],
						data : [ data.result.res, data.result.hydro,
								data.result.nuclear, data.result.coal,
								data.result.gas, data.result.diesel,
								data.result.misc]
					} ]
				},
				options : {
					title : {
						display : true,
						text : 'Total Capacity by Source (India) in MW',
					},
					legend:{
						fullwidth: false,
					},
					 showAllTooltips: true,
				}
			});
			
			

			google.charts.load("current", {
				packages : [ "corechart" ]
			});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart() {
				var dataGC = google.visualization.arrayToDataTable([
						[ 'Source', 'Capacity' ], [ 'RES', data.result.res],
						[ 'Hydro', data.result.hydro], [ 'Nuclear', data.result.nuclear], [ 'Coal', data.result.coal],
						[ 'Gas', data.result.gas], [ 'Diesel', data.result.diesel], [ 'Others', data.result.misc] ]);

				var options = {
					title : 'Total Capacity by Source (India) in MW',
					tooltip : {
						trigger : 'none'
					},
					pieHole : 0.4,
				};

				var chart = new google.visualization.PieChart(document
						.getElementById('stateGoogleChart'));
// 				chart.draw(dataGC, options);
			}
			
			var pie = new d3pie("d3pieChart", {
				"header": {
					"title": {
						"text": "Total Capacity by Source (India) in MW",
						"fontSize": 12,
						"font-family": "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						"color": "#999999",
						"font-weight": "bold",
					},
					"subtitle": {
						"text": "As on May '17",
						"color": "#999999",
						"fontSize": 11,
						"font-family": "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
					},
					"titleSubtitlePadding": 3
				},
				"footer": {
					"color": "#888888",
					"fontSize": 10,
					"font": "open sans",
					"location": "bottom-left"
				},
				"size": {
// 					"canvasWidth": 400,
					"pieOuterRadius": "70%"
				},
				"data": {
					"sortOrder": "value-desc",
					"content": [
						{ 
							"label": "RES",
							"value": data.result.res,
							"color": "#2ecc71"
						},
						{
							"label": "Hydro",
							"value": data.result.hydro,
							"color": "#3498db"
						},
						{
							"label": "Coal",
							"value": data.result.coal,
							"color": "#95a5a6"
						},
						{
							"label": "Gas",
							"value": data.result.gas,
							"color": "#9b59b6"
						},
						{
							"label": "Nuclear",
							"value": data.result.nuclear,
							"color": "#f1c40f"
						},
						{
							"label": "Diesel",
							"value": data.result.diesel,
							"color": "#e74c3c"
						},
						{
							"label": "Others",
							"value": data.result.misc,
							"color": "#34495e"
						}
					]
				},
				"labels": {
					"outer": {
						"pieDistance": 16
					},
					"inner": {
						"hideWhenLessThanPercentage": 10
					},
					"mainLabel": {
						"fontSize": 11
					},
					"percentage": {
						"color": "#ffffff",
						"decimalPlaces": 0
					},
					"value": {
						"color": "#adadad",
						"fontSize": 11
					},
					"lines": {
						"enabled": true
					},
					"truncation": {
						"enabled": true
					}
				},
				"effects": {
					"pullOutSegmentOnClick": {
						"effect": "linear",
						"speed": 400,
						"size": 8
					}
				},
				"misc": {
					"gradient": {
						"enabled": false,
						"percentage": 100
					}
				}
			});
			
		}
	}

	function getTotalCapacity() {

		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : "${home}rest/search/api/getTotalCapacity",
			data : null,
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				console.log("SUCCESS: ", data);
				displayTotalCapacity(data);
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

	function enableSearchButton(flag) {
		$("#btn-search").prop("disabled", flag);
	}

	function display(data) {
		var json = "<h4>Ajax Response</h4><pre>"
				+ JSON.stringify(data, null, 4) + "</pre>";
		var table = "<table><thead><tr><th>head1</th><th>head2</th><th>head3</th><th>head4</th></tr></thead><tbody>"
		if (data.result != null) {
			for (var i = 0; i < data.result.length; i++) {
				table += "<tr><td>" + data.result[i]["cusId"] + "</td>"
						+ "<td>" + data.result[i]["name"] + "</td>" + "<td>"
						+ data.result[i]["age"] + "</td>" + "</tr>"
			}
			table += "</tbody></thead>";
			document.getElementsByName("table1")[0].innerHTML = table;
			$('#feedback').html(json);
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EmpowerIn</title>
</head>
<body>
	<%@include file="tabs.jsp"%>
<!-- 	<p>India's Energy Consumption by state for March '18</p> -->
<!-- 	<form class="form-horizontal" id="search-form"> -->
<!-- 		<div class="form-group form-group-lg"> -->
<!-- 			<label class="col-sm-2 control-label">Name</label> -->
<!-- 			<div class="col-sm-10"> -->
<!-- 				<input type=text class="form-control" id="name"> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="form-group"> -->
<!-- 			<div class="col-sm-offset-2 col-sm-10"> -->
<!-- 				<button type="submit" id="bth-search" class="btn btn-primary btn-lg">Search</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</form> -->
<!-- 	<div id="feedback"></div> -->
<%-- 	<canvas id="canvas" width=900 height=600>Aaa</canvas> --%>
	<div class="category-group" id="StateGroup">
	<div class="form-group">
	<table name="table1" id="totalCapacityTable">
	</table>
	</div>
	
	<div class="canvasContainer" id="canvasTotalContainer">
		<canvas id="canvasTotal"></canvas>
	</div>
	<div class="canvasContainer" id="stateGoogleChart"></div>
	</div>
	<div class="canvasContainer" id="d3pieChart"></div>
	</div>
	<div style="clear:both; font-size:0px;"></div>
	<br>
	<%@include file="footer.jsp"%>
</body>
</html>