

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
String otp=request.getParameter("otp");
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
	String sql="update signup_data set status='1' where otp='"+otp+"'";
	PreparedStatement pst=con.prepareStatement(sql);
	int i=pst.executeUpdate();
	if(i>0){
		session.setAttribute("sesregsell", "Registration successful");
		response.sendRedirect("signin.jsp");
	}else{
		session.setAttribute("sesotp", "Wrong OTP");
		response.sendRedirect("regotp.jsp");
	}
}catch(Exception e){
	
}
%>