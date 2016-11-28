<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="icon" href="">
<style type="text/css">
:root .carbonad, :root #carbonads-container, :root #content>#right>.dose>.dosesingle,
	:root #content>#center>.dose>.dosesingle {
	display: none !important;
}
</style>
<link rel="stylesheet" type="text/css" href="main.css">
<title>Admin Page</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href=csss/ie10-viewport-bug-workaround.css " rel="stylesheet">

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
	<script>
		function updateShipment(newId, newShip){
			window.location = "admin.jsp?updateShipment=" + newId + "&newShip=" + newShip;
		}
		function updatePayment(newId, newPay){
			window.location = "admin.jsp?updatePayment=" + newId + "&newPay=" + newPay;
		}
		function updateQty(newId, newQty){
			window.location = "admin.jsp?updateQty=" + newId + "&newQty=" + newQty;
		}
	</script>
	<form name="listorder">
		<%
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection con = null;
			String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
			String uid = "kreid";
			String pw = "39265137";
			
			String updateShipment = request.getParameter("updateShipment");
			String updatePayment = request.getParameter("updatePayment");
			String updateQty = request.getParameter("updateQty");
			String newShip = request.getParameter("newShip");
			String newPay = request.getParameter("newPay");
			String newQty = request.getParameter("newQty");
	
			try {
				con = DriverManager.getConnection(url, uid, pw);
				String SQL = "SELECT orderId, totalAmount, orderDate, paymentType, shipDate, shipType, expectedDelivery FROM Invoice";
				PreparedStatement pstmt = con.prepareStatement(SQL);
				ResultSet rst = pstmt.executeQuery();
				out.println("<table id='hor-minimalist-b'><tbody><th><b>Order Id</b></th><th><b>Order Date</b></th>"
						+ "<th><b>Ship Date</b></th><th><b>Ship Type</b></th><th><b>Expected Delivery</b></th>"
						+ "<th><b>Payment Type</b></th><th><b>Total Amount</b></th>");
				String oid = null;
				String pid = null;
				int ship = 0;
				int pay = 0;
				int qty = 0;
				
				while (rst.next()) {
					if(rst.toString() == null){
						out.println("<h1>There are no current orders</h1>");
					} else {
						if(updateShipment != null && updatePayment != null && (!updateShipment.equals("")) && (!updatePayment.equals(""))){
							if(rst.getNString(5).equals(updateShipment)){
								rst.updateString(5, newQty);
							}else if(rst.toString().contains(updatePayment)){
								rst.updateNString(4, newPay);
							}
						}
					}
					pay++;
					ship++;
					oid = rst.getString(1);
					out.println("<tr align='center'><td>" + oid + "</td><td>" + rst.getString(3) + "</td><td>" + rst.getString(5)
							+ "</td><td><input type=\"text\" name=\"newShip" + ship + "\" size=\"25\" value=\"" 
							+ rst.getString(6) + "\"></td><td>" + rst.getString(7) + "</td><td><input type=\"text\" name=\"newPay"
							+ pay + "\" size= \"25\" value=\"" + rst.getString(4) + "\"></td><td>$" + rst.getString(2));
					out.println("<td><input type=BUTTON OnClick=\"updateShipment(" + oid + ", document.listorder.newShip" + ship 
							+ ".value)\"value=\"Update Shipment\"></td>");
					out.println("<td><input type=BUTTON OnClick=\"updatePayment(" + oid + ", document.listorder.newPay" + pay 
							+ ".value)\" value= \"Update Payment\"></td></tr>");
					out.println(
							"<tr align='right'><td colspan='7'><table id='hor-minimalist-b'><th><b>Product Id</b></th><th><b>Product Name</b></th>"
									+ "<th><b>Quantity</b></th><th><b>Price</b></th>");
					String SQL3 = "SELECT O.productId, quantity, O.price, productName FROM OrderedProduct O INNER JOIN Product P ON O.productId = P.productId " 
							+ " WHERE orderId = ?";
					PreparedStatement pstmt2 = con.prepareStatement(SQL3);
					pstmt2.setString(1, oid);
					ResultSet rst2 = pstmt2.executeQuery();
					while (rst2.next()) {
						qty++;
						pid = rst2.getString(1);
						out.println("<tr align='center'><td>" + rst2.getString(1) + "</td><td>" + rst2.getString(4) 
								+ "</td><td><input type =\"text\" name =\"newQty" + qty + "\" size = \"3\" value=\"" 
								+ rst2.getString(2) + "\"></td><td>$" + rst2.getDouble(3) + "</td>");
						out.println("<td><input type=BUTTON OnClick=\"updateQty(" + pid + ", document.listorder.newQty" + qty 
								+ ".value)\" value= \"Update Quantity\"></td></tr>");
					}
					out.println("</tbody></table></td></tr>");
				}
				out.println("</tbody></table>");
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