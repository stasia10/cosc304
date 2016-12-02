<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="img/fav/favicon.ico">

<title>Staff Login</title>

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
	<!-- Marketing messaging and featurettes
    ================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->
	<div class="container marketing">
		<div class="formpadding">
			<form method="POST" action="staff.jsp" class="staff-signin"
				name=signIn>
				<h2 class="form-signin-heading">Please sign in</h2>


				<div class="form-group row">
				<label for="inputEmail" class="col-xs-2 col-form-label">Email:</label>
					<div class="col-xs-10">
						<input id="inputEmail" name="inputEmail" class="form-control"
							placeholder="Example@FancyCacti.com" type="email">
					</div>
				</div>

				<div class="form-group row">
					<label for="inputPassword" class="col-xs-2 col-form-label">Password:</label>
					<div class="col-xs-10">
						<input class="form-control" name="inputPassword" type="password"
							placeholder="hunter2">
					</div>
				</div>
				<button class="btn btn-lg btn-primary btn-block" type="submit"
					value="Submit">Sign in</button>

			</form>
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
	</div>
</body>
<!-- /container -->
<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
<%
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
	String uid = "kreid";
	String pw = "39265137";
	String password = request.getParameter("inputPassword");
	String email = request.getParameter("inputEmail");
	if (email == null) {
	} else {
		try {
			con = DriverManager.getConnection(url, uid, pw);
			String SQL = "SELECT empEmail, title FROM Employee WHERE empEmail=? AND empPass =?";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet rst = pstmt.executeQuery();
			if (rst.next()) {
				if (rst.getString("title").equalsIgnoreCase("AD")) {
%>
<jsp:forward page="admin.jsp" />
<%
	} else if (rst.getString("title").equalsIgnoreCase("SP")) {
%>
<jsp:forward page="supervisor.jsp" />
<%
	} else if (rst.getString("title").equalsIgnoreCase("GH")
						|| rst.getString("title").equalsIgnoreCase("WH")) {
%>
<script>
	alert("Sorry you are not authorized to log in to this page");
</script>
<%
	}
			} else {
%>
<script>
	alert("Sorry this email and/or password does not match an employee");
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

</html>

