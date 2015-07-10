<%@ page session="true" contentType="text/html;charset=euc-kr"  import="java.text.*,java.util.*,javax.mail.*,javax.mail.internet.*,java.lang.*,javax.activation.*,java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
%><%
	//변수 설정
	String from="관리자";//이름
	String fromemail="";//보내는 이베일
	String toemail="";//받는 이메일
	String ccemail=""; //참조
	String subject="";//제목
	String msgtext="";//내용
	String host="";
	String filename = "";
	String filename2 = "";
	String filename3 = "";
	String filename4 = "";
	//사용자가 입력한 내용을 받아 온다...
	from=req.getParameter("from");
	fromemail=req.getParameter("email");
	subject=req.getParameter("subject");
	msgtext=req.getParameter("msgtext");
	toemail=req.getParameter("to");
	

	//이곳은 파일이 업로드되는곳의 설정입니다.
//	filename ="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file1");
//	filename2="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file2");
//	filename3="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file3");
//	filename4="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file4");
	
	//JavaMail의 Session의 Debug 속성을 설정
	// boolean 형 자료형을 선언하고 false를 할당한다.
	boolean debug = false;
	host="mail.worldro.co.kr";

	//Session을 생성하기 위해 Java.util.Properties클래스를 생성하고 
	//SMTP호스트 주소를 할당한다.
	Properties props = new Properties();
	props.put("mail.smtp.host",host);

	//기본 Session을 생성하고 할당합니다.
	Session msgSession = Session.getDefaultInstance(props,null);
	msgSession.setDebug(debug);
	try{

		//Message 클래스의 객체를 
		//Session을 이용하여 생성합니다.
		MimeMessage msg = new MimeMessage(msgSession);

		//From을 세팅합니다.
		//InternetAddress from = new InternetAddress(fromemail);
		//msg.setFrom(from);
		InternetAddress fadd = new InternetAddress();
		fadd.setAddress(fromemail); // 보내는 사람 email
		fadd.setPersonal(from,"EUC-KR"); // 보내는 사람 이름
		msg.setFrom(fadd);	

		//제목을 설정합니다.
		msg.setSubject(subject);

		//내용을 설정합니다.
		//msg.setText(msgtext, "euc-kr");
		
		//메일을 전송합니다.
		InternetAddress to = new InternetAddress(toemail);
		msg.setRecipient(Message.RecipientType.TO, to);
		
		MimeBodyPart mbp1 = new MimeBodyPart();
		mbp1.setText(msgtext);

		Multipart mp = new MimeMultipart();
		mp.addBodyPart(mbp1);

		if(req.getParameter("file1").compareTo("") == 0){ 
		}else{
			MimeBodyPart mbp2 = new MimeBodyPart();
      FileDataSource fds = new FileDataSource(filename);
	    mbp2.setDataHandler(new DataHandler(fds));
	    mbp2.setFileName(fds.getName());
      mp.addBodyPart(mbp2); 
		}
 	 	
		if(req.getParameter("file2").compareTo("") == 0){
		}else { 
			MimeBodyPart mbp3 = new MimeBodyPart();
			FileDataSource fds2 = new FileDataSource(filename2);
			mbp3.setDataHandler(new DataHandler(fds2));
			mbp3.setFileName(fds2.getName());
			mp.addBodyPart(mbp3); 
		}
 		
		if(req.getParameter("file3").compareTo("") == 0){
		}else{  	
			MimeBodyPart mbp4 = new MimeBodyPart();
			FileDataSource fds3 = new FileDataSource(filename3);
			mbp4.setDataHandler(new DataHandler(fds3));
			mbp4.setFileName(fds3.getName());
			mp.addBodyPart(mbp4);
		}
 	 	
		if(req.getParameter("file4").compareTo("") == 0){
		}else { 
			MimeBodyPart mbp5 = new MimeBodyPart();
			FileDataSource fds4 = new FileDataSource(filename4);
			mbp5.setDataHandler(new DataHandler(fds4));
			mbp5.setFileName(fds4.getName());
			mp.addBodyPart(mbp5);
		}
		msg.setContent(mp);
      msg.setSentDate(new Date());
		Transport.send(msg);	
}catch(MessagingException e){
}%><%@ 
%>