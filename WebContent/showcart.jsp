<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
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

<title>Shopping Cart</title>

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
<body>
	<%@ page import="java.sql.*"%>
	<div class="container marketing">

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
								<li class="active"><a href="showorder-login.jsp">Purchases</a></li>
							</ul>
							<ul class="nav navbar-nav navbar-right">
								<a href="showcart.jsp" class="btn btn-default navbar-btn active">
									<span class="glyphicon glyphicon-shopping-cart"></span>
									Shopping Cart
								</a>

							</ul>

						</div>
						<!--/.nav-collapse -->

					</div>
				</nav>

			</div>
		</div>
		<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
		<script>
			function update(newid, newqty) {
				window.location = "showcart.jsp?update=" + newid + "&newqty="
						+ newqty;
			}
		</script>
		<form name="listcart">
			<%// Get the current list of products
		@SuppressWarnings({ "unchecked" })
		HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
				.getAttribute("productList");
		ArrayList<Object> product = new ArrayList<Object>();
		
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
		
		String del = request.getParameter("delete");
		String update = request.getParameter("update");
		String newqty = request.getParameter("newqty");
		if (productList == null) {
			out.println("<H1>Your shopping cart is empty!</H1>");
			productList = new HashMap<String, ArrayList<Object>>();
		} else {
			NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			try {
				con = DriverManager.getConnection(url, uid, pw);
				
			if (update != null && (!update.equals(""))) {
				String checkInventory = "SELECT Inventory FROM Product WHERE productId=?";
				PreparedStatement ptCheck = con.prepareStatement(checkInventory);
				ptCheck.setString(1, update);
				ResultSet rstCheck = ptCheck.executeQuery();
				rstCheck.next();
				int realInv = rstCheck.getInt(1);
				int Qty =  (new Integer(newqty));
				if(realInv < Qty){
					%>

					<script>
						alert("Sorry we do not have that much in stock");
					</script>

					<%
				}
				else{
				if (productList.containsKey(update)) {
					product = (ArrayList<Object>) productList.get(update);
					product.set(3,Qty);
				} else {
					productList.put(del, product);
				}
			}
			}
			
			if (del != null && (!del.equals(""))) {
				if (productList.containsKey(del)) {
					productList.remove(del);
				}
			}
			
			StringBuilder PLT = new StringBuilder(250);
			PLT.append("<div class=\"table-responsive\">"); 
			PLT.append("<table class=\"table \">");
			PLT.append("<h1>Your Shopping Cart </h1>");
			PLT.append("<thead><tr><th> Product Id </th><th> Product Name </th><th> Quantity </th><th> Price </th><th> Subtotal </th></tr></thead>");
		
			
			double total = 0;
			int count = 0;

			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) {
				count ++;
				Map.Entry entry = (Map.Entry)(iterator.next());
				product = (ArrayList) entry.getValue();
				String pid = (String) product.get(0);

				PLT.append("<tr><td>" + pid + "</td>");
				PLT.append("<td>" + product.get(1) + "</td>");
				PLT.append("<td><input type=\"text\" name=\"newqty" + count + "\" size = \"3\" value = \""
						+ product.get(3) + "\"></td>");
				double pr = Double.parseDouble((String) product.get(2));
				int qty = ((Integer) product.get(3)).intValue();

				PLT.append("<td>" + currFormat.format(pr) + "</td>");
				PLT.append("<td>" + currFormat.format(pr * qty) + "</td>");
				PLT.append("<td class=\"col-md-1\"><a class=\"btn btn-sm btn-default \" OnClick=\"update(" + pid + ", document.listcart.newqty" + count
						+ ".value)\">Update Quantity</a></td>");
				
				PLT.append("<td class=\"col-md-1\"><a class=\"btn btn-sm btn-default\" href=\"showcart.jsp?delete=" + pid + "\">Remove item from cart</a>");
				PLT.append("</tr>");
				total = total + pr * qty;

			}
			PLT.append("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>" + "<td align=\"right\">"
					+ currFormat.format(total) + "</td></tr>");
			PLT.append("</table>");
			
			session.setAttribute("productList", productList);
			PLT.append("</table></div>");
			out.print(PLT.toString());

			out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
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
		}
		%>
			<h2>
				<a href="products.jsp">Continue Shopping</a>
			</h2>
		</form>
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
</html>