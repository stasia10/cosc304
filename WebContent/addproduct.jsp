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
							<li class="active"><a href="staff.jsp">Staff</a></li>
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
	<div class="container marketing formpadding">
		<form method="POST" action="addproduct.jsp"
			class="form-signup">
			<div class="form-group row">
				<label for="inputWeight" class="col-xs-2 col-form-label">Weight:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputWeight"
						type="text" placeholder="Weight of Product">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputName" class="col-xs-2 col-form-label">Product
					Name:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputName"
						type="text" placeholder="Name of Product">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputSpecies" class="col-xs-2 col-form-label">Cacti
					Species</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputSpecies" type="text"
						placeholder="Species of Cacti">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputFood" class="col-xs-2 col-form-label">Preferred
					Fertilizer:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputFood" type="text"
						placeholder="If Cacti Enter Food">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputSun" class="col-xs-2 col-form-label">Sun
					Level:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputSun" type="text"
						placeholder="Number from 1 to 10">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputWater" class="col-xs-2 col-form-label">Water
					Level:</label>
				<div class="col-xs-10">
					<input class="form-control" name="inputWater" type="text"
						placeholder="Number from 1 to 10">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputPrice" class="col-xs-2 col-form-label">Price:</label>
				<div class="col-xs-10">
					<input required="" class="form-control" name="inputPrice"
						type="text" placeholder="No $ Sign Necessary">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputInvent" class="col-xs-2 col-form-label">Inventory:</label>
				<div class="col-xs-10">
					<input required="required" class="form-control" name="inputInvent"
						type="text" placeholder="Number Greater or Equal to 0">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputCat" class="col-xs-2 col-form-label">Category:</label>
				<div class="col-xs-10">
					<input required class="form-control" name="inputCat" type="text"
						placeholder="CS, AC, or FT">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputPic" class="col-xs-2 col-form-label">Picture:</label>
				<div class="col-xs-10">
					<input required class="form-control" name="inputPic" type="text"
						placeholder=".png File Name">
				</div>
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit" name="submit"
				value="submit">Create New Product</button>

			<button class="btn btn-lg btn-block" type="button" onClick="cancel()">Cancel</button>
		</form>
		<script>
			function cancel() {
				location.href = 'admin.jsp?view=products';
			}
		</script>


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
	
</body>
<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
<%@ page import="java.sql.*"%>
<%
	String submit = request.getParameter("submit");
	if (submit != null) {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";

		String weight = request.getParameter("inputWeight");
		String name = request.getParameter("inputName");
		String species = request.getParameter("inputSpecies");
		String food = request.getParameter("inputFood");
		String sun = request.getParameter("inputSun");
		String water = request.getParameter("inputWater");
		String price = request.getParameter("inputPrice");
		String invent = request.getParameter("inputInvent");
		String cat = request.getParameter("inputCat");
		String pic = request.getParameter("inputPic");

		try {
			con = DriverManager.getConnection(url, uid, pw);
			PreparedStatement add = con.prepareStatement("DECLARE @productId INT "
					+ " INSERT INTO Product (weight, productName, species, price, Inventory, category, picture) "
					+ " VALUES(?, ?, ?, ?, ?, ?, ?)");
			add.setString(1, weight);
			add.setString(2, name);
			if (species.isEmpty()) {
				add.setString(3, null);
			} else {
				add.setString(3, species);
				PreparedStatement cacti = con.prepareStatement("INSERT INTO CactiSpecies VALUES (?, ?, ?, ?)");
				cacti.setString(1, species);
				cacti.setString(2, food);
				cacti.setString(3, sun);
				cacti.setString(4, water);
				cacti.executeUpdate();
			}
			add.setString(4, price);
			add.setString(5, invent);
			add.setString(6, cat);
			add.setString(7, pic);
			add.executeUpdate(); 
			%><jsp:forward page="admin.jsp?view=products"/><%			
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

</html>