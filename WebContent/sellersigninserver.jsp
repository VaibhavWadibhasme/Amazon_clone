
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","");
		String sql="select * from signup_dataseller where email='"+email+"'and password='"+password+"'";
		PreparedStatement pst=con.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		if(rs.next()){
			session.setAttribute("seslogseller", email);
			response.sendRedirect("sellerdashboard.jsp");
		}else{
			session.setAttribute("seslog1", "Login failed");
			response.sendRedirect("sellersignin.jsp");
		}
	}catch(Exception e){
		
	}
%>