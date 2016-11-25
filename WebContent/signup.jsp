<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en"><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href=""><style type="text/css">
:root .carbonad,
:root #carbonads-container,
:root #content > #right > .dose > .dosesingle,
:root #content > #center > .dose > .dosesingle
{ display: none !important; }</style>

    <title>Signup Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href=csss/ie10-viewport-bug-workaround.css" rel="stylesheet">

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

      <form action="post" action="signup.jsp" class="form-signup">
      <h2 class="form-signup-heading">Please sign up!</h2>
       Name<label for="inputName" class="sr-only">First and Last Name</label>
        <input id="inputName" class="form-control" placeholder="First and Last Name" required="" autofocus="" type="text">
        User Name<label for="inputUName" class="sr-only">User Name</label>
        <input id="inputUName" class="form-control" placeholder="User Name" required="" autofocus="" type="text">
        Email<label for="inputEmail" class="sr-only">Email address</label>
        <input id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="" type="email">
       Password<label for="inputPassword" class="sr-only">Password</label>
        <input id="inputPassword" class="form-control" placeholder="Password" required="" type="password">
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button>
        
      </form>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="signin_files/ie10-viewport-bug-workaround.js"></script>
  

</body></html>
