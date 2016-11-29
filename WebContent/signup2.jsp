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
							<li><a href="pcare.html">Plant Care</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<a href="checkout.html" class="btn btn-default navbar-btn"> <span
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
		<form method="POST" action="products.jsp" class="form-signup">

			<div class="form-group row">
				<label for="inputName" class="col-xs-2 col-form-label">Name:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputName" type="text"
						placeholder="First and Last Name">
				</div>
			</div>
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
					<input class="form-control" name="inputBAdd" type="text"
						placeholder="First and Last Name">
				</div>
			</div>

			<div class="form-group row">
				<label for="inputSAdd" class="col-xs-2 col-form-label">Shipping
					Address:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputSAdd" type="text"
						placeholder="First and Last Name">
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

			<button class="btn btn-lg btn-primary btn-block" type="submit"
				value="submit">Sign up</button>


			<button class="btn btn-lg btn-block" href="checkout.jsp">Cancel</button>


		</form>
	</div>



	<!-- FOOTER -->
	<footer>
		<p class="pull-right">
			<a href="#">Back to top</a>
		</p>
		<p>
			&copy; 2016 Fancy Cacti, Inc. &middot; <a href="privacy.html">Privacy</a>
			&middot; <a href="terms.html">Terms</a>
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




<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
<%@ page import="java.sql.*"%>
<%
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
	String uid = "kreid";
	String pw = "39265137";
	String name = request.getParameter("inputName");
	String email = request.getParameter("inputEmail");
	String password = request.getParameter("inputPassword");
	String number = request.getParameter("inputNum");
	String BAdd = request.getParameter("inputBAdd");
	String SAdd = request.getParameter("inputSAdd");
	String Payment = request.getParameter("inputPay");
	if (email == null) {
	} else {
		try {
			con = DriverManager.getConnection(url, uid, pw);
			String s = "SELECT pass FROM Account WHERE email = ?";
			PreparedStatement st = con.prepareStatement(s);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
%>

<script>
	alert("Sorry this email address is already in use :( ");
</script>

<%
	} else {
				String s2 = "INSERT INTO Account VALUES (?, ?, ?, ?, ?, ?, ?, 'Customer')";
				PreparedStatement p = con.prepareStatement(s2);
				p.setString(1, email);
				p.setString(2, password);
				p.setString(3, name);
				if (number.length() == 0)
					p.setString(4, null);
				else
					p.setString(4, number);
				p.setString(5, BAdd);
				p.setString(6, SAdd);
				if (Payment.length() == 0)
					p.setString(7, null);
				else
					p.setString(7, Payment);
				p.executeUpdate();
%>
<script>
	window.location = "products.jsp";
</script>
<%
	}

		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
					System.err.println("SQLException: " + ex);
				}
		}
	}
%>

</body>
</html>
