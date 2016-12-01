<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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


<link rel="apple-touch-icon" sizes="180x180"
	href="img/fav/apple-touch-icon.png">
<link rel="icon" type="image/png" href="img/fav/favicon-32x32.png"
	sizes="32x32">
<link rel="icon" type="image/png" href="img/fav/favicon-16x16.png"
	sizes="16x16">
<link rel="manifest" href="img/fav/manifest.json">
<link rel="mask-icon" href="img/fav/safari-pinned-tab.svg"
	color="#5bbad5">
<link rel="shortcut icon" href="img/fav/favicon.ico">
<meta name="msapplication-config" content="img/fav/browserconfig.xml">
<meta name="theme-color" content="#ffffff">


<style type="text/css">
:root .carbonad, :root #carbonads-container, :root #content>#right>.dose>.dosesingle,
	:root #content>#center>.dose>.dosesingle {
	display: none !important;
}
</style>
<link rel="stylesheet" type="text/css" href="main.css">

<title>Register</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href=csss/ie10-viewport-bug-workaround.css " rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/signin.css" rel="stylesheet">
<link href="css/carousel.css" rel="stylesheet">

<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
<script src="signin_files/ie-emulation-modes-warning.js"></script>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
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
							<li><a class="active" href="index.html">Home</a></li>
							<li><a href="about.html">About</a></li>
							<li><a href="products.jsp">Products</a></li>
							<li><a href="staff.jsp">Staff</a></li>
						</ul>
						<ul class="nav navbar-nav navbar-right">
							<a href="showcart.jsp" class="btn btn-default navbar-btn"> <span
								class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart
							</a>

						</ul>

					</div>
					<!--/.nav-collapse -->

				</div>
			</nav>

		</div>
	</div>
	<div>
	<input type="button" OnClick="window.location='admin.jsp?view=orders'" value= "View Orders">
	<input type="button" OnClick="window.location='admin.jsp?view=products'" value= "Edit Products">
	</div>
	<script>
		function updateShipment(newId, newShip) {
			window.location = "admin.jsp?view=orders&updateShipment=" + newId
					+ "&newShip=" + newShip;
		}
		function updatePayment(newId, newPay) {
			window.location = "admin.jsp?view=orders&updatePayment=" + newId
					+ "&newPay=" + newPay;
		}
		function updateQty(newId, orderId, newQty) {
			window.location = "admin.jsp?view=orders&updateQty=" + newId
					+ "&orderId=" + orderId + "&newQty=" + newQty;
		}
		function update(newId, newInvent) {
			window.location = "admin.jsp?view=products&update=" + newId
					+ "&newInvent=" + newInvent;
		}
	</script>
	<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
	<%@ page import="java.sql.*"%>
	<form name="listadmin">
		<%
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection con = null;
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
			String uid = "kreid";
			String pw = "39265137";

			String select = request.getParameter("view");

			String updateShipment = request.getParameter("updateShipment");
			String updatePayment = request.getParameter("updatePayment");
			String updateQty = request.getParameter("updateQty");
			String update = request.getParameter("update");
			String newShip = request.getParameter("newShip");
			String newPay = request.getParameter("newPay");
			String newQty = request.getParameter("newQty");
			String newInvent = request.getParameter("newInvent");
			String orderId = request.getParameter("orderId");

			String oid = null;
			String pid = null;
			int ship = 0;
			int pay = 0;
			int qty = 0;
			int invent = 0;

			try {
				con = DriverManager.getConnection(url, uid, pw);
				if (updateShipment != null && (!updateShipment.equals(""))) {
					PreparedStatement up = con.prepareStatement("UPDATE Invoice SET shipType = ? WHERE orderId = ?");
					up.setString(1, newShip);
					up.setString(2, updateShipment);
					up.executeUpdate();
				} else if (updatePayment != null && (!updatePayment.equals(""))) {
					PreparedStatement up = con.prepareStatement("UPDATE Invoice SET paymentType = ? WHERE orderId = ?");
					up.setString(1, newPay);
					up.setString(2, updatePayment);
					up.executeUpdate();
				} else if (updateQty != null && (!updateQty.equals(""))) {
					PreparedStatement old = con.prepareStatement(
							"SELECT quantity FROM OrderedProduct WHERE productId = ? AND orderId = ?");
					old.setString(1, updateQty);
					old.setString(2, orderId);
					ResultSet rstOld = old.executeQuery();
					rstOld.next();
					int oldQ = rstOld.getInt(1);
					int quantity = Integer.parseInt(newQty);
					int difference = quantity - oldQ;

					PreparedStatement up2 = con
							.prepareStatement("SELECT weight, price, Inventory FROM Product WHERE productId = ?");
					up2.setString(1, updateQty);
					ResultSet get = up2.executeQuery();
					get.next();
					Double weight = get.getDouble(1);
					Double price = get.getDouble(2);
					int inventory = get.getInt(3);

					if (quantity > inventory) {
						out.println("<h2>Not enough product in stock<h2>");
					} else {
						PreparedStatement up = con.prepareStatement(
								"UPDATE OrderedProduct SET quantity = ? WHERE productId = ? AND orderId = ?");
						up.setString(1, newQty);
						up.setString(2, updateQty);
						up.setString(3, orderId);
						up.executeUpdate();

						Double NewWeight = difference * weight;
						Double NewPrice = price * difference;
						PreparedStatement newI = con.prepareStatement(
								"UPDATE Invoice SET weight = weight + ?, totalAmount = totalAmount + ? WHERE orderId = ?");
						newI.setDouble(1, NewWeight);
						newI.setDouble(2, NewPrice);
						newI.setString(3, orderId);
						newI.executeUpdate();
					}
				} else if (update != null && (!update.equals(""))) {
					PreparedStatement up = con.prepareStatement("UPDATE Product SET Inventory = ? WHERE productId = ?");
					up.setString(1, newInvent);
					up.setString(2, update);
					up.executeUpdate();
				}

				if ("orders".equalsIgnoreCase(select)) {
					String SQL = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
					PreparedStatement pstmt = con.prepareStatement(SQL);
					ResultSet rst = pstmt.executeQuery();
					out.println("<table id='hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Order Date</b></th>"
							+ "<th><b>Ship Date</b></th><th><b>Ship Type</b></th><th><b>Expected Delivery</b></th>"
							+ "<th><b>Payment Type</b></th><th><b>Total Amount</b></th>");

					while (rst.next()) {
						oid = rst.getString(1);
						pay++;
						ship++;
						out.println("<tr align='center'><td>" + oid + "</td><td>" + rst.getString(3) + "</td><td>"
								+ rst.getString(5) + "</td><td><input type=\"text\" name=\"newShip" + ship
								+ "\" size=\"25\" value=\"" + rst.getString(6) + "\"></td><td>" + rst.getString(7)
								+ "</td><td><input type=\"text\" name=\"newPay" + pay + "\" size= \"25\" value=\""
								+ rst.getString(4) + "\"></td><td>$" + rst.getString(2));
						out.println("<td><input type=BUTTON OnClick=\"updateShipment(" + oid
								+ ", document.listadmin.newShip" + ship + ".value)\"value=\"Update Shipment\"></td>");
						out.println(
								"<td><input type=BUTTON OnClick=\"updatePayment(" + oid + ", document.listadmin.newPay"
										+ pay + ".value)\" value= \"Update Payment\"></td></tr>");
						out.println(
								"<tr align='right'><td colspan='7'><table id='hor-minimalist-b'><th><b>Product Id</b></th><th><b>Product Name</b></th>"
										+ "<th><b>Quantity</b></th><th><b>Price</b></th>");
						String SQL2 = "SELECT O.productId, quantity, O.price, productName FROM OrderedProduct O INNER JOIN Product P ON O.productId = P.productId "
								+ " WHERE orderId = ?";
						PreparedStatement pstmt2 = con.prepareStatement(SQL2);
						pstmt2.setString(1, oid);
						ResultSet rst2 = pstmt2.executeQuery();
						while (rst2.next()) {
							qty++;
							pid = rst2.getString(1);
							out.println("<tr align='center'><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(4)
									+ "</td><td><input type =\"text\" name =\"newQty" + qty + "\" size = \"3\" value=\""
									+ rst2.getString(2) + "\"></td><td>$" + rst2.getDouble(3) + "</td>");
							out.println("<td><input type=BUTTON OnClick=\"updateQty(" + pid + "," + oid
									+ ", document.listadmin.newQty" + qty
									+ ".value)\" value= \"Update Quantity\"></td></tr>");
						}
						out.println("</tbody></table></td></tr>");
					}
					out.println("</tbody></table>");
				} else if ("products".equalsIgnoreCase(select)) {
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
								+ "</td><td><input type=\"text\" name=\"newInvent" + invent + "\" size=\"3\" value=\""
								+ rst.getString("Inventory") + "\"></td><td>" + rst.getString("category") + "</td>");
						out.println("<td><input type=BUTTON OnClick=\"update(" + rst.getString("productId")
								+ ", document.listadmin.newInvent" + invent
								+ ".value)\"value=\"Update Inventory\"></td></tr>");
						if (spec != null) {
							out.println(
									"<tr align='right'><td colspan='6'><table id='hor-minimalist-b'><th><b>Species</b></th>");
							out.println("<tr><td>" + spec + "</td></tr></tbody></table>");
						}
					}
					out.println(
							"<td><input type=BUTTON OnClick=\"window.location='addproduct.jsp'\" value = \"Add New Product\"");
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