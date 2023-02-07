<!DOCTYPE html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Amazon.com: Online Shopping for Electronics, Apparel,
	Computers, Books, DVDs &amp; more</title>

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/c_dashstyl.css" />
<link rel="stylesheet" href="css/c_sidebar.css" />

</head>

<body>
	<%
		String seslog = (String) session.getAttribute("seslog");
		int count = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "select count(status) from cart where email='" + seslog + "' and status='0'";
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			out.println("Exception" + e);
		}
	%>
	<header>
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
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
							</a>
							<%
								
							%>
							<a class="nav-a" href="dashboard.jsp"> <span><%=seslog%></span></a> <a
								class="nav-a" href="order.jsp"><span>Return </span> &amp;
								Orders </a> <a class="nav-a cart" href="cart.jsp"> <span><%=count%></span>Cart
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
										<option selected="selected" value="aps">All
											Departments</option>
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
									<i class="fa fa-user-circle"></i> <a href="dashboard.jsp"
										style="color: white;">Hello, <%=seslog%></a>
								</div>
								<!--Below SideNavHeader-->
								<div id="main-container">
							<!-- <div class="sidenavContentHeader">Help & Settings</div>  -->
							<a href="dashboard.jsp"><div class="sidenavContent">Home</div></a>
									<a href="#"><div class="sidenavContent">Your Profile</div></a>
									<a href="dashboard.jsp"><div class="sidenavContent" id="addressid">Your Address</div></a> 
									<a href="logout.jsp"><div class="sidenavContent">Log Out</div></a>
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
							<li></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</header>

	<section id="cart">
	<div class="col-lg-10">
		<%	
			double subtotal = 0;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
				String sql = "select * from cart where email='" + seslog + "' and status='0'";
				PreparedStatement pst = con.prepareStatement(sql);
				ResultSet rs = pst.executeQuery();
				while (rs.next()) {
					int id = rs.getInt("id");
					int qyt = rs.getInt("qyt");
					//System.out.println(qyt);
					
					
					try {

						Class.forName("com.mysql.jdbc.Driver");
						Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
						String sql1 = "select * from product_details where id='" + id + "'";
						PreparedStatement pst1 = con1.prepareStatement(sql1);
						ResultSet rs1 = pst1.executeQuery();
						while (rs1.next()) {

							String pname = rs1.getString("product_name");
							double pprice = rs1.getDouble("product_price");
							String pimg1 = rs1.getString("image1");
							subtotal = subtotal + qyt * pprice;
		%>

		<div class="container-fluid ">
			<div class="row">
				<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
					<img src="product_img/<%=pimg1%>">
				</div>
				<div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
					<a href="detailedProduct.jsp?id=<%=id%>"><h4><%=pname%></h4></a>
					<h3>
						<strong> &#8377;<%=pprice%></strong>
					</h3>
					<h4>10% Off on SBI Credit Cards</h4>
					<p>
						Get it by<strong>Monday, December 26</strong>
					</p>
					<p>FREE Delivery by Amazon</p>
					<div class="form-group">
						<label for="">Quantity</label> <select class="form-control"
							id="qyt" name="qyt">
							<option <%if (qyt == 1)
								out.println("selected");%>>1</option>
							<option <%if (qyt == 2)
								out.println("selected");%>>2</option>
							<option <%if (qyt == 3)
								out.println("selected");%>>3</option>
							<option <%if (qyt == 4)
								out.println("selected");%>>4</option>
							<option <%if (qyt == 5)
								out.println("selected");%>>5</option>
						</select>
					</div>
					<a class="btn" href="deletfromcart.jsp?id=<%=id%>&qyt=<%=qyt%>">Delete</a>
				</div>					<!-- try to send qyt to with id to delete page -->
			</div>
		</div>
		<%
			}
					} catch (Exception e) {
						out.println("Exception " + e);
					}
				}
			} catch (Exception e) {

			}
		%>
		</div>
	</section>
	<section id="buysection">
		<h2>
			Subtotal(<%=count%>
			items): <strong>&#8377;<%=subtotal%></strong><br>
			<a class="btn" href="proceedtobuy.jsp">Proceed to Buy</a>
		</h2>
	</section>
	
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