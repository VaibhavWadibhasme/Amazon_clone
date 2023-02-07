
<html>
<head>
<meta charset="utf-8">
<title>Amazon Sign In</title>

<link rel="stylesheet" href="css/signinstyle.css">
</head>
<body>
	<img src="img/amazonseller.jpg" alt="Amazon.com" />

	<div id="signInBorder">
		<p id="SignInTxt">OTP Verification</p>
		<form action="sellerforgetotpserver.jsp">
			<label> <strong>Enter OTP</strong> <br>
				<input type="text" name="otp" value="">
			</label> <br> 

			<div>
				<button type="submit" id="amazon">Verify OTP</button>
			</div>
		</form>
		<%
		String sesval = (String) session.getAttribute("sesval");

		if (sesval == null) {
		} else {
	%>
	<script>alert("<%=sesval%>")</script>
	<%
		session.setAttribute("sesval", null);
		}
	%>
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
