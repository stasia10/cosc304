<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="img/fav/favicon.ico">

<title>Checkout</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="js/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- Custom styles for this template -->
<link href="css/carousel.css" rel="stylesheet">
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
							<li><a href="index.html">Home</a></li>
							<li><a href="about.html">About</a></li>
							<li class="active"><a href="products.jsp">Products</a></li>
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
	<!-- Marketing messaging and featurettes
    ================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->

	<div class="container marketing">
		<div class="formpadding">
			<form class="form-signin" method="POST" action="order.jsp">
			
				<div class="form-group row">
					<label for="inputEmail" class="col-xs-2 col-form-label">Email:</label>
					<div class="col-xs-10">
						<input class="form-control" name="inputEmail" type="email"
							placeholder="Example@FancyCacti.com"">
					</div>
				</div>

					<div class="form-group row">
					<label for="inputPassword" class="col-xs-2 col-form-label">Password:</label>
					<div class="col-xs-10">
						<input class="form-control" name="inputPassword" type="password"
							placeholder="hunter2">
					</div>
				</div>
				
				
				<label> Choose A Shipping Method: </label>
				<div class="form-group row">
				<div class="col-xs-10">
				<input type="radio" name="shipping" value="reg" autocomplete="off" checked> 
				Regular 10-day shipping: Free 
				</div>
				</div>
				<div class="form-group row">
				<div class="col-xs-10">
				<input type="radio" name="shipping" value="exp" autocomplete="off"> 
				Expedited 3-day shipping $10.00 
				</div>
				</div>
				<div class="form-group row">
				<div class="col-m-10">
	<button class="btn btn-lg btn-primary btn-block" type="submit">Confirm Order</button>
	</div>
	</div>
	<div class="form-group row">
				<div class="col-m-10">
				<a class="btn btn-lg btn-block btn-register" href="signup.jsp">Register & Place Order</a>
					</div>
					</div>
					
			</form>
				</div>
				
				
				
		


		<!-- /END THE FEATURETTES -->

		<!-- /#page-content-wrapper -->

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

	</div>
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
</html>
