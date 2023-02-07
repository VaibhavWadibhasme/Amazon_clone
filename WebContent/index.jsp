<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Amazon(clone)</title>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/sidebarcss.css" />
</head>

<body>

	<header>
		<a id="nav-top"></a>
		<div id="nav-belt">
			<div class="nav-left">
				<div id="nav-logo">
					<a href="#" class="nav-logo-link"></a> <a href="#"
						class="nav-logo-tagline"></a>
				</div>
			</div>

			<div id="nav-main">
				<div class="nav-right">
					<a class="nav-a" href="#"> <span>EN</span> <i
						class="fa fa-globe" aria-hidden="true"></i> <i
						class="fa fa-caret-down" aria-hidden="true"></i>
					</a> <a class="nav-a" href="signin.jsp"> <span>Hello. Sign
							in</span> Accounts &amp; Lists
					</a> <a class="nav-a" href="signin.jsp"><span>Return </span> &amp;
						Orders </a> <a class="nav-a cart" href="signin.jsp"> <span>0</span>
						Cart
					</a>
				</div>

			</div>

			<div class="nav-fill">
				<div id="nav-search">
					<form>
						<div class="nav-left">
							<span class="nav-search-label">All</span> <i
								class="fa fa-caret-down" aria-hidden="true"></i> <select
								id="nav-search-select">
								<option selected="selected" value="aps">All Departments</option>
								<option value="beauty">Beauty &amp; Personal Care</option>
								<option value="stripbooks">Books</option>

								<option value="mobile">Cell Phones &amp; Accessories</option>
								<option value="fashion">Clothing, Shoes &amp; Jewelry</option>
								<option value="fashion-womens">&nbsp;&nbsp;&nbsp;Women</option>
								<option value="fashion-mens">&nbsp;&nbsp;&nbsp;Men</option>
								<option value="fashion-girls">&nbsp;&nbsp;&nbsp;Girls</option>
								<option value="fashion-boys">&nbsp;&nbsp;&nbsp;Boys</option>
								<option value="fashion-baby">&nbsp;&nbsp;&nbsp;Baby</option>

								<option value="computers">Computers</option>

								<option value="electronics">Electronics</option>

								<option value="grocery">Grocery &amp; Gourmet Food</option>

								<option value="hpc">Health, Household &amp; Baby Care</option>

								<option value="garden">Home &amp; Kitchen</option>


								<option value="fashion-luggage">Luggage &amp; Travel
									Gear</option>
							</select>
						</div>
						<div class="nav-right">
							<i class="fa fa-search" aria-hidden="true"></i> <input
								type="submit">
						</div>
						<div class="nav-fill">
							<input type="text" autocomplete="off">
						</div>
					</form>
				</div>
			</div>
		</div>

		<nav id="nav-main">
			<div class="nav-left">
				<div class="nav-shop">
					<!-- sidenavbar Start-->

					<div id="overlay" onclick="closeNav()"></div>

					<div id="closeBtn" onclick="closeNav()">&times;</div>
					<div class="sidenav" id="mySidenav">
						<div class="sidenavHeader">
							<a href="signin.jsp" style="color: white;"><i
								class="fa fa-user-circle"></i>&nbsp; Hello, Sign In</a>
						</div>
						<!--Below SideNavHeader-->
						<div id="main-container">
							<!-- <div class="sidenavContentHeader">Help & Settings</div>  -->
							<a href="signin.jsp"><div class="sidenavContent">Home</div></a> 
							<a href="signin.jsp"><div class="sidenavContent">Your Account</div></a> 
							<a href="signin.jsp"><div class="sidenavContent">Sign In</div></a>
							<a href="sellersignin.jsp"><div class="sidenavContent"></div>Sell on Amazon</a>
							<div style="height: 50px"></div>
						</div>
						<!--End of first container-->

						<div id="sub-container">
							<div id="mainMenu">
								<i class="fa fa-caret-left" style="color: #8e9090"></i> MAIN
								MENU
							</div>
							<hr />
							<div id="sub-container-content">
								<!-- <div class="sidenavContentHeader">Prime Video</div>
          <a href="#"><div class="sidenavContent">All Videos</div></a> -->
							</div>
						</div>
					</div>

					<!--Not Sidenav-->
					<div onclick="openNav()"
						style="font-size: 20px; margin: 20px 0 0 20px; cursor: pointer; display: inline-block; color: white;">
						&#9776; All</div>
					<!-- sidenavbar end -->
				</div>
			</div>
			<div class="nav-fill">
				<ul>
					<li><a href="sellersignin.jsp"><button class="btn">Sell
								on Amazon</button></a></li>
					<li><a href="#"><button class="btn">Help</button></a></li>

				</ul>
			</div>

		</nav>
	</header>


	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "select * from product_details ";
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				String pname = rs.getString("product_name");
				double pprice = rs.getDouble("product_price");
				String pimg = rs.getString("image1");
	%>
	<section id="myproducts">
		<div class="container-fluid">
			<div class="row">
				<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
					<img src="product_img/<%=pimg%>">
				</div>
				<div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
					<a href="signin.jsp"><h3><%=pname%></h3></a>
					<h3>
						<strong> &#8377;<%=pprice%></strong>
					</h3>
					<h4>10% Off on SBI Credit Cards</h4>
					<p>
						Get it by<strong>Monday, December 26</strong>
					</p>
					<p>FREE Delivery by Amazon</p>
				</div>
			</div>
		</div>
	</section>


	<%
		}
		} catch (Exception e) {
			out.println("Exception " + e);
		}
	%>

	<footer>
		<div class="top text-center">
			<a href="#nav-top">Back to top</a>
		</div>

		<div class="middle">
			<div class="center text-center">
				<ul>
					<li><h3>Get to Know Us</h3></li>
					<li><a href="#">Careers</a></li>
					<li><a href="#">About Amazon</a></li>
					<li><a href="#">Investor Relations</a></li>
					<li><a href="#">Amazon Devices</a></li>
				</ul>
				<ul>
					<li><h3>Make Money with Us</h3></li>
					<li><a href="#">Sell on Amazon</a></li>
					<li><a href="#">Sell Your Services on Amazon</a></li>
					<li><a href="#">Sell on Amazon Business</a></li>
					<li><a href="#">Become an Affiliate</a></li>
				</ul>

				<ul>
					<li><h3>Let Us Help You</h3></li>
					<li><a href="#">Your Account</a></li>
					<li><a href="#">Your Orders</a></li>
					<li><a href="#">Returns &amp; Replacements</a></li>
					<li><a href="#">Help</a></li>
				</ul>
			</div>

			<ul class="copy text-center">
				<li><a href="#" class="logo"></a></li>
				<li><a href="#" class="select"><i class="fa fa-globe"
						aria-hidden="true"></i> English</a></li>
				<li><a href="#" class="select"><i class="flag-icon-us"></i>United
						States</a></li>
			</ul>
		</div>

		<div class="bottom">
			<div class="center text-center">
				<ul class="copy text-center">
					<li><a href="#">Conditions of Use</a></li>
					<li><a href="#">Privacy Notice</a></li>
					<li><a href="#">Interest-Based Ads</a></li>
					<li>&copy; 1996-2017, Amazon.com, Inc. or its affiliates</li>
				</ul>
			</div>
		</div>
	</footer>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="js/app.js"></script>
	<script src="js/sidebarjs.js"></script>
</body>

</html>