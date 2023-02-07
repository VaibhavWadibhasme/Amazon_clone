
<html>
<head>
<meta charset="utf-8">
<title>Amazon Sign In</title>

<link rel="stylesheet" href="css/signinstyle.css">
</head>
<body>
	<img src="img/signlogo.png" alt="Amazon.com" />

	<div id="signInBorder">
		<p id="SignInTxt">Sign in</p>
		<form action="signinserver.jsp">
			<label> <strong>Email (phone for mobile accounts)</strong> <br>
				<input type="email" name="email" value="">
			</label> <br> <label> <strong>Password</strong> <span><a
					href="forgetpass.jsp" id="password">Forgot your password?</a></span> <br> <input
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
			<form action="registration.jsp">
				<button type="submit" id="newAccount" name="newAcct">Create
					your Amazon account</button>
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
		String sesreg = (String) session.getAttribute("sesreg");

		if (sesreg == null) {
		} else {
	%>
	<script>alert("<%=sesreg%>")</script>
	<%
		session.setAttribute("sesreg", null);
		}
	%>
	<%
		String seslog1 = (String) session.getAttribute("seslog1");

		if (seslog1 == null) {
		} else {
	%>
	<script>alert("<%=seslog1%>")</script>
	<%
		session.setAttribute("seslog1", null);
		}
	%>

</body>
</html>
