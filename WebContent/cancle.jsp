<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
	String email = (String) session.getAttribute("seslog");
	int id = Integer.parseInt(request.getParameter("id"));
	int qyt = Integer.parseInt(request.getParameter("qyt"));
	//add into cancel order book
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
		String sql1 = "insert into cancle_order (email,id,qyt) values" + "('" + email + "','" + id + "','"
				+ qyt + "')";
		PreparedStatement pst1 = con1.prepareStatement(sql1);
		int i = pst1.executeUpdate();
		if (i > 0) {
			System.out.println("cancle Order");
			
		}
	} catch (Exception e) {
		out.println("Exception : " + e);
	}
	
	//added qyt to seller stock
	int sellerqyt=0;
	int pprice=0;
	String sellername=null;
	String pname=null;
	try{ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","");
		String sql="select * from product_details where id='"+id+"' ";
		PreparedStatement pst=con.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		while(rs.next()){
			sellerqyt=rs.getInt("no_of_qyt");
			pname = rs.getString("product_name");
			pprice = rs.getInt("product_price");
			sellername=rs.getString("seller_name");
		}	
		//update seller qyt
		sellerqyt=sellerqyt+qyt;
		Class.forName("com.mysql.jdbc.Driver");
		Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","");
		String sql1="update product_details set no_of_qyt='"+sellerqyt+"' where id='"+id+"' ";
		PreparedStatement pst1=con1.prepareStatement(sql1);
		int j=pst1.executeUpdate();
		if(j>0){
			System.out.println("seller qyt change");
		}
		
		//sending msg to seller
		String subject2 = "Order placed for your Product Cancled";

		//Get properties object    
		Properties props2 = new Properties();
		props2.put("mail.smtp.host", "smtp.gmail.com");
		props2.put("mail.smtp.socketFactory.port", "465");
		props2.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props2.put("mail.smtp.auth", "true");
		props2.put("mail.smtp.port", "465");

		//get Session 
		Session session2 = Session.getInstance(props2, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("vaibhavwadibhasme1@gmail.com", "owtxgctlxhpjcbni");
			}
		});

		//compose message
		String sellermsg = "------------------------------------------\nProduct Name : " + pname
				+ "\nProduct Price : " + pprice + "\nOrder Qyt : " + qyt + "\nOrder Price : " + qyt * pprice
				+ "\nQyt remaining : " + sellerqyt+ "\n------------------------------------------";
		try {
			MimeMessage message = new MimeMessage(session2);
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(sellername));
			message.setSubject(subject2);
			message.setText(sellermsg);
			//send message  
			Transport.send(message);
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

		//msg to Buyer
		String subject = "Your order Cancled sucessfully";
		String msg= "------------------------------------------\nProduct Name : " + pname
				+ "\nProduct Price : " + pprice + "\nOrder Qyt : " + qyt + "\nOrder Price : " + qyt * pprice
				+ "\n------------------------------------------";
		//Get properties object    
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		//get Session 
		Session session1 = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("vaibhavwadibhasme1@gmail.com", "owtxgctlxhpjcbni");
			}
		});

		//compose message 
		try {
			MimeMessage message = new MimeMessage(session1);
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject(subject);
			message.setText(msg);
			//send message  
			Transport.send(message);
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

		
	}catch(Exception e){
		out.println("Exception : "+e);
	}
	
	//delet from cart
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
		String sql1 = "delete from cart where email='"+email+"' and id='"+id+"'and qyt='"+qyt+"' and status='1'";
		PreparedStatement pst1 = con1.prepareStatement(sql1);
		int i = pst1.executeUpdate();
		if (i > 0) {
			System.out.println("delete from cart");
			
		}
	} catch (Exception e) {
		out.println("Exception : " + e);
	}

	response.sendRedirect("order.jsp");
%>