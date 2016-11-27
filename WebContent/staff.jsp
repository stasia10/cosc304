<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="main.css">
<title>Manager/Supervisor Page</title>
</head>
<body>
	<div class="container">

		<form class="form-signin">
			<h2 class="form-signin-heading">Please sign in</h2>
			<label for="inputEmail" class="sr-only">Email address</label> <input
				id="inputEmail" class="form-control" placeholder="Email address"
				required="" autofocus="" type="email"> <label
				for="inputPassword" class="sr-only">Password</label> <input
				id="inputPassword" class="form-control" placeholder="Password"
				required="" type="password">
			<button class="btn btn-lg btn-primary btn-block" type="submit">Sign
				in</button>
		</form>
	</div>
	<!-- /container -->
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";

		String email = request.getParameter("inputEmail");
		String pass = request.getParameter("inputPassword");
		try {
			con = DriverManager.getConnection(url, uid, pw);
			String SQL = "SELECT email FROM Account WHERE ? IN (SELECT email FROM Account WHERE accountType = 'Admin'";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, "'" + email + "'");
			ResultSet rst = pstmt.executeQuery();
			while (rst.next()) {
				if (rst.next() == false) {
					String SQL2 = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
					PreparedStatement pstmt2 = con.prepareStatement(SQL2);
					ResultSet rst2 = pstmt2.executeQuery();
					out.println(
							"<table id = 'hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Order Date</b></th>"
									+ "<th><b>Ship Date</b></th><th><b>Ship Type</b></th><th><b>Expected Delivery</b></th>"
									+ "<th><b>Payment Type</b></th><th><b>Total Amount</b></th>");
					String oid = null;
					while (rst2.next()) {
						oid = rst2.getString(1);
						out.println("<tr><td>" + oid + "</td><td>" + rst2.getString(3) + "</td><td>"
								+ rst2.getString(5) + "</td><td>" + rst2.getString(6) + "</td><td>"
								+ rst2.getString(7) + "</td><td>" + rst2.getString(4) + "</td><td>$"
								+ rst2.getString(2) + "</tr>");
						out.println(
								"<tr align='right'><td colspan='4'><table id = 'hor-minimalist-b'><th><b>Product Id</b></th>"
										+ "<th><b>Quantity</b></th>");
						String SQL3 = "SELECT productId, quantity FROM OrderedProduct WHERE orderId = ?";
						PreparedStatement pstmt3 = con.prepareStatement(SQL3);
						pstmt3.setString(1, oid);
						ResultSet rst3 = pstmt3.executeQuery();
						while (rst3.next()) {
							out.println("<tr><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(2)
									+ "</td></tr>");
						}
						out.println("</tbody></table></td></tr>");
					}
					out.println("</tbody></table>");
				} else {
					String SQL2 = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
					PreparedStatement pstmt2 = con.prepareStatement(SQL2);
					ResultSet rst2 = pstmt2.executeQuery();
					out.println(
							"<table id = 'hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Order Date</b></th>"
									+ "<th><b>Ship Date</b></th><th><b>Ship Type</b></th><th><b>Expected Delivery</b></th>"
									+ "<th><b>Payment Type</b></th><th><b>Total Amount</b></th>");
					String oid = null;
					while (rst2.next()) {
						oid = rst2.getString(1);
						out.println("<tr><td>" + oid + "</td><td>" + rst2.getString(3) + "</td><td>"
								+ rst2.getString(5) + "</td><td>" + rst2.getString(6) + "</td><td>"
								+ rst2.getString(7) + "</td><td>" + rst2.getString(4) + "</td><td>$"
								+ rst2.getString(2) + "</tr>");
						out.println(
								"<tr align='right'><td colspan='4'><table id = 'hor-minimalist-b'><th><b>Product Id</b></th>"
										+ "<th><b>Quantity</b></th>");
						String SQL3 = "SELECT productId, quantity FROM OrderedProduct WHERE orderId = ?";
						PreparedStatement pstmt3 = con.prepareStatement(SQL3);
						pstmt3.setString(1, oid);
						ResultSet rst3 = pstmt3.executeQuery();
						while (rst3.next()) {
							out.println("<tr><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(2)
									+ "</td></tr>");
						}
						out.println("</tbody></table></td></tr>");
					}
					out.println("</tbody></table>");
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