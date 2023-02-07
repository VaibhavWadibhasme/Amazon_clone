
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page
	import="org.eclipse.jdt.internal.compiler.flow.TryFlowContext, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement"%>
<%
	String name = request.getParameter("name");
	String mobile = request.getParameter("mobile");
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/amazon", "root", "");
		String sql = "select * from signup_dataseller where email='" + email + "'";
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();
		if (!rs.next()) {
			Random rng = new Random();
			int otp = rng.nextInt(99999) + 100000;
			try {
				String sql1 = "insert into signup_dataseller (name,mobile,email,password,otp,status)values('"
						+ name + "','" + mobile + "','" + email + "','" + password + "','" + otp + "','0')";
				PreparedStatement pst1 = con.prepareStatement(sql1);
				int i = pst1.executeUpdate();
				if (i > 0) {
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
							return new PasswordAuthentication("vaibhavwadibhasme1@gmail.com",
									"owtxgctlxhpjcbni");
						}
					});

					//compose message 
					try {
						MimeMessage message = new MimeMessage(session1);
						message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
						message.setSubject("Email varification");
						message.setText("OTP : " + otp);
						//send message  
						Transport.send(message);
						response.sendRedirect("regsellerotp.jsp");
					} catch (MessagingException e) {
						throw new RuntimeException(e);
					}
				}
			} catch (Exception e) {
				out.println("Exception : " + e);
			}
		} else {
			session.setAttribute("sesregsell", "Email Already Exits");
			response.sendRedirect("sellersignin.jsp");
		}
	} catch (Exception E) {
		out.println(E);
	}
%>