

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
String otp=request.getParameter("otp");
try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
	String sql="update signup_dataseller set status='1' where otp='"+otp+"'";
	PreparedStatement pst=con.prepareStatement(sql);
	int i=pst.executeUpdate();
	if(i>0){
		session.setAttribute("sesotpsell", "Registration successful");
		response.sendRedirect("sellersignin.jsp");
	}else{
		session.setAttribute("sesotpsell", "Wrong OTP");
		response.sendRedirect("regsellerotp.jsp");
	}
}catch(Exception e){
	
}
%>