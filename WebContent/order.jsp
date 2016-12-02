<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="img/fav/favicon.ico">

<title>Order Placed</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href="css/ie10-viewport-bug-workaround.css" rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="js/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- Custom styles for this template -->
<link href="css/carousel.css" rel="stylesheet">
</head>
<!-- NAVBAR
================================================== -->
<body>
	<div class="navbar-wrapper">
		<div class="container">

			<!-- Fixed navbar -->
			<nav class="navbar navbar-default navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">

						<a class="navbar-brand" href="index.html">Fancy Cacti</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li><a href="index.html">Home</a></li>
							<li><a href="about.html">About</a></li>
							<li><a href="products.jsp">Products</a></li>
							<li><a href="staff.jsp">Staff</a></li>
									<li><a href="showorder-login.jsp">Purchases</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<a href="showcart.jsp" class="btn btn-default navbar-btn active"> <span
								class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart
							</a>

						</ul>

					</div>
					<!--/.nav-collapse -->

				</div>
			</nav>

		</div>
	</div>
	<!-- Marketing messaging and featurettes
    ================================================== -->
	<!-- Wrap the rest of the page in another container to center all the content. -->
	<div class="container marketing">
		<div class="formpadding">
			
	<%
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");
		
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
		
		NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		
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
			shipCost = 0.00;
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
					StringBuilder ORDER = new StringBuilder();
					int orderId = keys.getInt(1);
					double totalAmt = shipCost;
					double totalWt = 0;

					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
					
					// Header
					ORDER.append("<h1>Order Summary:</h1>");
					// Order Info
					ORDER.append("<p>Thank You for shopping with us: " + custName);
					ORDER.append("<br>Your order is placed and will be shipped on: "+ ship );
					ORDER.append("<br>Your expected delivery date is: "+ deliv );
					ORDER.append("<br>Your order number is: " + orderId );
					ORDER.append("</p>");
					// Table Header
					ORDER.append("<div class=\"table\">");
					ORDER.append("<table class=\"table table-hover\">");
					ORDER.append("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
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
						ORDER.append("<tr><td>" + productId + "</td><td>" + product.get(1) + "</td><td>" + qty
								+ "</td><td>$" + pr + "</td><td>$" + qty * pr + "</td></tr>");

					}
					
					ORDER.append("<tr><td>Shipping Cost </td><td>$" + shipCost +  "</td></tr>");

					
					ORDER.append("<tr><td><b>Order Total </b></td><td>" + currFormat.format(totalAmt)
							+  "</td></tr></table>");
					String upOrd = "UPDATE Invoice SET totalAmount = ?, weight=? WHERE orderId = ?";
					PreparedStatement pord = con.prepareStatement(upOrd);
					
					
					pord.setDouble(1, totalAmt);
					pord.setDouble(2, totalWt);
					pord.setInt(3, orderId);
					pord.executeUpdate();
					
					out.print(ORDER.toString());
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
						StringBuilder ORDER = new StringBuilder();
						Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
						// Header
						ORDER.append("<h1>Order Summary:</h1>");
						// Order Info
						custName = rstAccount.getString(2);
						ORDER.append("<p>Thank you for shopping with us: " + custName);
						ORDER.append("<br>Your order is placed and will be shipped on: "+ ship );
						ORDER.append("<br>Your expected delivery date is: "+ deliv );
						ORDER.append("<br>Your order number is: " + orderId );
						ORDER.append("</p>");
						// Table Header
						ORDER.append("<div class=\"table\">");
						ORDER.append("<table class=\"table table-hover\">");
						ORDER.append("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
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
							ORDER.append("<tr><td>" + productId + "</td><td>" + product.get(1) + "</td><td>" + qty
									+ "</td><td>$" + pr + "</td><td>$" + qty * pr + "</td></tr>");

						}
						
						ORDER.append("<tr><td>Shipping Cost </td><td>$" + shipCost +  "</td></tr>");
						
						ORDER.append("<tr><td><b>Order Total </b></td><td>" + currFormat.format(totalAmt)
								+  "</td></tr></table>");
						String upOrd = "UPDATE Invoice SET totalAmount = ?, weight=? WHERE orderId = ?";
						PreparedStatement pord = con.prepareStatement(upOrd);
						
						
						pord.setDouble(1, totalAmt);
						pord.setDouble(2, totalWt);
						pord.setInt(3, orderId);
						pord.executeUpdate();
						out.print(ORDER.toString());
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
	
			</div>
			<footer>
				<p class="pull-right">
					<a href="#">Back to top</a>
				</p>
				<p>
					&copy; 2016 Fancy Cacti, Inc. &middot; <a href="privacy.html">Privacy</a>
					&middot; <a href="legal.html">Legal</a>
				</p>
			</footer>
		
	</div>
</body>
<!-- /container -->
<script src="signin_files/ie10-viewport-bug-workaround.js"></script>

</html>
