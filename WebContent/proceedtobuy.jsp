<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/buyforma.css" />
</head>
<body>
	<img src="img/checkout.jpg">
	<% double tamt=0;
		List cart = new ArrayList();
	String seslog = (String) session.getAttribute("seslog");
	%>
	
	<div class="tab_container">
		<input id="tab1" type="radio" name="tabs" > <label for="tab1"><span
			class="numberCircle">1</span><span>Cart</span></label> <input id="tab2"
			type="radio" name="tabs"> <label for="tab2"><span
			class="numberCircle">2</span><span>Customer Information</span></label> <input
			id="tab3" type="radio" name="tabs"> <label for="tab3"><span
			class="numberCircle">3</span><span>Order Summary</span></label> <input id="tab4"
			type="radio" name="tabs" checked> <label for="tab4"><span
			class="numberCircle">4</span><span>Payment</span></label>


		<section id="content1" class="tab-content">
		<div >
		<%	List list=new ArrayList();
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
					list.add(id);
					list.add(qyt);
					
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
							cart.add(pname);
							cart.add("Price : "+pprice);
							cart.add("Qyt : "+qyt);
							cart.add("Totol Price : "+qyt*pprice);
							cart.add("---------------------------------------------------");
							
		%>

		<div class="container-fluid ">
			<div class="row">
				<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
					<img src="product_img/<%=pimg1%>" style="width:50px; height:50px">
				</div>
				<div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
					<a href="detailedProduct.jsp?id=<%=id%>"><h4><%=pname%></h4></a>
					<h4>
						<strong> &#8377;<%=pprice%></strong>
					</h4>
					<div class="form-group">
						Quantity:&nbsp;<%=qyt %>
					</div>
				</div>
				<div>Total price :<strong> &#8377;<%=qyt*pprice%></strong></div>
				<%tamt=tamt+qyt*pprice; %>
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

		<section id="content2" class="tab-content">
		<div class="container-fluid">
			<div class="row">
				<div class="col1 col-lg-4 col-md-4 col-sm-6 col-xs-6">
					<h2><strong>1.Delivary address</strong></h2>
					<% List address=new ArrayList();
					try{
						Class.forName("com.mysql.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
						String sql = "select * from address_data where email='"+seslog+"'";
						PreparedStatement pst = con.prepareStatement(sql);
						ResultSet rs = pst.executeQuery();
						while (rs.next()) {
							String fname=rs.getString("fullname");
							String houseno=rs.getString("houseno");
							String area=rs.getString("area");
							String landmark=rs.getString("landmark");
							String city=rs.getString("city");
							String state=rs.getString("state");
							String pincode=rs.getString("pincode");
							
							address.add(fname);
							address.add(houseno+" "+area);
							address.add(landmark);
							address.add(city+" "+state+" "+pincode);
							%>
							<p><%=fname %></p>
							<p><%=houseno %> <%=area %></p>
							<p><%=landmark %></p>
							<p><%=city %> <%=state %> <%=pincode %></p>
							
							<% 
						}
					}catch(Exception e){
						
					}
					%>
				</div>
				
			</div>
		</div>
		</section>

		<section id="content3" class="tab-content">
		Items : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8377;<%=tamt %><br>
		Delivery: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8377;40.00<br>
		Total : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8377;<%=tamt+40 %><br>
		Promotion applied:&nbsp;&nbsp; &#8377;-40.00<br>
		<hr>
		<Strong>Order Total : &nbsp;&nbsp;&#8377;<%=tamt %></Strong>
		<%double total=tamt+40;
		List amount=new ArrayList();
		amount.add("Items : "+tamt);
		amount.add("Delivery : "+40.00);
		amount.add("Total : "+total);
		amount.add("Promotion applied : -40.00");
		amount.add("Order Total : "+tamt);
		%>
		</section>

		<section id="content4" class="tab-content">
		<h4 class="payment-title">Choose your payment method</h4>
		<form action="" method="post">
			<div class="pymt-radio">


				<div class="row-payment-method payment-row">
					<div class="select-icon">
						<input type="radio" id="radio1" name="radios" value="">
						<label for="radio1"></label>
					</div>
					<div class="select-txt">
						<p class="pymt-type-name">Pay On Delivery</p>
						<p class="pymt-type-desc">Pay After you get your order</p>
					</div>
					<div class="select-logo">
					</div>
				</div>
			</div>
			
			
			
			<div class="button-master-container">
				<div class="button-container">
					<a href="cart.jsp">Back to Cart</a>
				</div>
				<div class="button-container button-finish">
					<a href="finishorder.jsp">Finish Order</a>
				</div>
			</div>
		</form>
		</section>
	</div>
	<% 
	session.setAttribute("cart", cart);
	session.setAttribute("address", address);
	session.setAttribute("amount", amount);
	session.setAttribute("list", list);
	%>
	<script>
	$(document).ready(function(){
		
	});
	</script>
	
	
	
</body>
</html>