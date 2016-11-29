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
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");
		
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";

		LocalDate localDate = LocalDate.now();
		String ordDate = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(localDate);
		String name = localDate.getDayOfWeek().name();
		int shipAdd = 0;
		if (name.equalsIgnoreCase("friday")) {
			shipAdd = 3;
		} else if (name.equalsIgnoreCase("saturday")) {
			shipAdd = 2;
		} else {
			shipAdd = 1;
		}
		LocalDate shipDate = localDate.plusDays(shipAdd);
		String ship = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(shipDate);
		
		String shipType = request.getParameter("shipping");
		
		int typeAdd = 0;
		double shipCost = 0;
		if (shipType.equals("exp")) {
			typeAdd = 3;
			shipCost = 10.00;
		} else {
			typeAdd = 10;
			shipCost = 3.00;
		}
		
		LocalDate delivDay = shipDate.plusDays(typeAdd);
		name = delivDay.getDayOfWeek().name();
		if (name.equalsIgnoreCase("saturday")) {
			delivDay = delivDay.plusDays(2);
		} else if (name.equalsIgnoreCase("sunday")) {
			delivDay = delivDay.plusDays(1);
		}
		
		String deliv = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(delivDay);
		String custId = request.getParameter("inputEmail");
		String pass = request.getParameter("inputPassword");
		String custName = request.getParameter("inputName");
		String number = request.getParameter("inputNum");
		String BAdd = request.getParameter("inputBAdd");
		String SAdd = request.getParameter("inputSAdd");
		String payment = request.getParameter("inputPay");

		try {
			con = DriverManager.getConnection(url, uid, pw);
			if (productList.isEmpty()) {
				out.println("<h2>Your shopping cart is empty please go back to previos page and try again</h2>");
			} else if(custName != null){
				String check = "SELECT pass FROM Account WHERE email = ?";
				PreparedStatement psCheck = con.prepareStatement(check);
				psCheck.setString(1, custId);
				ResultSet rsCheck = psCheck.executeQuery();
				if (rsCheck.next()) {
				%>

				<script>
					alert("Sorry this email address is already in use! Please use a different email to check out ");
					location.href = "signup.jsp";
				</script>

				<%
				} else {
					String createNew = "INSERT INTO Account VALUES (?, ?, ?, ?, ?, ?, ?, 'Customer')";
					PreparedStatement psCreateNew = con.prepareStatement(createNew);
					psCreateNew.setString(1, custId);
					psCreateNew.setString(2, pass);
					psCreateNew.setString(3, custName);
					if (number.length() == 0)
						psCreateNew.setString(4, null);
					else
						psCreateNew.setString(4, number);
					psCreateNew.setString(5, BAdd);
					psCreateNew.setString(6, SAdd);
					if (payment.length() == 0)
						psCreateNew.setString(7, null);
					else
						psCreateNew.setString(7, payment);
					psCreateNew.executeUpdate();
					
					

					String invoice = "INSERT INTO INVOICE (accountEmail,orderDate, paymentType, shipDate, shipType, expectedDelivery, whouseName)"
							+ "VALUES (?,?,?,?,?,?,'CactiOne')";
					PreparedStatement psInvoice = con.prepareStatement(invoice,
							Statement.RETURN_GENERATED_KEYS);

					psInvoice.setString(1, custId);
					psInvoice.setString(2, ordDate);
					psInvoice.setString(3, payment);
					psInvoice.setString(4, ship);
					psInvoice.setString(5, shipType);
					psInvoice.setString(6, deliv);

					psInvoice.executeUpdate();
					ResultSet keys = psInvoice.getGeneratedKeys();
					keys.next();
					int orderId = keys.getInt(1);
					double totalAmt = shipCost;
					double totalWt = 0;

					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
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
						String insertProd = "INSERT INTO OrderedProduct VALUES(?,?,?,?)";
						String updateProd = "UPDATE Product SET Inventory = Inventory - ? WHERE productId = ?";
						String getWeight = "SELECT weight FROM Product WHERE productID = ?";

						PreparedStatement psGetWeight = con.prepareStatement(getWeight);
						PreparedStatement psInsertProd = con.prepareStatement(insertProd);
						PreparedStatement psUpdateProd = con.prepareStatement(updateProd);

						psGetWeight.setString(1, productId);

						psInsertProd.setString(1, productId);
						psInsertProd.setInt(2, orderId);
						psInsertProd.setInt(3, qty);
						psInsertProd.setDouble(4, pr);

						psUpdateProd.setInt(1, qty);
						psUpdateProd.setString(2, productId);

						psInsertProd.executeUpdate();
						psUpdateProd.executeUpdate();
						ResultSet weight = psGetWeight.executeQuery();
						weight.next();

						totalAmt += qty * pr;
						totalWt += weight.getDouble(1);
						out.println("<tr><td>" + productId + "</td><td>" + product.get(1) + "</td><td>" + qty
								+ "</td><td>" + pr + "</td><td>" + qty * pr + "</td></tr>");

					}
					
					out.println("<tr><td colspan='4'>Shipping Cost </td><td>" + shipCost
							+  "</td></tr>");

					totalAmt = Math.round(totalAmt * 100.0) / 100.0;
					
					out.println("<tr><td colspan='4'><b>Order Total </b></td><td>" + totalAmt
							+  "</td></tr></table>");
					String upOrd = "UPDATE Invoice SET totalAmount = ?, weight=? WHERE orderId = ?";
					PreparedStatement pord = con.prepareStatement(upOrd);
					
					
					pord.setDouble(1, totalAmt);
					pord.setDouble(2, totalWt);
					pord.setInt(3, orderId);
					pord.executeUpdate();

					out.println("<h2>Order Completed. Will be shipped on "+ ship +"</h2>");
					out.println("<h2>Your expected delivery date is "+ deliv +"</h2>");
					out.println("<h2>Your reference number is: " + orderId + "</h2>");
					out.println("<h2>Shipping to customer: " + custName + "</h2>");
					session.setAttribute("productList", null);
					}
				
			}
			else {
				String accountCheck = "SELECT email, fullName, pass, preferredPayment FROM Account WHERE email=?";
				PreparedStatement psAccount = con.prepareStatement(accountCheck);
				psAccount.setString(1, custId);
				ResultSet rstAccount = psAccount.executeQuery();
				if (!(rstAccount.next())) {
					%>

					<script>
						alert("Invalid email! Please use a different email to check out ");
						location.href = "checkout.jsp";
					</script>

					<%
				}
				else{
					
					payment = rstAccount.getString(4);
					if (!pass.equals(rstAccount.getString(3))) {
						%>
						<script>
							alert("Invalid password!");
							location.href = "checkout.jsp";
						</script>	<%
						
					}
					else{

						String invoice = "INSERT INTO INVOICE (accountEmail,orderDate, paymentType, shipDate, shipType, expectedDelivery, whouseName)"
								+ "VALUES (?,?,?,?,?,?,'CactiOne')";
						PreparedStatement psInvoice = con.prepareStatement(invoice,
								Statement.RETURN_GENERATED_KEYS);

						psInvoice.setString(1, custId);
						psInvoice.setString(2, ordDate);
						psInvoice.setString(3, payment);
						psInvoice.setString(4, ship);
						psInvoice.setString(5, shipType);
						psInvoice.setString(6, deliv);

						psInvoice.executeUpdate();
						ResultSet keys = psInvoice.getGeneratedKeys();
						keys.next();
						int orderId = keys.getInt(1);
						double totalAmt = shipCost;
						double totalWt = 0;

						Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
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
							String insertProd = "INSERT INTO OrderedProduct VALUES(?,?,?,?)";
							String updateProd = "UPDATE Product SET Inventory = Inventory - ? WHERE productId = ?";
							String getWeight = "SELECT weight FROM Product WHERE productID = ?";

							PreparedStatement psGetWeight = con.prepareStatement(getWeight);
							PreparedStatement psInsertProd = con.prepareStatement(insertProd);
							PreparedStatement psUpdateProd = con.prepareStatement(updateProd);

							psGetWeight.setString(1, productId);

							psInsertProd.setString(1, productId);
							psInsertProd.setInt(2, orderId);
							psInsertProd.setInt(3, qty);
							psInsertProd.setDouble(4, pr);

							psUpdateProd.setInt(1, qty);
							psUpdateProd.setString(2, productId);

							psInsertProd.executeUpdate();
							psUpdateProd.executeUpdate();
							ResultSet weight = psGetWeight.executeQuery();
							weight.next();

							totalAmt += qty * pr;
							totalWt += weight.getDouble(1);
							out.println("<tr><td>" + productId + "</td><td>" + product.get(1) + "</td><td>" + qty
									+ "</td><td>" + pr + "</td><td>" + qty * pr + "</td></tr>");

						}
						
						out.println("<tr><td colspan='4'>Shipping Cost </td><td>" + shipCost
								+  "</td></tr>");

						totalAmt = Math.round(totalAmt * 100.0) / 100.0;
						
						out.println("<tr><td colspan='4'><b>Order Total </b></td><td>" + totalAmt
								+  "</td></tr></table>");
						String upOrd = "UPDATE Invoice SET totalAmount = ?, weight=? WHERE orderId = ?";
						PreparedStatement pord = con.prepareStatement(upOrd);
						
						
						pord.setDouble(1, totalAmt);
						pord.setDouble(2, totalWt);
						pord.setInt(3, orderId);
						pord.executeUpdate();

						out.println("<h2>Order Completed. Will be shipped on "+ ship +"</h2>");
						out.println("<h2>Your expected delivery date is "+ deliv +"</h2>");
						out.println("<h2>Your reference number is: " + orderId + "</h2>");
						out.println("<h2>Shipping to customer: " + rstAccount.getString("fullName") + "</h2>");
						session.setAttribute("productList", null);
					}
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

