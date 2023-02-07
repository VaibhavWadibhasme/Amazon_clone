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

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="css/seller_dashstyle.css" />
<link rel="stylesheet" href="css/s_sidebarcss.css" />


</head>

<body>
	<script>
		$(document).ready(function(){
			$("#myproducts").show();
			$("#addnewproducts").hide();
		});
	</script>
	<%
		String message = (String) session.getAttribute("message");
		if (message != null) {
	%>
	<script>alert("<%=message%>
		")
	</script>
	<%
		}
		session.setAttribute("message", null);
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
								String seslogseller = (String) session.getAttribute("seslogseller");
							%>
							<a class="nav-a" href="sellerdashboard.jsp"> <span><%=seslogseller%></span></a>
							<a class="nav-a" href="sellerorders.jsp"><span>Return
							</span> &amp; Orders </a>
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
									<i class="fa fa-user-circle"></i> <a href=""
										style="color: white;">Hello, <%=seslogseller%></a>
								</div>
								<!--Below SideNavHeader-->
								<div id="main-container">
									<!-- <div class="sidenavContentHeader">Help & Settings</div> -->
									<a href="#"><div class="sidenavContent">Home</div></a> <a
										href="#"><div class="sidenavContent">Your Account</div></a> <a
										href="#"><div class="sidenavContent" id="myproductid">Your
											Product</div></a> <a href="#"><div class="sidenavContent"
											id="addnewproductid">Add New Product</div></a> <a
										href="sellerlogout.jsp"><div class="sidenavContent">Log
											Out</div></a>
									<div style="height: 50px"></div>
								</div>
								<!--End of first container-->


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

	<section id="addnewproducts">
		<div class="container-fluid">
			<div class="row">
				<div class="col">
					<!-- Button to Open the Modal -->
					<button type="button" class="btn btn-primary btn-lg btn-block"
						data-toggle="modal" data-target="#myModal">Add New
						Product</button>
				</div>
			</div>
			<!-- The Modal -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">Enter Product Details</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="container" style="font-size: 18px; margin: 10px;">
							<form action="productserver.jsp" method="post"
								enctype="multipart/form-data">
								<table>
									<tr>
										<td><strong>Product Name</strong></td>
										<td><input type="text" name="pname" value=""></td>
									</tr>

									<tr>
										<td><strong>Category</strong></td>
										<td><select class="" id="category" name="category">
												<option>All Departments</option>
												<option>Beauty &amp; Personal Care</option>
												<option>Books</option>
												<option>Cell Phones &amp; Accessories</option>
												<option>Clothing, Shoes &amp; Jewelry</option>
												<option>Women</option>
												<option>Men</option>
												<option>Girls</option>
												<option>Boys</option>
												<option>Baby</option>
												<option>Computers</option>
												<option>Electronics</option>
												<option>Grocery &amp; Gourmet Food</option>
												<option>Health, Household &amp; Baby Care</option>
												<option>Home &amp; Kitchen</option>
												<option>Luggage &amp; Travel Gear</option>
										</select></td>
									</tr>
									<tr>
										<td><strong>Search Name</strong></td>
										<td><input type="text" name="sname" value=""></td>

									</tr>
									<tr>
										<td><strong>Product Price</strong></td>
										<td><input type="text" name="pprice" value=""></td>

									</tr>
									<tr>
										<td><strong>No Of Quantity</strong></td>
										<td><input type="text" name="quantity" value=""></td>

									</tr>
									<tr>
										<td><strong>Specification</strong></td>
										<td><textarea id="specification" name="specification"
												rows="3"></textarea></td>
									</tr>
									<tr>
										<td><strong>Product Image</strong></td>
										<td><input type="file" class="form-control-file"
											id="image1" name="image1"></td>

									</tr>
									<tr>
										<td><strong>Product Image</strong></td>
										<td><input type="file" class="form-control-file"
											id="image2" name="image2"></td>

									</tr>

									<tr>
										<td><button class="btn btn-primary" type="submit"
												id="amazon">Add Product to sell</button></td>
									</tr>
								</table>
							</form>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</section>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
			String sql = "select * from product_details where seller_name='" + seslogseller + "'";
			PreparedStatement pst = con.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				int id = rs.getInt("id");
				String pname = rs.getString("product_name");
				double pprice = rs.getDouble("product_price");
				String pimg = rs.getString("image1");
				int qyt = rs.getInt("no_of_qyt");
				String spec = rs.getString("specification");
				String sname = rs.getString("search_name");
	%>
	<section id="myproducts">
		<div class="container-fluid">
			<div class="row">
				<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
					<img src="product_img/<%=pimg%>">
				</div>
				<div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
					<a href=""><h3><%=pname%></h3></a>
					<h3>
						<strong> &#8377;<%=pprice%></strong>
					</h3>

					<p>
						<strong>Quantity : &nbsp;</strong><%=qyt%>
					</p>
					<div>
						<p>
							<strong>Specification : &nbsp;</strong><%=spec%></p>
					</div>
					<div>
						<p>
							<strong>Search Name : &nbsp;</strong><%=sname%></p>
					</div>
					<div style="margin:10px;">
						<a class="btn" type="submit" href="deleteproduct.jsp?id=<%=id%>">Delete
							Product</a><a class="btn" type="submit" style="margin-left:10px;"
							href="updateproduct2.jsp?id=<%=id%>">Update Details</a>
					</div>
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
	<script src="js/s_app.js"></script>
	<script src="js/s_sidebarjs.js"></script>
</body>

</html>