<!DOCTYPE html>
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
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/pstyle.css" />
<link rel="stylesheet" href="css/prosidebar.css" />

</head>

<body>

	<script type="text/javascript">
		
	<%int pid = Integer.parseInt(request.getParameter("id"));
	session.setAttribute("pid", pid);
	%>
		$(document).ready(function() {
			$("#cartbtn").click(function() {
				var qyt = $("#qyt").val();
				var id =<%=pid%>;
				$.get("cartserver.jsp", {
					qyt : qyt,
					pid : id
				}, function(data, status) {
					alert(data);
				});
			});

			 $("select.id").change(function(){

		            var selectedid  = $(".id option:selected").val();
		            $("#link").attr("href","buynow.jsp?qyt="+selectedid);  //-----this will change href 
		        });
		});
	</script>

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
							</a> <a class="nav-a" href="dashboard.jsp"> <span><%=seslog%></span></a>
							<a class="nav-a" href="order.jsp"><span>Return </span> &amp;
								Orders </a> <a class="nav-a cart" href="cart.jsp"> <span><%=count%></span>Cart
							</a>
						</div>

					</div>

					<div class="nav-fill">
						<div id="nav-search">
							<form action="search.jsp">
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
							<li><a href="#">Help</a></li>

						</ul>
					</div>
				</nav>
			</div>
		</div>
	</header>
	<%
		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "select * from product_details where id='" + pid + "'";
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				String storename = rs.getString("seller_name");
				String pname = rs.getString("product_name");
				double pprice = rs.getDouble("product_price");
				String pimg1 = rs.getString("image1");
				String pimg2 = rs.getString("image2");
				String specification = rs.getString("specification");
	%>

	<section class="prodetails">
		<div class="container-fluid">
			<div class="row">
				<div class="col1 col-lg-5 col-md-5 col-sm-6 col-xs-6">
					<!--  <img src="img/product_1.jpg">-->
					<div id="promo-carousel" class="carousel slide"
						data-ride="carousel">
						<div class="carousel-inner" role="listbox">
							<div class="item active">
								<img src="product_img/<%=pimg1%>">
							</div>
							<div class="item">
								<img src="product_img/<%=pimg2%>">
							</div>

						</div>
						<!-- Controls -->
						<a class="left carousel-control" href="#promo-carousel"
							role="button" data-slide="prev"> <span
							class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							<span class="sr-only">Previous</span>
						</a> <a class="right carousel-control" href="#promo-carousel"
							role="button" data-slide="next"> <span
							class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>


				</div>
				<div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4">
					<h3><%=pname%></h3>
					<a href="#">Visit <%=storename%> Store
					</a>
					<hr>
					<h3>
						<strong> &#8377;<%=pprice%></strong>
					</h3>
					<p>Inclusive of all taxes</p>
					<hr>
					<div class="row" style="text-align: center;">
						<div class="col2 col-lg-3 col-md-3 col-sm-3 col-xs-3">
							<img src="proimage/freedelivary.jpg"> <a>Free Delivery</a>
						</div>
						<div class="col2 col-lg-3 col-md-3 col-sm-3 col-xs-3">
							<img src="proimage/payondelivary.jpg"> <a>Pay on
								delivery</a>
						</div>
						<div class="col2 col-lg-3 col-md-3 col-sm-3 col-xs-3">
							<img src="proimage/10daysreturn.jpg"> <a>10 days return
								& exchange</a>
						</div>
						<div class="col2 col-lg-3 col-md-3 col-sm-3 col-xs-3">
							<img src="proimage/delivered.jpg"> <a>Amazon Delivered</a>
						</div>
					</div>
					<hr>
					<p><%=specification%></p>
				</div>
				<div class="colcart col-lg-3 col-md-3 col-sm-3 col-xs-3">
					<div class="proside">
						<h3>
							<strong> &#8377;<%=pprice%></strong>
						</h3>
						<a>FREE delivery</a><strong> Sunday, 25 December</strong>
						<h3>In stock</h3>
						<a>Sold by Cocoblu Retail and Fulfilled by Amazon.</a><br>
						<div class="form-group">
							<label for="">Quantity</label> 
							<select class="id" id="qyt" name="qyt">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
							</select>
						</div>
						<button class="btn" style="margin: 10px" id="cartbtn">Add
							to Cart</button>
						<br> <a id="link" href="buynow.jsp?qyt=1"
							class="btn" type="submit" style="margin: 10px" id="buybtn">Buy
							Now</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%
		}
		} catch (Exception e) {
			out.println("Exception : " + e);
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