<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<title>Your Shopping Cart</title>
</head>
<body>
	<script>
		function update(newid, newqty) {
			window.location.href = "showcart.jsp?update=" + newid + "&newqty="
					+ newqty;
		}
	</script>
	<form name="listcart">
		<%
			// Get the current list of products
			@SuppressWarnings({ "unchecked" })
			HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
					.getAttribute("productList");
			ArrayList<Object> product = new ArrayList<Object>();
			String del = request.getParameter("delete");
			String update = request.getParameter("update");
			String newqty = request.getParameter("newqty");
			if (productList == null) {
				out.println("<H1>Your shopping cart is empty!</H1>");
				productList = new HashMap<String, ArrayList<Object>>();
			} else {
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();

				if (update != null && (!update.equals(""))) {
					if (productList.containsKey(update)) {
						product = (ArrayList<Object>) productList.get(update);
						product.set(3, (new Integer(newqty)));
					} else {
						productList.put(update, product);
					}
				}
				if (del != null && (!del.equals(""))) {
					if (productList.containsKey(del)) {
						productList.remove(del);
					}
				}

				out.println("<h1>Your Shopping Cart</h1>");
				out.print("<table id = 'hor-minimalist-b'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
				out.println("<th>Price</th><th>Subtotal</th><td></td><td></td></tr>");

				double total = 0;

				Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
				while (iterator.hasNext()) {
					Map.Entry<String, ArrayList<Object>> entry = iterator.next();
					product = (ArrayList<Object>) entry.getValue();
					String pid = (String) product.get(0);

					out.print("<tr><td>" + pid + "</td>");
					out.print("<td>" + product.get(1) + "</td>");
					out.print("<td><input type=\"text\" name=\"newqty" + pid + "\" size = \"3\" value = \""
							+ product.get(3) + "\"></td>");
					double pr = Double.parseDouble((String) product.get(2));
					int qty = ((Integer) product.get(3)).intValue();

					out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
					out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td>");
					out.println("<td><a href=\"showcart.jsp?delete=" + pid + "\">Remove item from cart</a>");
					out.println("<td><input type=BUTTON OnClick=\"update(" + pid + ", document.listcart.newqty" + pid
							+ ".value)\" value= \"Update Quantity\"></td>");
					out.println("</tr>");
					total = total + pr * qty;

				}
				out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>" + "<td align=\"right\">"
						+ currFormat.format(total) + "</td></tr>");
				out.println("</table>");

				out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
			}
		%>
		<h2>
			<a href="listprod.jsp">Continue Shopping</a>
		</h2>
	</form>
</body>
</html>

