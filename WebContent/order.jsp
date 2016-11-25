<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Fancy Cacti Order Processing</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%
		// Get customer id
		String custId = request.getParameter("customerId");
		String pass = request.getParameter("password");
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";

		try {
			con = DriverManager.getConnection(url, uid, pw);
			if (productList.isEmpty()) {
				out.println("<h2>Your shopping cart is empty please go back tp previos page and try again</h2>");
			} else {
				if (custId.matches("[0-9]+")) {
					String SQL = "select customerId, cname, password from Customer where customerId=?";
					PreparedStatement pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, custId);
					ResultSet rst = pstmt.executeQuery();
					if (rst.next()) {
						if (pass.equals(rst.getString(3))) {
							String order = "INSERT INTO Orders (customerId) VALUES (?)";
							PreparedStatement pstmt1 = con.prepareStatement(order, Statement.RETURN_GENERATED_KEYS);
							pstmt1.setString(1, custId);
							pstmt1.executeUpdate();
							ResultSet keys = pstmt1.getGeneratedKeys();
							keys.next();
							int orderId = keys.getInt(1);
							double total = 0;

							Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet()
									.iterator();
							out.println("<h1>Your Order Summary</h1>");
							out.println(
									"<table><tr><td>Product Id</td><td>Product Name</td><td>Quantity</td><td>Price</td><td>Subtotal</td></tr>");
							while (iterator.hasNext()) {
								Map.Entry<String, ArrayList<Object>> entry = iterator.next();
								ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
								String productId = (String) product.get(0);
								String price = (String) product.get(2);
								double pr = Double.parseDouble(price);
								int qty = ((Integer) product.get(3)).intValue();
								String s = "INSERT INTO OrderedProduct VALUES(?,?,?,?)";
								String u = "UPDATE Product SET Inventory = Inventory - ? WHERE productId = ?";
								PreparedStatement ps = con.prepareStatement(s);
								PreparedStatement pu = con.prepareStatement(u);
								ps.setInt(1, orderId);
								ps.setString(2, productId);
								ps.setInt(3, qty);
								ps.setDouble(4, pr);
								ps.executeUpdate();
								pu.setInt(1, qty);
								pu.setString(2, productId);
								total += qty * pr;
								out.println("<tr><td>" + productId + "</td><td>" + product.get(1) + "</td><td>"
										+ qty + "</td><td>" + pr + "</td><td>" + qty * pr + "</td></tr>");
							}

							out.println("<tr><td colspan='4'><b>Order Total</b></td><td>" + total
									+ "</td></tr></table>");
							String upOrd = "UPDATE Orders SET totalAmount = ? WHERE orderId = ?"; 
							PreparedStatement pord = con.prepareStatement(upOrd);
							pord.setDouble(1, total);
							pord.setInt(2, orderId);
							pord.executeUpdate();

							out.println("<h2>Order Completed. Will be shipped soon...</h2>");
							out.println("<h2>Your reference number is: " + orderId + "</h2>");
							out.println("<h2>Shipping to customer: " + custId + " Name: " + rst.getString("cname")
									+ "</h2>");
							session.setAttribute("productList", null);
						} else {
							out.println(
									"<h1> You have entered the wrong password please go back to the previous page and try again.</h1>");
						}
					} else {
						out.println("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
					}
				} else {
					out.println("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
				}
			}
		}

		catch (SQLException ex) {
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

