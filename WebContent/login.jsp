<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log in</title>
</head>

<body class="HolyGrail">
	<header class="HolyGrail-header">
		<nav>
			<img src="img/fclogo.png">
			<ul>
				<li><a href="welcome.html">Home</a></li>
				<li><a href="listprod.jsp">Products</a></li>
				<li><a href="showcart.jsp">Cart</a></li>
				<li><a href="contact.html">Contact</a></li>
			</ul>
		</nav>
	</header>


	<main>
	<h1 align="center">Login to your Fancy Cacti account.</h1>
	<div id="form-main">
		<div id="form-div">
			<form class="form" id="form1">

				<p class="username">
					<input name="name" type="text" class="feedback-input"
						placeholder="Name" id="username" />
				</p>

				<p class="password">
					<input name="password" type="text" class="feedback-input"
						id="password" placeholder="Password" />
				</p>

				<div class="submit">
					<input type="submit" method="post" value="Login" id="button-green"
						onclick="">
					<div class="ease"></div>
				</div>
			</form>
		</div>
	</div>
	</main>

	<footer class="HolyGrail-footer">
		<div class="footer">
			<div class="leftfooter">
				<h3>About</h3>
				<p>FancyCacti is the best cactus store ever. We are the best,
					bar nonerino caterino!</p>

			</div>

			<div class="centerfooter">
				<h3>Contact</h3>
				<a href="mailto:contact@fancycacti.com" class="flink">contact@fancycacti.com</a><br>
				<a href="tel:+12505550100" class="flink">(250) 555-0100</a>
			</div>

			<div class="rightfooter">
				<h3>Site Map</h3>
				<a href="index.html">Home</a><br> <a href="products.html">Products</a><br>
				<a href="services.html">Services</a><br> <a href="contact.html">Contact</a>
			</div>
		</div>
		<div class="copyinfo">
			<p>
				MLM Roofing &copy; 2016. <a id="jw" href="legal.html">Legal
					Information.</a> All rights reserved. <br> Website design by <a
					id="jw" href="http://www.jaredhw.com">Jaredhw</a>
			</p>
		</div>
	</footer>

</body>
</html>