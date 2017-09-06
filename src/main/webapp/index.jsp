<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/site.css" type="text/css" />
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/d3/4.7.2/d3.min.js"></script>
<script src="scripts/d3pie.js"></script>
<script>
	var capacityData;
	$(document).ready(function() {
		getTotalCapacity();
	});
	
	$(window).resize(function(){
		displayTotalCapacity(capacityData)
	});
	
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
				capacityData=data;
				displayTotalCapacity(data);
				displayGraphOption(canvasTotalContainer,stateGoogleChart,d3pieChart,chartTotalBarContainer,chartTotalBarStackedContainer);
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

	function displayGraphOption(graph1,graph2,graph3,graph4,graph5){
		$(graph1).css('display','inline-block');
		$(graph2).hide();
		$(graph3).hide();
		$(graph4).hide();
		$(graph5).hide();
	}
	
	function displayTotalCapacity(data) {
		var totalCapJs = data.result;
		var totalCap = totalCapJs.res + totalCapJs.hydro + totalCapJs.nuclear
				+ totalCapJs.coal + totalCapJs.gas + totalCapJs.diesel
				+ totalCapJs.misc;
		var table = "<thead><tr><th>Source</th><th>Capacity (MW)</th></thead><tbody>"
		if (data.result != null) {
			table += "<tr><td>Renewable</td><td>" + data.result.res
					+ "</td></tr><tr><td>Hydro</td><td>" + data.result.hydro
					+ "</td></tr><tr><td>Nuclear</td><td>"
					+ data.result.nuclear + "</td></tr><tr><td>Coal</td><td>"
					+ data.result.coal + "</td></tr><tr><td>Gas</td><td>"
					+ data.result.gas + "</td></tr><tr><td>Diesel</td><td>"
					+ data.result.diesel + "</td></tr><tr><td>Others</td><td>"
					+ data.result.misc + "</td></tr><tr><th>Total</th><th>"
					+ totalCap + "</th></tr>"
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
								data.result.misc ]
					} ]
				},
				options : {
					title : {
						display : true,
						text : 'Total Capacity by Source (India) in MW',
					},
					legend : {
						fullwidth : false,
					},
					showAllTooltips : true,
				}
			});
			$('#chartTotalBarStacked').remove();
			$('#chartTotalBarStackedContainer').append(
					'<canvas id="chartTotalBarStacked" class="canvas"><canvas>');
			
			var canvas = document.getElementById("chartTotalBarStacked");
			var ctx = canvas.getContext("2d");
			var myChart = new Chart(ctx, {
				type : 'bar',
				data : {
					labels : [ "Set1"],
					datasets : [ {
							label : 'RES',
							data : [data.result.res],
							backgroundColor : "#2ecc71"
						}, {
							label : 'Hydro',
							data : [data.result.hydro],
							backgroundColor : "#3498db"
						}, {
							label : 'Coal',
							data : [data.result.coal],
							backgroundColor : "#95a5a6"
						}, {
							label : 'Gas',
							data : [data.result.gas],
							backgroundColor : "#9b59b6"
						}, {
							label : 'Nuclear',
							data : [data.result.nuclear],
							backgroundColor : "#f1c40f"
						}, {
							label : 'Diesel',
							data : [data.result.diesel],
							backgroundColor : "#e74c3c"
						}]
				},
				options : {
					title : {
						display : true,
						text : 'Total Capacity by Source (India) in MW',
					},
					legend : {display : false, },
					showAllTooltips : true,
					scales: {
                        xAxes: [{
                            stacked: true,
                        }],
                        yAxes: [{
                            stacked: true
                        }]
                    },
				}
			});
			
			$('#chartTotalBar').remove(); // this is my <canvas> element
			$('#chartTotalBarContainer').append(
					'<canvas id="chartTotalBar" class="canvas"><canvas>');
			
			var canvas = document.getElementById("chartTotalBar");
			var ctx = canvas.getContext("2d");
			var myChart = new Chart(ctx, {
				type : 'bar',
				data : {
					labels : [ "RES", "Hydro", "Nuclear", "Coal", "Gas",
							"Diesel", "Others" ],
					datasets : [ {
						backgroundColor : [ "#2ecc71", "#3498db", "#95a5a6",
								"#9b59b6", "#f1c40f", "#e74c3c", "#34495e" ],
						data : [ data.result.res, data.result.hydro,
								data.result.nuclear, data.result.coal,
								data.result.gas, data.result.diesel,
								data.result.misc ]
					} ]
				},
				options : {
					title : {
						display : true,
						text : 'Total Capacity by Source (India) in MW',
					},
					legend : {display : false, },
					showAllTooltips : true,
				}
			});

			google.charts.load("current", {
				packages : [ "corechart" ]
			});
			google.charts.setOnLoadCallback(drawChart);
			function drawChart() {
				var dataGC = google.visualization.arrayToDataTable([
						[ 'Source', 'Capacity' ], [ 'RES', data.result.res ],
						[ 'Hydro', data.result.hydro ],
						[ 'Nuclear', data.result.nuclear ],
						[ 'Coal', data.result.coal ],
						[ 'Gas', data.result.gas ],
						[ 'Diesel', data.result.diesel ],
						[ 'Others', data.result.misc ] ]);

				var options = {
					title : 'Total Capacity by Source (India) in MW',
					tooltip : {
						trigger : 'none'
					},
					pieHole : 0.4,
				};

				var chart = new google.visualization.PieChart(document
						.getElementById('stateGoogleChart'));
								chart.draw(dataGC, options);
			}
			
			$('#d3pieChart').empty();
			var pie = new d3pie(
					"d3pieChart",
					{
						"header" : {
							"title" : {
								"text" : "Total Capacity by Source (India) in MW",
								"fontSize" : 12,
								"font-family" : "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
								"color" : "#999999",
								"font-weight" : "bold",
							},
							"subtitle" : {
								"text" : "As on May '17",
								"color" : "#999999",
								"fontSize" : 11,
								"font-family" : "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif"
							},
							"titleSubtitlePadding" : 3
						},
						"footer" : {
							"color" : "#888888",
							"fontSize" : 10,
							"font" : "open sans",
							"location" : "bottom-left"
						},
						"size" : {
// 							"canvasHeight": $('#d3pieChart').outerHeight()/1.2,
//  							"canvasWidth": $('#d3pieChart').outerWidth()*2,
							"canvasHeight": 400,
 							"canvasWidth": 590,
							"pieOuterRadius" : "80%"
						},
						"data" : {
							"sortOrder" : "value-desc",
							"content" : [ {
								"label" : "RES",
								"value" : data.result.res,
								"color" : "#2ecc71"
							}, {
								"label" : "Hydro",
								"value" : data.result.hydro,
								"color" : "#3498db"
							}, {
								"label" : "Coal",
								"value" : data.result.coal,
								"color" : "#95a5a6"
							}, {
								"label" : "Gas",
								"value" : data.result.gas,
								"color" : "#9b59b6"
							}, {
								"label" : "Nuclear",
								"value" : data.result.nuclear,
								"color" : "#f1c40f"
							}, {
								"label" : "Diesel",
								"value" : data.result.diesel,
								"color" : "#e74c3c"
							}, {
								"label" : "Others",
								"value" : data.result.misc,
								"color" : "#34495e"
							} ]
						},
						"labels" : {
							"outer" : {
								"pieDistance" : 16
							},
							"inner" : {
								"hideWhenLessThanPercentage" : 10
							},
							"mainLabel" : {
								"fontSize" : 11
							},
							"percentage" : {
								"color" : "#ffffff",
								"decimalPlaces" : 0
							},
							"value" : {
								"color" : "#adadad",
								"fontSize" : 11
							},
							"lines" : {
								"enabled" : true
							},
							"truncation" : {
								"enabled" : true
							}
						},
						"effects" : {
							"pullOutSegmentOnClick" : {
								"effect" : "linear",
								"speed" : 400,
								"size" : 8
							}
						},
						"misc" : {
							"gradient" : {
								"enabled" : false,
								"percentage" : 100
							}
						}
					});

		}
	}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EmpowerIn</title>
