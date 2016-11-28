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
<link rel="stylesheet" type="text/css" href="main.css">
<title>Supervisor Page</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href=csss/ie10-viewport-bug-workaround.css " rel="stylesheet">

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
	<script>
		function updateShipment(newId, newShip){
			window.location = "admin.jsp?updateShipment=\"" + newId + "\"&newShip=\"" + newShip;
		}
	</script>
	<form name="listprod">
		<%
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection con = null;
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
			String uid = "kreid";
			String pw = "39265137";

			try {
				con = DriverManager.getConnection(url, uid, pw);
				String SQL = "SELECT * FROM Product";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				ResultSet rst = pstmt.executeQuery();
				out.println(
						"<table id='hor-minimalist-b'><tbody><th><b>Product Id</b></th><th align='center'><b>Product Name</b></th>"
								+ "<th><b>Weight</b></th><th><b>Price</b></th><th><b>Inventory</b></th>"
								+ "<th><b>Category</b></th>");
				String spec = null;
				while (rst.next()) {
					spec = rst.getString("species");
					out.println("<tr><td>" + rst.getString("productId") + "</td><td>" + rst.getString("productName")
							+ "</td><td>" + rst.getString("weight") + "</td><td>$" + rst.getString("price")
							+ "</td><td>" + rst.getString("Inventory") + "</td><td>" + rst.getString("category")
							+ "</td></tr>");
					if (spec != null) {
						out.println(
								"<tr align='right'><td colspan='6'><table id='hor-minimalist-b'><th><b>Species</b></th>");
						out.println("<tr><td>" + spec + "</td></tr></tbody></table>");
					}
				}
				out.println("</tbody></table>");
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
	</form>
</body>
</html>