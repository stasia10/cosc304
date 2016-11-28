<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="icon" href="">
<style type="text/css">
:root .carbonad, :root #carbonads-container, :root #content>#right>.dose>.dosesingle,
	:root #content>#center>.dose>.dosesingle {
	display: none !important;
}
</style>

<title>Staff Sign In</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href=csss/ie10-viewport-bug-workaround.css " rel="stylesheet">

<!-- Custom styles for this template -->
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
<body>
	<div class="container">

		<form class="staff-signin" name=signIn>
			<h2 class="form-signin-heading">Please sign in</h2>
			<label for="inputEmail" class="sr-only">Email address</label> <input
				id="inputEmail" name="inputEmail" class="form-control"
				placeholder="Email address" required="" autofocus="" type="email">
			<label for="inputPassword" class="sr-only">Password</label> <input
				id="inputPassword" name="inputPassword" class="form-control"
				placeholder="Password" required="" type="password">
			<button class="btn btn-lg btn-primary btn-block" type="submit"
				value="Submit">Sign in</button>
		</form>
	</div>
	<!-- /container -->
	<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";

		String email = request.getParameter("inputEmail");
		try {
			con = DriverManager.getConnection(url, uid, pw);
			String SQL = "SELECT empEmail, title FROM Employee WHERE title IN ('AD','SP')";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			ResultSet rst = pstmt.executeQuery();
			while (rst.next()) {
				if (rst.getString("empEmail").equalsIgnoreCase(email)) {
					if (rst.getString("title").equalsIgnoreCase("AD")) {
	%>
	<jsp:forward page="admin.jsp" />
	<%
		} else if (rst.getString("title").equalsIgnoreCase("SP")) {
	%>
	<jsp:forward page="supervisor.jsp" />
	<%
		} else {
	%>
	<h2>You are not an employee!</h2>
	<%
		}
					break;
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
</body>
</html>