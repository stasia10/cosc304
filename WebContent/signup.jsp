<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign up</title>
</head>
<body>
	<h1 align="center">Sign up for an account with Fancy Cacti!</h1>
	<form method="get" action="login.jsp">
		Username: <input type="text" name="username" size="50"> <br />
		Password: <input type="text" name="pass" size="50"> <br />
		Full Name: <input type="text" name="fullName" size="50">
		<h5>Billing Address</h5>
		Street Number and Name: <input type="text" name="street" size="100">
		City <input type="text" name="city" size="50"> <input
			type="submit" value="Submit">
	</form>
</body>
</html>
