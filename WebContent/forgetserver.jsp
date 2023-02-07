<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Random"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%
	String email = request.getParameter("email");
	Random rng = new Random();
	int otp = rng.nextInt(99999) + 100000;
	session.setAttribute("sesemail", email);
	session.setAttribute("sesotp", otp);

	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon","root","");
		String sql="select * from signup_data where email='"+email+"'";
		PreparedStatement pst=con.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		if(rs.next()){
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
				message.setSubject("OTP Verification");
				message.setText("This is your otp for password " + otp);
				//send message  
				Transport.send(message);
				response.sendRedirect("forgetotp.jsp");
			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}

		}else{
			session.setAttribute("seslog1", "Email Not Registrated");
			response.sendRedirect("signin.jsp");
		}
	}catch(Exception e){
		out.println(e);
	}
	
	%>
