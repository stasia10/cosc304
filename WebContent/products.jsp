<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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

<title>Products</title>

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
	<%@ page import="java.sql.*"%>
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
	%>
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
							<li><a class="active" href="products.jsp">Products</a></li>
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
	<
	<div id="wrapper">
		<div class="overlay"></div>

		<!-- Sidebar -->
		<nav class="navbar navbar-inverse navbar-fixed-top"
			id="sidebar-wrapper" role="navigation">
			<ul class="nav sidebar-nav">
				<li class="sidebar-brand"><a href="#"> Products: </a></li>
				<li>
					<form class="navbar-form" role="search">
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="Product Name" name="srch-term" id="srch-term">
							<div class="input-group-btn">
								<button class="btn btn-default" type="submit">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</div>
						</div>
					</form>
				</li>
				<li><a href="products.jsp?"> All Products</a></li>
				<li><a href="products.jsp?category=FT"> Fertilizer</a></li>
				<li><a href="products.jsp?category=AC"> Accessories</a></li>
				<li><a href="products.jsp?category=CS"> Cacti</a></li>
			</ul>
		</nav>


		<!-- /#sidebar-wrapper -->

		<!-- Page Content -->
		<div id="page-content-wrapper">
			<button type="button" class="hamburger is-closed animated fadeInLeft"
				data-toggle="offcanvas">
				<span class="hamb-top"></span> <span class="hamb-middle"></span> <span
					class="hamb-bottom"></span>
			</button>






			<!-- Marketing messaging and featurettes
	================================================== -->
			<!-- Wrap the rest of the page in another container to center all the content. -->
			<div class="container">
				<div class="container marketing">

					<!-- START THE FEATURETTES -->

					<%
						String cat = request.getParameter("category");
						String search = request.getParameter("srch-term");

						int water = 0;
						int sun = 0;

						try {
							con = DriverManager.getConnection(url, uid, pw);
							if (cat == null && search == null) {
								String SQL = "SELECT productName, productId, price, category, P.species, picture, sunLevel, waterLevel, food FROM Product P INNER JOIN "
										+ " CactiSpecies C ON P.species = C.species WHERE Inventory > 0";
								PreparedStatement pstmt = con.prepareStatement(SQL);
								ResultSet rst = pstmt.executeQuery();
								String spec = null;
								while (rst.next()) {
									spec = rst.getString(5);
									out.println("<hr class='featurette-divider'><div class='row featurette'><div class='col-md-7'>"
											+ "<h2 class='featurette-heading'>" + rst.getString(1) + " <span class='text-muted'> "
											+ rst.getDouble(3) + " </span>");
									out.println("</h2>" + "<h1><a href=\"addcart.jsp?id=" + rst.getString(2) + "&name="
											+ rst.getString(1) + "&price=" + rst.getString(3)
											+ "\">Add to cart</a></h1><p class='lead'>");
									if (spec != null) {
										sun = rst.getInt("sunLevel");
										water = rst.getInt("waterLevel");
										out.println("<br>" + rst.getString(5));
										out.println("<br>Preferred Fertilizer: " + rst.getString("food") + "</p>");
										out.println("<div class=\"container\">");
										out.println("<h2>Ideal Plant Conditions</h2>");

										out.println("<p>Water Level: </p>");
										out.println("<div class=\"progress\">");
										out.println(
												"<div class=\"progress-bar progress-bar-info progress-bar-striped active\" role=\"progressbar\" aria-valuenow=\"" + water + "\" aria-valuemin=\"0\" aria-valuemax=\"10\" style=\"width:40%\">");
										out.println(water + "/10");
										out.println("</div></div>");
										out.println("<p>Sun Level:</p>");
										out.println("<div class=\"progress\">");
										out.println(
												"<div class=\"progress-bar progress-bar-warning progress-bar-striped active\" role=\"progressbar\" aria-valuenow=\"" + sun + "\" aria-valuemin=\"0\" aria-valuemax=\"10\" style=\"width:40%\">");
										out.println(sun + "/10");
										out.println("</div></div></div>");
									}
									out.println("</div>" + "<div class='col-md-5'>"
											+ "<img class='featurette-image img-responsive center-block'" + "src='img\\"
											+ rst.getString(6) + "' alt='Image Failed to Load'>" + "</div>" + "</div>");
								}
							} else if (search != null) {
								String SQL = "SELECT productName, productId, price, category, P.species, picture, sunLevel, waterLevel, food FROM Product P INNER JOIN "
										+ " CactiSpecies C ON P.species = C.species WHERE Inventory > 0 AND productName LIKE ?";
								PreparedStatement pstmt = con.prepareStatement(SQL);
								pstmt.setString(1, "%" + search + "%");
								ResultSet rst = pstmt.executeQuery();
								String spec = null;
								while (rst.next()) {
									spec = rst.getString(5);
									out.println("<hr class='featurette-divider'><div class='row featurette'><div class='col-md-7'>"
											+ "<h2 class='featurette-heading'>" + rst.getString(1) + " <span class='text-muted'> "
											+ rst.getDouble(3) + " </span>");
									out.println("</h2>" + "<h1><a href=\"addcart.jsp?id=" + rst.getString(2) + "&name="
											+ rst.getString(1) + "&price=" + rst.getString(3)
											+ "\">Add to cart</a></h1><p class='lead'>");
									if (spec != null) {
										out.println("<br>" + rst.getString(5) + "</p>");
										out.println("<br>Preferred Fertilizer: " + rst.getString("food") + "</p>");
									}
									out.println("</div>" + "<div class='col-md-5'>"
											+ "<img class='featurette-image img-responsive center-block'" + "src='img\\"
											+ rst.getString(6) + "' alt='Image Failed to Load'>" + "</div>" + "</div>");
								}
							} else {
								String SQL = "SELECT productName, productId, price, category, P.species, picture, sunLevel, waterLevel, food FROM Product P INNER JOIN "
										+ " CactiSpecies C ON P.species = C.species WHERE Inventory > 0 AND category = ?";
								PreparedStatement pstmt = con.prepareStatement(SQL);
								pstmt.setString(1, cat);
								ResultSet rst = pstmt.executeQuery();
								String spec = null;
								while (rst.next()) {
									spec = rst.getString(5);
									out.println("<hr class='featurette-divider'><div class='row featurette'><div class='col-md-7'>"
											+ "<h2 class='featurette-heading'>" + rst.getString(1) + " <span class='text-muted'> "
											+ rst.getDouble(3) + " </span>");
									out.println("</h2>" + "<h1><a href=\"addcart.jsp?id=" + rst.getString(2) + "&name="
											+ rst.getString(1) + "&price=" + rst.getString(3)
											+ "\">Add to cart</a></h1><p class='lead'>");
									if (spec != null) {
										out.println("<br>" + rst.getString(5) + "</p>");
										out.println("<br>Preferred Fertilizer: " + rst.getString("food") + "</p>");
									}
									out.println("</div>" + "<div class='col-md-5'>"
											+ "<img class='featurette-image img-responsive center-block'" + "src='img\\"
											+ rst.getString(6) + "' alt='Image Failed to Load'>" + "</div>" + "</div>");
								}
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
					%>

					<!-- /END THE FEATURETTES -->
				</div>
				<!-- /#page-content-wrapper -->

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
