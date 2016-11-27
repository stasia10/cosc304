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
<link rel="icon" href="">
<style type="text/css">
:root .carbonad,:root #carbonads-container,:root #content>#right>.dose>.dosesingle,:root #content>#center>.dose>.dosesingle
	{
	display: none !important;
}
</style>

<title>Signup Template for Bootstrap</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<link href=csss/ie10-viewport-bug-workaround.css " rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/signin.css" rel="stylesheet">

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

	<div class="container">

		<form method="POST" action="signup.jsp" class="form-signup" name="singUp">
			<h2 class="form-signup-heading">Please sign up!</h2>
			Name<label for="inputName" class="sr-only">First and Last
				Name</label> <input id="inputName" class="form-control"
				placeholder="First and Last Name" required="" autofocus=""
				type="text"> Email<label for="inputEmail" class="sr-only">Email
				address</label> <input id="inputEmail" class="form-control"
				placeholder="Email address (which will be your user name)" required="" autofocus="" type="email">
			Password<label for="inputPassword" class="sr-only">Password</label> <input
				id="inputPassword" class="form-control" placeholder="Password"
				required="" type="password"> Phone Number<label
				for="inputNum" class="sr-only">Phone Number</label> <input
				id="inputNum" class="form-control" placeholder="Phone Number"
				type="text"> Billing Address<label for="inputBAdd"
				class="sr-only">Billing Address</label> <input id="inputBAdd"
				class="form-control" placeholder="Billing Address" required=""
				type="text"> Shipping Address<label for="inputSAdd"
				class="sr-only">Shipping Address</label> <input id="inputSAdd"
				class="form-control" placeholder="Shipping Address" required=""
				type="text"> Preferred Payment<label for="inputPay"
				class="sr-only">Card Number and Expiry Date</label> <input
				id="inputPay" class="form-control"
				placeholder="Card Number and Expiry Date" type="text">
			<button class="btn btn-lg btn-primary btn-block" type="submit" value="Submit" onclick="checkform()" >Sign
				up</button>

		</form>

	</div>
	
	
	<script src="signin_files/ie10-viewport-bug-workaround.js"></script>
	<%@ page import="java.sql.*"%>
	<%
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		Connection con = null;
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_kreid;";
		String uid = "kreid";
		String pw = "39265137";
		String name = request.getParameter("inputName");
		String email = request.getParameter("inputEmail");
		String password = request.getParameter("inputPassword");
		String number = request.getParameter("inputNum");
		String BAdd = request.getParameter("inputBAdd");
		String SAdd = request.getParameter("inputSAdd");
		String Payment = request.getParameter("inputPay");
		
			try {
				con = DriverManager.getConnection(url, uid, pw);
				Statement check = con.createStatement();
				ResultSet che = check.executeQuery("select email from Account");
				%>
				<script>
	function checkform() {
    	<% while (che.next()){
    		if ((request.getParameter("inputEmail")).equals( che.getString(1))){  %>
    			alert("This email is already in use sorry :(");
    			<%  break;
    		}
    	
    }%>
    
        document.signUp.submit();
    }
</script>
				
					
				<%
				String s2 = "INSERT INTO Account VALUES (?, ?, ?, ?, ?, ?, ?, Customer)";
					PreparedStatement p = con.prepareStatement(s2);
					p.setString(1, email);
					p.setString(2, password);
					p.setString(3, name);
					if (number.length() == 0)
						p.setString(4, null);
					else
						p.setString(4, number);
					p.setString(5, BAdd);
					p.setString(6, SAdd);
					if (Payment.length() == 0)
						p.setString(7, null);
					else
						p.setString(7, Payment);
					p.executeUpdate();
				

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

</body>
</html>
