<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Fancy Cacti Order Processing</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%
		@SuppressWarnings({"unchecked"})
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		String custId = request.getParameter("inputEmail");
		String pass = request.getParameter("inputPassword");

		try {
			con = DriverManager.getConnection(url, uid, pw);

			String accountCheck = "SELECT email, pass FROM Account WHERE email=?";
			PreparedStatement psAccount = con.prepareStatement(accountCheck);
			psAccount.setString(1, custId);
			ResultSet rstAccount = psAccount.executeQuery();
			if (!(rstAccount.next())) {
				%>

					<script>
						alert("Invalid email! This email is not in our system so there are no orders");
						location.href = "showorder-login.jsp";
					</script>

				<%
		} else {

				if (!pass.equals(rstAccount.getString(3))) {
					%>

						<script>
							alert("Invalid password!");
							location.href = "showorder-login.jsp";
						</script>

					<%
		} else {
			
			String listOrd = "SELECT orderId, totalAmount FROM Invoice WHERE accountEmail=?";
			PreparedStatement psListOrd = con.prepareStatement(listOrd);
			psListOrd.setString(1,custId);
			ResultSet rst = psListOrd.executeQuery();
			out.println(
					"<table id = 'hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Total Amount</b></th>");
			String oid = null;
			while (rst.next()) {
				oid = rst.getString(1);
				out.println("<tr><td>" + rst.getString(1) + "</td><td>" + rst.getString(2) + "</td><td>"
						+ rst.getString(3) + "</td><td>" + rst.getString(4) + "</td></tr>");
				out.println(
						"<tr align='right'><td colspan='4'><table id = 'hor-minimalist-b'><th><b>Product Id</b></th><th><b>Quantity</b></th><th><b>Price</b></th>");
				String SQL2 = "SELECT productId, quantity, price FROM OrderedProduct WHERE orderId=?";
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

