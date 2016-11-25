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
		// Get customer id
		
		LocalDate localDate = LocalDate.now();
        String ordDate = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(localDate);
        String name = localDate.getDayOfWeek().name();
        int shipAdd = 0;
        if(name.equalsIgnoreCase("friday")){
        	shipAdd = 3;
        }
        else if(name.equalsIgnoreCase("saturday")){
        	shipAdd = 2;
        }
        else{
        	shipAdd = 1;
        }
        LocalDate shipDate = localDate.plusDays(shipAdd);
        String ship = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(shipDate);
        
        String shipType = "regular"; //change this later and next line later
        String deliv = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(shipDate.plusDays(5));

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
				out.println("<h2>Your shopping cart is empty please go back to previos page and try again</h2>");
			} else {
				if (custId.matches("[0-9]+")) {
					String SQL = "select username, fullName, pass from Account where username=?";
					PreparedStatement pstmt = con.prepareStatement(SQL);
					pstmt.setString(1, custId);
					ResultSet rst = pstmt.executeQuery();
					if (rst.next()) {
						if (pass.equals(rst.getString(3))) {
							String invoice = "INSERT INTO INVOICE (accountUser,orderDate, paymentType, shipDate, shipType, expectedDelivery, whouseName)" +
									"VALUES (?,?,?,?,?,?,CactiOne)";
							PreparedStatement psInvoice = con.prepareStatement(invoice, Statement.RETURN_GENERATED_KEYS);
							
							String payment = "SELECT preferredPayment FROM Account WHERE username = ?";
							PreparedStatement psPayment = con.prepareStatement(payment);
							psPayment.setString(1, custId);
							
							ResultSet payType = psPayment.executeQuery();
							payType.next();
							
							psInvoice.setString(1,custId);
							psInvoice.setString(2,ordDate);
							psInvoice.setString(3,payType.getString(1));
							psInvoice.setString(4,ship);
							psInvoice.setString(5,shipType);
							psInvoice.setString(6,deliv);
							
							
							psInvoice.executeUpdate();
							ResultSet keys = psInvoice.getGeneratedKeys();
							keys.next();
							int orderId = keys.getInt(1);
							double totalAmt = 0;
							double totalWt = 0;

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
								out.println("<tr><td>" + productId + "</td><td>" + product.get(1) + "</td><td>"
										+ qty + "</td><td>" + pr + "</td><td>" + qty * pr + "</td></tr>");
								
								
							}

							out.println("<tr><td colspan='4'><b>Order Total</b></td><td>" + totalAmt
									+ "</td></tr></table>");
							String upOrd = "UPDATE Invoice SET totalAmount = ? WHERE orderId = ?"; 
							PreparedStatement pord = con.prepareStatement(upOrd);
							pord.setDouble(1, totalAmt);
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

