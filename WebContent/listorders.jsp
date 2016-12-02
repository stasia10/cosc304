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
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    

<link rel="apple-touch-icon" sizes="180x180" href="img/fav/apple-touch-icon.png">
<link rel="icon" type="image/png" href="img/fav/favicon-32x32.png" sizes="32x32">
<link rel="icon" type="image/png" href="img/fav/favicon-16x16.png" sizes="16x16">
<link rel="manifest" href="img/fav/manifest.json">
<link rel="mask-icon" href="img/fav/safari-pinned-tab.svg" color="#5bbad5">
<link rel="shortcut icon" href="img/fav/favicon.ico">
<meta name="msapplication-config" content="img/fav/browserconfig.xml">
<meta name="theme-color" content="#ffffff">



    <title>Previous Purchases</title>

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
<body>
<div class="formpadding">
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
            <li class="active"><a href="index.html">Home</a></li>
            <li><a href="about.html">About</a></li>
            <li><a href="products.jsp">Products</a></li>
            <li><a href="staff.jsp">Staff</a></li>
            <li><a href="showorder-login.jsp">Purchases</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <a href="showcart.jsp" class="btn btn-default navbar-btn">
          <span class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart 
          </a>

          </ul>
        
        </div><!--/.nav-collapse -->

      </div>
    </nav>

      </div>
    </div>
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
	</div>
</body>
</html>

