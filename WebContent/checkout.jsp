<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="main.css">
<title>Fancy Cacti CheckOut Line</title>
</head>
<body>
<div class="container">

      <form class="form-signin" method="get" action="order.jsp">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="" type="email">
        <label for="inputPassword" class="sr-only">Password</label>
        <input id="inputPassword" class="form-control" placeholder="Password" required="" type="password">
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <a class="btn btn-lg btn-primary btn-block" href="signup.jsp">Create account</a>
      </form>

    </div> <!-- /container -->
	<h1>Enter your customer id and password to complete the transaction:</h1>

	<form method="get" action="order.jsp">
		<input type="text" name="email" size="50">
		 <input type="text" name="password" size="50">
		  <input type="submit" value="Submit">
			<input type="reset" value="Reset">
	</form>
	<h3>Dont already have an account sign up here</h3> <a href ="Copy of signup2.jsp">Sign Up </a> 

</body>
</html>

