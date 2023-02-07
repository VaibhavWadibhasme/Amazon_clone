
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
	String seslog = (String) session.getAttribute("seslog");
	String country = request.getParameter("country");
	String fullname = request.getParameter("fullname");
	String mobile = request.getParameter("mobile");
	String pincode = request.getParameter("pincode");
	String flat = request.getParameter("flat");
	String area = request.getParameter("area");
	String landmark = request.getParameter("landmark");
	String city = request.getParameter("city");
	String state = request.getParameter("state");								
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
		String sql = "insert into address_data (email,country,fullname,mobile,pincode,houseno,area,landmark,city,state) values" 
				+"('"+seslog+"','"+country+"','"+fullname+"','"+mobile+"','"+pincode+"','"+flat+"','"+area+"','"+landmark+"','"+city+"','"+state+"')";
		PreparedStatement pst = con.prepareStatement(sql);
		int i=pst.executeUpdate();
		if(i>0){
			response.sendRedirect("dashboard.jsp");
		}
	}catch(Exception e){
		out.println("Exception : "+e);
	}
%>