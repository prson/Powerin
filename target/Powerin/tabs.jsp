<div class="header">
<img class="logo" src="css/logo.gif" alt="Logo">
<h1 class="title">PowerIN</h1>
<div class="menu" id="menu">
<a href="/Powerin/index.jsp" class="menuitems">Dashboard</a>
<a href="/Powerin/capacity.jsp" class="menuitems">Capacity</a>
<a href="/Powerin/demand.jsp" class="menuitems">Demand</a>
<a href="javascript:void(0);" class="menuicon" onclick="myFunction()">&#9776;</a>
</div>
<div style="clear:both; font-size:0px;"></div>
</div>

<script>
function myFunction() {
    var x = document.getElementById("menu");
    if (x.className === "menu") {
        x.className += " responsive";
    } else {
        x.className = "menu";
    }
}
</script>