<!DOCTYPE html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
<link rel="stylesheet" href="css/dashstyle.css" />
<link rel="stylesheet" href="css/sidebarcss.css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js">
</script>
<script type="text/javascript">
	function preventBack() {
		window.history.forward();
	}
	setTimeout("preventBack()", 0);
	window.onunload = function() {
	<%List idList=null;
	String seslog = (String) session.getAttribute("seslog");
	if(seslog==null){
			response.sendRedirect("signin.jsp");
		}%>
	};
</script>
</head>

<body>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#myproducts").show();
			$("#address").hide();
			$("#addressid").click(function() {
				$("#address").show();
				$("#myproducts").hide();
			});

			$("#nav-search-select").change(function() {
				$("#searchtext").focus();
			});
		});
	</script>

	<%
		
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
							</a> <a class="nav-a" href=""> <span><%=seslog%></span></a> <a
								class="nav-a" href="order.jsp"><span>Return </span> &amp;
								Orders </a> <a class="nav-a cart" href="cart.jsp"> <span><%=count%></span>Cart
							</a>
						</div>

					</div>

					<div class="nav-fill">
						<div id="nav-search">
							<form action="SearchController" method="post">
								<div class="nav-left">
									<span class="nav-search-label">All</span> <i
										class="fa fa-caret-down" aria-hidden="true"></i> <select
										id="nav-search-select" name="searchCategory">

										<option selected="selected" value="aps">All
											Departments</option>
										<option value="Beauty &amp; Personal Care">Beauty
											&amp; Personal Care</option>
										<option value="Books">Books</option>
										<option value="Cell Phones &amp; Accessories">Cell
											Phones &amp; Accessories</option>
										<option value="Clothing, Shoes &amp; Jewelry">Clothing,
											Shoes &amp; Jewelry</option>
										<option value="Women">&nbsp;&nbsp;&nbsp;Women</option>
										<option value="Men">&nbsp;&nbsp;&nbsp;Men</option>
										<option value="Girls">&nbsp;&nbsp;&nbsp;Girls</option>
										<option value="Boys">&nbsp;&nbsp;&nbsp;Boys</option>
										<option value="Baby">&nbsp;&nbsp;&nbsp;Baby</option>

										<option value="Computers">Computers</option>

										<option value="Electronics">Electronics</option>

										<option value="Grocery &amp; Gourmet Food">Grocery
											&amp; Gourmet Food</option>

										<option value="Health, Household &amp; Baby Care">Health,
											Household &amp; Baby Care</option>

										<option value="Home &amp; Kitchen">Home &amp; Kitchen</option>


										<option value="Luggage &amp; Travel Gear">Luggage
											&amp; Travel Gear</option>
									</select>
								</div>
								<div class="nav-right">
									<i class="fa fa-search" aria-hidden="true"></i> <input
										type="submit">
								</div>
								<div class="nav-fill">
									<input type="text" name="searchName" id="searchtext"
										autocomplete="off">
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
									<i class="fa fa-user-circle"></i> <a href=""
										style="color: white;">Hello, <%=seslog%></a>
								</div>
								<!--Below SideNavHeader-->
								<div id="main-container">
									<!-- <div class="sidenavContentHeader">Help & Settings</div> -->
									<a href="dashboard.jsp"><div class="sidenavContent">Home</div></a>
									<a href="#"><div class="sidenavContent">Your Profile</div></a>
									<a href="#"><div class="sidenavContent" id="addressid">Your Address</div></a> 
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
							<li><a href="#">Help</a></li>

						</ul>
					</div>
				</nav>
			</div>
		</div>
	</header>
	<section id="myproducts">
		<%
			idList = (List) session.getAttribute("idList");
			
			try {
				String sql = "";
				int pid = 0;
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
				if (idList == null) {
					sql = "select * from product_details";

					PreparedStatement pst = con.prepareStatement(sql);
					ResultSet rs = pst.executeQuery();

					while (rs.next()) {
						pid = rs.getInt("id");
						String pname = rs.getString("product_name");
						double pprice = rs.getDouble("product_price");
						String pimg1 = rs.getString("image1");
		%>

		<div class="container-fluid">
			<div class="row">
				<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
					<img src="product_img/<%=pimg1%>">
				</div>
				<div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
					<a href="detailedProduct.jsp?id=<%=pid%>"><h3><%=pname%></h3></a>
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
		<%
			}
				}else{
					Iterator itr=idList.iterator();
					while(itr.hasNext()){
						sql = "select * from product_details where id='"+itr.next()+"'";
						PreparedStatement pst = con.prepareStatement(sql);
						ResultSet rs = pst.executeQuery();

						while (rs.next()) {
							pid = rs.getInt("id");
							String pname = rs.getString("product_name");
							double pprice = rs.getDouble("product_price");
							String pimg1 = rs.getString("image1");
			%>

			<div class="container-fluid">
				<div class="row">
					<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
						<img src="product_img/<%=pimg1%>">
					</div>
					<div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
						<a href="detailedProduct.jsp?id=<%=pid%>"><h3><%=pname%></h3></a>
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
			<%
				}
					
					}
				}
			} catch (Exception e) {
				System.out.println("Exception " + e);
			}
			session.setAttribute("idList", null);
		%>
	</section>
	<section id="address">
		<h2>
			<b>Add a new address</b>
		</h2>
		<form  action="addressserver.jsp">
			<div class="form-group">
				<label>Country/region</label> <select class="form-control" id="city"
					name="country">
					<option>India</option>
					<option>UK</option>
					<option>US</option>
				</select>
			</div>
			<div class="form-group">
				<label>Full Name</label><input type="text" class="form-control"
					id="fullname" name="fullname">
			</div>
			<div class="form-group">
				<label>Mobile number</label><input type="text" class="form-control"
					id="mobile" name="mobile">
			</div>
			<div class="form-group">
				<label>Pincode</label><input type="text" class="form-control"
					id="pincode" name="pincode">
			</div>
			<div class="form-group">
				<label>Flat,House no.,Building,company,Apartment</label><input
					type="text" class="form-control" id="flat" name="flat">
			</div>
			<div class="form-group">
				<label>Area, Street, Sector, Village</label><input type="text"
					class="form-control" id="area" name="area">
			</div>
			<div class="form-group">
				<label>Landmark</label><input type="text" class="form-control"
					id="landmark" name="landmark">
			</div>
			<div class="form-group col-lg-6">
				<label>Town/city</label><input type="text" class="form-control"
					id="city" name="city">
			</div>
			<div class="form-group col-lg-6">
				<label>State</label> <select class="form-control" id="state"
					name="state">
					<option>Choose a State</option>
					<option>Maharastra</option>
					<option>Uttarpradesh</option>
					<option>Madhyapradesh</option>
					<option>Gujarat</option>
				</select>
			</div>


			<button type="submit" class="btn btn-primary" id="submit">Add
				Address</button>
		</form>
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
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="js/app.js"></script>
	<script src="js/sidebarjs.js"></script>
</body>

</html>