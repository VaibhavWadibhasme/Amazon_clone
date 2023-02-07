
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
String seslogseller = (String) session.getAttribute("seslogseller");
int id=Integer.parseInt(request.getParameter("id"));
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
	String sql = "delete from product_details where seller_name='" + seslogseller + "'and id='"+id+"'";
	PreparedStatement pst = con.prepareStatement(sql);
	int i=pst.executeUpdate();
	if(i>0){
		response.sendRedirect("sellerdashboard.jsp");
	}
}catch(Exception e){
	out.println(e);
}

%>