<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<title>Fancy Cacti Products</title>
</head>
<body>

	<h1>
		<font face="Sans-Serif">Search for the products you want to
			buy:</font>
	</h1>

	<form method="get" action="listprod.jsp">
		<input type="text" name="productName" size="50"> <input
			type="submit" value="Submit"><input type="reset"
			value="Reset"><font face="Sans-Serif"> (Leave blank
			for all products) </font>
	</form>

	<%@ page import="java.sql.*"%>
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
		String name = request.getParameter("productName");

		try {
			con = DriverManager.getConnection(url, uid, pw);
			boolean hasName = (name != null && !name.equals(""));
			if (hasName) {
				out.println("<h2><font face = 'Sans-Serif'>Products containing '" + name + "'</font></h2>");
				out.println(
						"<table id = 'hor-minimalist-b'><tbody><th></th><th><b>Category</b></th><th><b>Product Name</b></th><th><b>Price</b></th>");
				String SQL = "SELECT productName, price, productId, category FROM Product WHERE productName LIKE ? AND Inventory > 0 ORDER BY productName";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, "%" + name + "%");
				ResultSet rst = pstmt.executeQuery();
				out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getString(3) + "&name=" + rst.getString(1)
					+ "&price=" + rst.getString(2) + "\">Add to cart</a>" + "</td><td>" + rst. getString(4) + "</td><td>" + rst.getString(1)
					+ "</td><td>" + rst.getString(2) + "</td></tr>");
				while (rst.next()) {
					String SQL2 = "SELECT species FROM Product WHERE category = 'CS'";
					PreparedStatement pstmt2 = con.prepareStatement(SQL2);
					ResultSet rst2 = pstmt2.executeQuery();
					while(rst2.next()) {
						out.println("<tr align='right'><td colspan='4'><table id = 'hor-minimalist-b'><tbody><th></th><th><b>Species</b></th>");
						out.println("<td>" + rst2.getString(1) + "</td></tbody></table>");
					}
				}
				out.println("</tbody></table>");
			} else {
				out.println("<h2><font face = 'Sans-Serif'>All Products</font></h2>");
				out.println(
						"<table id = 'hor-minimalist-b'><tbody><th></th><th><b>Category</b></th><th><b>Product Name</b></th><th><b>Price</b></th>");
				String SQL = "SELECT productName, price, productId, category FROM Product WHERE Inventory > 0 ORDER BY productName";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				ResultSet rst = pstmt.executeQuery();
				out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getString(3) + "&name=" + rst.getString(1)
					+ "&price=" + rst.getString(2) + "\">Add to cart</a>" + "</td><td>" + rst. getString(4) + "</td><td>" + rst.getString(1)
					+ "</td><td>" + rst.getString(2) + "</td></tr>");
				while (rst.next()) {
					String SQL2 = "SELECT species FROM Product WHERE category = 'CS'";
					PreparedStatement pstmt2 = con.prepareStatement(SQL2);
					ResultSet rst2 = pstmt2.executeQuery();
					while(rst2.next()) {
						out.println("<tr align='right'><td colspan='4'><table id = 'hor-minimalist-b'><tbody><th></th><th><b>Species</b></th>");
						out.println("<td>" + rst2.getString(1) + "</td></tbody></table>");
					}
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
</body>
</html>