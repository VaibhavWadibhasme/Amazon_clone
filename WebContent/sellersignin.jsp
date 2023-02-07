
<html>
<head>
<meta charset="utf-8">
<title>Amazon Sign In</title>

<link rel="stylesheet" href="css/signinstyle.css">
</head>
<body>
	<img src="img/amazonseller.jpg" alt="Amazon.com" />

	<div id="signInBorder">
		<p id="SignInTxt">Sign in</p>
		<form action="sellersigninserver.jsp">
			<label> <strong>Email (phone for mobile accounts)</strong> <br>
				<input type="email" name="email" value="">
			</label> <br> <label> <strong>Password</strong> <span><a
					href="sellerforgetpass.jsp" id="password">Forgot your password?</a></span> <br> <input
				type="password" name="password" value="">
			</label>

			<div>
				<button type="submit" id="amazon">Sign in</button>
			</div>
		</form>
		<div id="createAccount">
			<h2>
				<span>New to Amazon?</span>
			</h2>
			<form action="sellerregistration.jsp">
				<button type="submit" id="newAccount" name="newAcct">Create
					your Amazon seller account</button>
			</form>
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
	<%
		String sesregsell = (String) session.getAttribute("sesregsell");

		if (sesregsell == null) {
		} else {
	%>
	<script>alert("<%=sesregsell%>")</script>
	<%
		session.setAttribute("sesregsell", null);
		}
	%>

</body>
</html>
