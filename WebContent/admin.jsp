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

<title>Admin Page</title>

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
							<li><a href="index.html">Home</a></li>
							<li><a href="about.html">About</a></li>
							<li><a href="products.jsp">Products</a></li>
							<li class="active"><a href="staff.jsp">Staff</a></li>
							<li><a href="showorder-login.jsp">Purchases</a></li>
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

	<div class="container marketing">
		<div class="formpadding">
			<div class="form-group row">
				<div class="col-m-10">
					<button class="btn btn-lg btn-register btn-block" type="button"
						OnClick="window.location='admin.jsp?view=orders'"
						value="Edit Orders">Edit Orders</button>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-m-10">
					<a class="btn btn-lg btn-block btn-register"
						OnClick="window.location='admin.jsp?view=products'"
						value="Edit Products">Edit Products</a>
				</div>
			</div>


			<div class="form-group row">
				<div class="col-m-10">
					<a class="btn btn-lg btn-block btn-register" href="addproduct.jsp"
						value="Add New Product">Add Product</a>
				</div>
			</div>
		</div>

		<script>
			function updateShipment(newId, newShip) {
				window.location = "admin.jsp?view=orders&updateShipment="
						+ newId + "&newShip=" + newShip;
			}
			function updatePayment(newId, newPay) {
				window.location = "admin.jsp?view=orders&updatePayment="
						+ newId + "&newPay=" + newPay;
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
				String delete = request.getParameter("delete");

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

						PreparedStatement up2 = con
								.prepareStatement("SELECT weight, price, Inventory FROM Product WHERE productId = ?");
						up2.setString(1, updateQty);
						ResultSet get = up2.executeQuery();
						get.next();
						Double weight = get.getDouble(1);
						Double price = get.getDouble(2);
						int inventory = get.getInt(3);

						if (quantity > inventory) {
			%>
			<script>
				alert("Sorry there is not enough of this item in stock!");
			</script>
			<%
				} else if (quantity < 0 || quantity < oldQ) {
							PreparedStatement up = con.prepareStatement(
									"UPDATE OrderedProduct SET quantity = ? WHERE productId = ? AND orderId = ?");
							up.setString(1, newQty);
							up.setString(2, updateQty);
							up.setString(3, orderId);
							up.executeUpdate();

							int difference = oldQ + quantity;

							Double NewWeight = difference * weight;
							Double NewPrice = price * difference;

							PreparedStatement newI = con.prepareStatement(
									"UPDATE Invoice SET weight = weight + ?, totalAmount = totalAmount - ? WHERE orderId = ?");
							newI.setDouble(1, NewWeight);
							newI.setDouble(2, NewPrice);
							newI.setString(3, orderId);
							newI.executeUpdate();
						} else {
							PreparedStatement up = con.prepareStatement(
									"UPDATE OrderedProduct SET quantity = ? WHERE productId = ? AND orderId = ?");
							up.setString(1, newQty);
							up.setString(2, updateQty);
							up.setString(3, orderId);
							up.executeUpdate();

							int difference = quantity - oldQ;
							if (difference < 0) {
								difference = difference * -1;
							}

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
					} else if (delete != null && (!delete.equals(""))) {
						PreparedStatement del = con.prepareStatement("DELETE FROM Product WHERE productId = ?");
						del.setString(1, delete);
						del.executeUpdate();
					}

					if ("orders".equalsIgnoreCase(select)) {
						StringBuilder ORD = new StringBuilder();
						String SQL = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
						PreparedStatement pstmt = con.prepareStatement(SQL);
						ResultSet rst = pstmt.executeQuery();
					// Starting the class and the header of the first table
						
						while (rst.next()) {
							oid = rst.getString(1);
							pay++;
							ship++;
							// First table body
							ORD.append("<div class=\"table-responsive \">");
						ORD.append("<table class=\"table table-hover\">");
						ORD.append(
								"<thead><tr><th> Order Id </th><th> Order Date </th><th> Ship Date </th><th> Shipment Type </th><th> ETA </th><th> Payment Type </th><th>Total</th></tr></thead>");

							ORD.append("<tbody><tr><td>" + oid + "</td><td>" + rst.getString(3) + "</td><td>");
							ORD.append(rst.getString(5) + "</td><td><input type=\"text\" name=\"newShip" + ship);
							ORD.append("\" size=\"11\" value=\"" + rst.getString(6) + "\"></td><td>" + rst.getString(7));
							ORD.append("</td><td><input type=\"text\" name=\"newPay" + pay + "\" size= \"20\" value=\"");
							ORD.append(rst.getString(4) + "\"></td><td>$" + rst.getString(2));
							ORD.append("<td><input type=BUTTON OnClick=\"updateShipment(" + oid);
							ORD.append(", document.listadmin.newShip" + ship + ".value)\"value=\"Update Shipment\"></td>");
							ORD.append("<td><input type=BUTTON OnClick=\"updatePayment(" + oid + ", document.listadmin.newPay");
							ORD.append( pay + ".value)\" value= \"Update Payment\"></td></tr>");
							ORD.append("</tbody></table>");
							// Heading of the sub table
							ORD.append("<table class = \"table table hover\"><thead><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th></tr></thead>");
							String SQL2 = "SELECT O.productId, quantity, O.price, productName FROM OrderedProduct O INNER JOIN Product P ON O.productId = P.productId "
									+ " WHERE orderId = ?";
							PreparedStatement pstmt2 = con.prepareStatement(SQL2);
							pstmt2.setString(1, oid);
							ResultSet rst2 = pstmt2.executeQuery();
							while (rst2.next()) {
								qty++;
								pid = rst2.getString(1);
								ORD.append("<tbdody><tr><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(4)
										+ "</td><td><input type =\"text\" name =\"newQty" + qty + "\" size = \"3\" value=\""
										+ rst2.getString(2) + "\"></td><td>$" + rst2.getDouble(3) + "</td>");
								ORD.append("<td><input type=BUTTON OnClick=\"updateQty(" + pid + "," + oid
										+ ", document.listadmin.newQty" + qty
										+ ".value)\" value= \"Update Quantity\"></td></tr>");
							}
							ORD.append("</tbody></table></div>");
						}
					
						out.print(ORD.toString());
					} else if ("products".equalsIgnoreCase(select)) {
						// PLT = Product Listing Table
						StringBuilder PLT = new StringBuilder(1000);
						String SQL = "SELECT * FROM Product";
						PreparedStatement pstmt = con.prepareStatement(SQL);
						ResultSet rst = pstmt.executeQuery();

						PLT.append("<div class=\"table-responsive\">");
						PLT.append("<table class=\"table table-hover\">");
						PLT.append(
								" <thead><tr><th> Product Id </th><th> Product Name </th><th> Weight </th><th> Price </th><th> Inventory </th><th> Category </th></tr></thead>");

						String spec = null;
						while (rst.next()) {
							invent++;
							spec = rst.getString("species");
							pid = rst.getString("productId");
							PLT.append("<tbody>");
							PLT.append(
									"<tr><td>" + rst.getString("productId") + "</td><td>" + rst.getString("productName"));
							PLT.append("</td><td>" + rst.getString("weight") + "</td><td>$" + rst.getString("price"));
							PLT.append(
									"</td><td><input type=\"text\" name=\"newInvent" + invent + "\" size=\"3\" value=\"");
							PLT.append(rst.getString("Inventory") + "\"></td><td>" + rst.getString("category") + "</td>");
							PLT.append("<td><input type=BUTTON OnClick=\"update(" + rst.getString("productId"));
							PLT.append(", document.listadmin.newInvent" + invent);
							PLT.append(".value)\"value=\"Update Inventory\"></td>");
							PLT.append("<td><input type=BUTTON OnClick=window.location=\"admin.jsp?view=products&delete="
									+ pid + "\" value=\"Remove item from database\"></tr>");

						}
						PLT.append("</tbody></table>");
						PLT.append("</div>");
						out.print(PLT.toString());
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