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

				if (!pass.equals(rstAccount.getString(2))) {
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
					"<table id = 'hor-minimalist-b'><tbody><th align = 'left' colspan = '2'><b>Order Id</b></th>");
			String oid = null;
			int rowcount = 0;
			while (rst.next()) {
				rowcount++;
				oid = rst.getString(1);
				out.println("<tr><td colspan = '2'>" + rst.getString(1) + "</td>");
				out.println(
						"<tr><td colspan='2' align='right'><table id = 'hor-minimalist-b'><th><b>Product Id</b></th><th><b>Quantity</b></th><th><b>Price</b></th>");
				String SQL2 = "SELECT p.productName, o.quantity, o.price FROM OrderedProduct as O, Product as P WHERE o.productId = p.productId AND orderId=?";
				PreparedStatement pstmt2 = con.prepareStatement(SQL2);
				pstmt2.setString(1, oid);
				ResultSet rst2 = pstmt2.executeQuery();
				while (rst2.next()) {
					out.println("<tr><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(2) + "</td><td>"
							+ rst2.getString(3) + "</td></tr>");
				}
				out.println("</table></td></tr>");
				out.println("<tr><td align = 'left' colspan='2'><b>Total Amount</b></td>");
				out.println("<tr><td  align = 'left' colspan='2'>"+rst.getString(2)+"</b></td>");
			}
			if(rowcount == 0){
				out.println("<tr><td colspan = '2'> You have no previous orders </td></tr>");
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

