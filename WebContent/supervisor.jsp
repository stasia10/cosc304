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
	<%
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	Connection con = null;
	String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
	String uid = "kreid";
	String pw = "39265137";
	%>
	<div>
		<a href="supervisor.jsp?view=orders">View Orders</a> <a
			href="supervisor.jsp?view=products">Edit Products</a>
	</div>
	<script>
		function update(newId, newInvent) {
			window.location = "supervisor.jsp?view=products&update=" + newId
					+ "&newInvent=" + newInvent;
		}
	</script>
	<form name="listsuper">
		<%
			String update = request.getParameter("update");
			String newInvent = request.getParameter("newInvent");
			String select = request.getParameter("view");
			int invent = 0;
			try {
				con = DriverManager.getConnection(url, uid, pw);
				if (update != null && (!update.equals(""))){
					PreparedStatement up = con
							.prepareStatement("UPDATE Product SET Inventory = ? WHERE productId = ?");
					up.setString(1, newInvent);
					up.setString(2, update);
					up.executeUpdate();
				}
				if ("products".equalsIgnoreCase(select)) {
					String SQL = "SELECT * FROM Product";
					PreparedStatement pstmt = con.prepareStatement(SQL);
					ResultSet rst = pstmt.executeQuery();
					out.println(
							"<table id='hor-minimalist-b'><tbody><th><b>Product Id</b></th><th align='center'><b>Product Name</b></th>"
									+ "<th><b>Weight</b></th><th><b>Price</b></th><th><b>Inventory</b></th>"
									+ "<th><b>Category</b></th>");
					String spec = null;
					while (rst.next()) {
						invent++;
						spec = rst.getString("species");
						out.println("<tr><td>" + rst.getString("productId") + "</td><td>" + rst.getString("productName")
								+ "</td><td>" + rst.getString("weight") + "</td><td>$" + rst.getString("price")
								+ "</td><td><input type=\"text\" name=\"newInvent" + invent + "\" size=\"3\" value=\"" + rst.getString("Inventory") 
								+ "\"></td><td>" + rst.getString("category") + "</td>");
						out.println("<td><input type=BUTTON OnClick=\"update(" + rst.getString("productId")
								+ ", document.listsuper.newInvent" + invent + ".value)\"value=\"Update Inventory\"></td></tr>");
						if (spec != null) {
							out.println(
									"<tr align='right'><td colspan='6'><table id='hor-minimalist-b'><th><b>Species</b></th>");
							out.println("<tr><td>" + spec + "</td></tr></tbody></table>");
						}
					}
					out.println("</tbody></table>");
				} else if ("orders".equalsIgnoreCase(select))	{
					String SQL = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
					PreparedStatement pstmt = con.prepareStatement(SQL);
					ResultSet rst = pstmt.executeQuery();
					out.println("<table id='hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Order Date</b></th>"
							+ "<th><b>Ship Date</b></th><th><b>Ship Type</b></th><th><b>Expected Delivery</b></th>"
							+ "<th><b>Payment Type</b></th><th><b>Total Amount</b></th>");
					String oid = null;

					while (rst.next()) {
						oid = rst.getString(1);
						out.println("<tr align='center'><td>" + oid + "</td><td>" + rst.getString(3) + "</td><td>"
								+ rst.getString(5) + "</td><td>" + rst.getString(6) + "</td><td>" + rst.getString(7)
								+ "</td><td>" + rst.getString(4) + "</td><td>$" + rst.getString(2));
						out.println(
								"<tr align='right'><td colspan='7'><table id='hor-minimalist-b'><th><b>Product Id</b></th><th><b>Product Name</b></th>"
										+ "<th><b>Quantity</b></th><th><b>Price</b></th>");
						String SQL3 = "SELECT O.productId, quantity, O.price, productName FROM OrderedProduct O INNER JOIN Product P ON O.productId = P.productId "
								+ " WHERE orderId = ?";
						PreparedStatement pstmt2 = con.prepareStatement(SQL3);
						pstmt2.setString(1, oid);
						ResultSet rst2 = pstmt2.executeQuery();
						while (rst2.next()) {
							out.println("<tr align='center'><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(4)
									+ "</td><td>" + rst2.getString(2) + "</td><td>$" + rst2.getDouble(3) + "</td>");
						}
						out.println("</tbody></table></td></tr>");
					}
					out.println("</tbody></table>");
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
	</form>
</body>
</html>