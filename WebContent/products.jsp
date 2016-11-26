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
<link rel="icon" href="../../favicon.ico">

<title>Carousel Template for Bootstrap</title>

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
							<li class="active"><a href="about.html">About</a></li>
							<li><a href="#contact.html">Contact</a></li>
							<li><a href="#products.html">Products</a></li>
							<li><a href="#products.html">Plant Care</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<a href="checkout.jsp" class="btn btn-default navbar-btn"> <span
								class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart
							</a>

						</ul>

					</div>
					<!--/.nav-collapse -->

				</div>
			</nav>

		</div>
	</div>
	<li>
		<div id="wrapper">
			<div class="overlay"></div>

			<!-- Sidebar -->
			<nav class="navbar navbar-inverse navbar-fixed-top"
				id="sidebar-wrapper" role="navigation">
				<ul class="nav sidebar-nav">
					<li class="sidebar-brand"><a href="#"> Categories: </a></li>
					<li></li>
				</ul>
			</nav>

			<form class="navbar-form" role="search">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search"
						name="srch-term" id="srch-term">
					<div class="input-group-btn">
						<button class="btn btn-default" type="submit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
			</form>
		</div>
	</li>
	<li><a href="product.jsp?allProd="><i class="fa fa-fw fa-home"></i> All Products</a>
	</li>
	<li><a href="product.jsp?fert="><i class="fa fa-fw fa-folder"></i> Fertilizer</a>
	</li>
	<li><a href="product.jsp?access="><i class="fa fa-fw fa-file-o"></i> Accessories</a>
	</li>
	<li><a href="product.jsp?cacti="><i class = "fa fa-fw fa-file-o"></i> Cacti</a>

	<nav></nav>
	<!-- /#sidebar-wrapper -->

	<!-- Page Content -->
	<div id="page-content-wrapper">
		<button type="button" class="hamburger is-closed animated fadeInLeft"
			data-toggle="offcanvas">
			<span class="hamb-top"></span> <span class="hamb-middle"></span> <span
				class="hamb-bottom"></span>
		</button>
	</div>





	<!-- Marketing messaging and featurettes
    ================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->
	<div class="container">
		<div class="container marketing">

			<!-- START THE FEATURETTES -->

			<%
				String all = request.getParameter("allProd");
				String fert = request.getParameter("fert");
				String access = request.getParameter("access");
				String cacti = request.getParameter("cacti");
				try {
					con = DriverManager.getConnection(url, uid, pw);
					String SQL = "SELECT productName, productId, price, category, species FROM Product WHERE Inventory > 0";
					PreparedStatement pstmt = con.prepareStatement(SQL);
					ResultSet rst = pstmt.executeQuery();
					while (rst.next()) {
						out.println("<hr class='featurette-divider'><div class='row featurette'><div class='col-md-7'>"
								+ "<h2 class='featurette-heading'>" + rst.getString(1) + " <span class='text-muted'> "
								+ rst.getDouble(3) + " </span>");
						out.println("</h2>" + "<p class='lead'>");
						if (rst.getString(4) == "CS") {
							out.println("<br>" + rst.getString(5) + "</p>");
						}
						out.println("</div>" + "<div class='col-md-5'>"
								+ "<img class='featurette-image img-responsive center-block'"
								+ "src='PUT THE IMAGE SOURCE HERE' alt='Image Failed to Load'>" + "</div>" + "</div>");
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
