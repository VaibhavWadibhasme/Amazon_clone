
<html>
<head>
<meta charset="utf-8">
<title>Amazon Registration</title>

<link rel="stylesheet" href="css/signinstyle.css">
</head>
<body>
	<img src="img/signlogo.png" alt="Amazon.com" />

	<div id="signInBorder">
		<p id="">Create Account</p>
		<form action="regserver.jsp" method="post">
			<label> <strong>Your name</strong> <br> <input
				type="text" name="name" palceholder="First and Last name">
			</label> <br>
			<label> <strong>Mobile number</strong> <br> <input
				type="text" name="mobile" palceholder="Mobile number">
			</label> <br>
			<label> <strong>Email(optional)</strong> <br> <input
				type="email" name="email" palceholder="Email">
			</label> <br>
			 <label> <strong>Password</strong>  <br> <input
				type="password" name="password" value="" palceholder="At least 6 character">
			</label><small>Password must be at least 6 characters.</small>
				<p>By enrolling your mobile phone number, you consent to receive automated security notifications via text message from Amazon. Message and data rates may apply.</p>
			<div>
				<button type="submit" id="amazon">Create an account</button>
			</div>
		</form>
	<div>
	<p>Already have an account? <a href="signin.jsp">Sign in</a></p>
	<p>Become Seller on Amazon? <a href="sellersignin.jsp">Seller Sign in</a></p>
	</div>
		
	</div>

	<hr id="footer">
	<div class="extra">
		<p class="links">
			<a href="#" id="first">Conditions of Use</a> <a href="#">Notice
				of Use</a> <a href="#">Help</a>
		</p>
		<p class="links" id="special">© 1996-2016, Amazon.com, Inc. or its
			affiliates</p>
	</div>


</body>
</html>
