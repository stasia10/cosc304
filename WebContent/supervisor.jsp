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

<title>Supervisor Page</title>

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
	<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
	<%@ page import="java.sql.*"%>
	<form name="listsuper">
		<%
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection con = null;
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
			String uid = "kreid";
			String pw = "39265137";
		%>
		<div class="container marketing">
			<div class="formpadding">
				<div class="form-group row">
					<div class="col-m-10">
						<button class="btn btn-lg btn-register btn-block" type="button"
							OnClick="window.location='supervisor.jsp?view=orders'"
							value="View Orders">View Orders</button>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-m-10">
						<a class="btn btn-lg btn-block btn-register"
							OnClick="window.location='supervisor.jsp?view=products'"
							value="Edit Products">Edit Products</a>
					</div>
				</div>
			</div>



			<script>
				function update(newId, newInvent) {
					window.location = "supervisor.jsp?view=products&update="
							+ newId + "&newInvent=" + newInvent;
				}
			</script>

			<%
				String update = request.getParameter("update");
				String newInvent = request.getParameter("newInvent");
				String select = request.getParameter("view");
				int invent = 0;
				try {
					// PLT = Product Listing Table
					StringBuilder PLT = new StringBuilder(1000);
					con = DriverManager.getConnection(url, uid, pw);
					if (update != null && (!update.equals(""))) {
						PreparedStatement up = con.prepareStatement("UPDATE Product SET Inventory = ? WHERE productId = ?");
						up.setString(1, newInvent);
						up.setString(2, update);
						up.executeUpdate();
					}

					if ("products".equalsIgnoreCase(select)) {
						String SQL = "SELECT * FROM Product";
						PreparedStatement pstmt = con.prepareStatement(SQL);
						ResultSet rst = pstmt.executeQuery();

						PLT.append("<div class=\"table-responsive\">");
						PLT.append("<table class=\"table\">");
						PLT.append(
								" <thead><tr><th> Product Id </th><th> Product Name </th><th> Weight </th><th> Price </th><th> Inventory </th><th> Category </th></tr></thead>");

						String spec = null;
						while (rst.next()) {
							invent++;
							spec = rst.getString("species");
							PLT.append("<tbody>");
							PLT.append(
									"<tr><td>" + rst.getString("productId") + "</td><td>" + rst.getString("productName"));
							PLT.append("</td><td>" + rst.getString("weight") + "</td><td>$" + rst.getString("price"));
							PLT.append(
									"</td><td><input type=\"text\" name=\"newInvent" + invent + "\" size=\"3\" value=\"");
							PLT.append(rst.getString("Inventory") + "\"></td><td>" + rst.getString("category") + "</td>");
							PLT.append("<td><input type=BUTTON OnClick=\"update(" + rst.getString("productId"));
							PLT.append(", document.listsuper.newInvent" + invent);
							PLT.append(".value)\"value=\"Update Inventory\"></td></tr>");

						}
						PLT.append("</tbody></table>");
						PLT.append("</div>");
						out.print(PLT.toString());

					} else if ("orders".equalsIgnoreCase(select)) {
						String SQL = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
						PreparedStatement pstmt = con.prepareStatement(SQL);
						ResultSet rst = pstmt.executeQuery();
						out.println("<table id='hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Order Date</b></th>"
								+ "<th><b>Ship Date</b></th><th><b>Ship Type</b></th><th><b>Expected Delivery</b></th>"
								+ "<th><b>Payment Type</b></th><th><b>Total Amount</b></th>");
						String oid = null;

						while (rst.next()) {
							oid = rst.getString(1);
							out.println("<tr align='center'><td>" + oid + "</td><td>" + rst.getString(3) + "</td><td>"
									+ rst.getString(5) + "</td><td>" + rst.getString(6) + "</td><td>" + rst.getString(7)
									+ "</td><td>" + rst.getString(4) + "</td><td>$" + rst.getString(2));
							out.println(
									"<tr align='right'><td colspan='7'><table id='hor-minimalist-b'><th><b>Product Id</b></th><th><b>Product Name</b></th>"
											+ "<th><b>Quantity</b></th><th><b>Price</b></th>");
							String SQL3 = "SELECT O.productId, quantity, O.price, productName FROM OrderedProduct O INNER JOIN Product P ON O.productId = P.productId "
									+ " WHERE orderId = ?";
							PreparedStatement pstmt2 = con.prepareStatement(SQL3);
							pstmt2.setString(1, oid);
							ResultSet rst2 = pstmt2.executeQuery();
							while (rst2.next()) {
								out.println("<tr align='center'><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(4)
										+ "</td><td>" + rst2.getString(2) + "</td><td>$" + rst2.getDouble(3) + "</td>");
							}
							out.println("</tbody></table></td></tr>");
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
			<!-- FOOTER -->
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
	</form>
</body>
</html>