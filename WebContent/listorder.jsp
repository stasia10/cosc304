<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Fancy Cacti Order List</title>
</head>
<style>
#hor-minimalist-b {
	font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
	font-size: 12px;
	background: #fff;
	width: 480px;
	border-collapse: collapse;
	text-align: center;
}

#hor-minimalist-b th {
	font-size: 13px;
	font-weight: normal;
	color: #000;
	border-bottom: 2px solid #6678b1;
}

#hor-minimalist-b td {
	border-bottom: 1px solid #ccc;
	color: #000;
	padding: 6px 8px;
}

#hor-minimalist-b tbody tr:hover td {
	color: #000;
}
</style>
<body>

	<h1><font face = "Sans-Serif">Order List</font></h1>

	<%@ page import="java.sql.*"%>
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
		try {
			con = DriverManager.getConnection(url, uid, pw);
			String SQL = "SELECT orderId, accountUsername, fullName, totalAmount FROM Invoice i, Account a WHERE i.accountUsername=a.username";
			PreparedStatement pstmt = con.prepareStatement(SQL);
			ResultSet rst = pstmt.executeQuery();
			out.println(
					"<table id = 'hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Customer Id</b></th><th><b>Customer Name</b></th><th><b>Total Amount</b></th>");
			String oid = null;
			while (rst.next()) {
				oid = rst.getString(1);
				out.println("<tr><td>" + rst.getString(1) + "</td><td>" + rst.getString(2) + "</td><td>"
						+ rst.getString(3) + "</td><td>" + rst.getString(4) + "</td></tr>");
				out.println(
						"<tr align='right'><td colspan='4'><table id = 'hor-minimalist-b'><th><b>Product Id</b></th><th><b>Quantity</b></th><th><b>Price</b></th>");
				String SQL2 = "SELECT productId, quantity, price FROM OrderedProduct as o, Product as p WHERE o.productId=p.productId AND orderId=?";
				PreparedStatement pstmt2 = con.prepareStatement(SQL2);
				pstmt2.setString(1, oid);
				ResultSet rst2 = pstmt2.executeQuery();
				while (rst2.next()) {
					out.println("<tr><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(2) + "</td><td>"
							+ rst2.getString(3) + "</td></tr>");
				}
				out.println("</tbody></table></td></tr>");
			}
			out.println("</table>");
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

