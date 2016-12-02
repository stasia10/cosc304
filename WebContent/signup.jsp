<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">


<link rel="apple-touch-icon" sizes="180x180"
	href="img/fav/apple-touch-icon.png">
<link rel="icon" type="image/png" href="img/fav/favicon-32x32.png"
	sizes="32x32">
<link rel="icon" type="image/png" href="img/fav/favicon-16x16.png"
	sizes="16x16">
<link rel="manifest" href="img/fav/manifest.json">
<link rel="mask-icon" href="img/fav/safari-pinned-tab.svg"
	color="#5bbad5">
<link rel="shortcut icon" href="img/fav/favicon.ico">
<meta name="msapplication-config" content="img/fav/browserconfig.xml">
<meta name="theme-color" content="#ffffff">


<style type="text/css">
:root .carbonad, :root #carbonads-container, :root #content>#right>.dose>.dosesingle,
	:root #content>#center>.dose>.dosesingle {
	display: none !important;
}
</style>

<title>Register</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href=csss/ie10-viewport-bug-workaround.css " rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/signin.css" rel="stylesheet">
<link href="css/carousel.css" rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="signin_files/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
</head>
<!-- NAVBAR
	================================================== -->
<body>
	<div class="navbar-wrapper">
		<div class="container">

			<!-- Fixed navbar -->
			<nav class="navbar navbar-default navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">

						<a class="navbar-brand" href="index.html">Fancy Cacti</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li><a class="active" href="index.html">Home</a></li>
							<li><a href="about.html">About</a></li>
							<li><a href="products.jsp">Products</a></li>
							<li><a href="staff.jsp">Staff</a></li>
							<li><a href="showorder-login.jsp">Purchases</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<a href="showcart.jsp" class="btn btn-default navbar-btn"> <span
								class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart
							</a>

						</ul>

					</div>
					<!--/.nav-collapse -->

				</div>
			</nav>

		</div>
	</div>
	<!-- Main Content -->
	<!-- /container -->
	<div class="container marketing formpadding">
		<form method="POST" action="order.jsp" class="form-signup">

			<div class="form-group row">
				<label for="inputName" class="col-xs-2 col-form-label">Name:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputName"
						type="text" placeholder="First and Last Name">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputEmail" class="col-xs-2 col-form-label">Email:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputEmail"
						type="email" placeholder="Example@FancyCacti.com">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputPassword" class="col-xs-2 col-form-label">Password:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputPassword"
						type="password" placeholder="hunter2">
				</div>

			</div>
			<div class="form-group row">
				<label for="inputNum" class="col-xs-2 col-form-label">Phone
					Number:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputNum" type="tel"
						placeholder="1-(555)-555-5555">
				</div>
			</div>

			<div class="form-group row">
				<label for="inputBAdd" class="col-xs-2 col-form-label">Billing
					Address:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputBAdd"
						type="text" placeholder="1234 Example St, Kelowna BC, Canada.">
				</div>
			</div>

			<div class="form-group row">
				<label for="inputSAdd" class="col-xs-2 col-form-label">Shipping
					Address:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputSAdd"
						type="text" placeholder="1000 Example St, Kelowna BC, Canada.">
				</div>
			</div>

			<div class="form-group row">
				<label for="inputPay" class="col-xs-2 col-form-label">Payment
					Information:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputPay" type="text"
						placeholder="123412451236 - 5/2017">
				</div>
			</div>
			<label> Choose A Shipping Method: </label>
			<div class="form-group row">
				<div class="col-xs-10">
					<input type="radio" name="shipping" value="reg" autocomplete="off"
						checked> Regular 10-day shipping: Free
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-10">
					<input type="radio" name="shipping" value="exp" autocomplete="off">
					Expedited 3-day shipping $10.00
				</div>
			</div>


			<button class="btn btn-lg btn-primary btn-block" type="submit"
				value="submit">Register and Place Order</button>


			<button class="btn btn-lg btn-block" type="button" onClick="cancel()">Cancel</button>

			<!-- FOOTER -->
			<footer>
				<p class="pull-right">
					<a href="#">Back to top</a>
				</p>
				<p>
					&copy; 2016 Fancy Cacti, Inc. &middot; <a href="privacy.html">Privacy</a>
					&middot; <a href="legal.html">Legal</a>
				</p>
			</footer>
			</form>
	</div>
	<script>
		function cancel() {
			location.href = 'checkout.jsp';
		}
	</script>

	<!-- /.container -->


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')
	</script>
	<script src="js/bootstrap.min.js"></script>
	<!-- Just to make our placeholder images work. Don't actually copy the next line! -->
	<script src="js/vendor/holder.min.js"></script>
	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
</body>




<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