</head>
<body>
	<%@include file="tabs.jsp"%>
	<div class="category-group" id="StateGroup">
		<div class="form-group">
			<table name="table1" id="totalCapacityTable"></table>
		</div>
		<div class="banner-container">
		<div class="banner-thumbs-container" style="text-align: center;">
			<ul class="banner-thumbs">
				<li><button onclick="displayGraphOption(canvasTotalContainer,stateGoogleChart,d3pieChart,chartTotalBarContainer,chartTotalBarStackedContainer)">A</button></li>
				<li><button onclick="displayGraphOption(stateGoogleChart,canvasTotalContainer,d3pieChart,chartTotalBarContainer,chartTotalBarStackedContainer)">B</button></li>
				<li><button onclick="displayGraphOption(d3pieChart,canvasTotalContainer,stateGoogleChart,chartTotalBarContainer,chartTotalBarStackedContainer)">C</button></li>
				<li><button onclick="displayGraphOption(chartTotalBarContainer,d3pieChart,canvasTotalContainer,stateGoogleChart,chartTotalBarStackedContainer)">D</button></li>
				<li><button onclick="displayGraphOption(chartTotalBarStackedContainer,chartTotalBarContainer,d3pieChart,canvasTotalContainer,stateGoogleChart)">E</button></li>
			</ul>
			</div>
		<div class="canvasContainer" id="canvasTotalContainer"></div>
		<div class="canvasContainer" id="stateGoogleChart"></div>
		<div class="canvasContainer" id="d3pieChart"></div>
		<div class="canvasContainer" id="chartTotalBarContainer"></div>
		<div class="canvasContainer" id="chartTotalBarStackedContainer"></div>
		</div>
	</div>
	<div style="clear: both; font-size: 0px;"></div>
	<br>
	<%@include file="footer.jsp"%>
</body>
</html>