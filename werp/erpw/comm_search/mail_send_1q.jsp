<%@ page session="true" contentType="text/html;charset=euc-kr"  import="java.text.*,java.util.*,javax.mail.*,javax.mail.internet.*,java.lang.*,javax.activation.*,java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
%><%
	//���� ����
	String from="������";//�̸�
	String fromemail="";//������ �̺���
	String toemail="";//�޴� �̸���
	String ccemail=""; //����
	String subject="";//����
	String msgtext="";//����
	String host="";
	String filename = "";
	String filename2 = "";
	String filename3 = "";
	String filename4 = "";
	//����ڰ� �Է��� ������ �޾� �´�...
	from=req.getParameter("from");
	fromemail=req.getParameter("email");
	subject=req.getParameter("subject");
	msgtext=req.getParameter("msgtext");
	toemail=req.getParameter("to");
	

	//�̰��� ������ ���ε�Ǵ°��� �����Դϴ�.
//	filename ="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file1");
//	filename2="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file2");
//	filename3="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file3");
//	filename4="/ias/werp/werp/erpw/const/c_web/picture/"+req.getParameter("file4");
	
	//JavaMail�� Session�� Debug �Ӽ��� ����
	// boolean �� �ڷ����� �����ϰ� false�� �Ҵ��Ѵ�.
	boolean debug = false;
	host="mail.worldro.co.kr";

	//Session�� �����ϱ� ���� Java.util.PropertiesŬ������ �����ϰ� 
	//SMTPȣ��Ʈ �ּҸ� �Ҵ��Ѵ�.
	Properties props = new Properties();
	props.put("mail.smtp.host",host);

	//�⺻ Session�� �����ϰ� �Ҵ��մϴ�.
	Session msgSession = Session.getDefaultInstance(props,null);
	msgSession.setDebug(debug);
	try{

		//Message Ŭ������ ��ü�� 
		//Session�� �̿��Ͽ� �����մϴ�.
		MimeMessage msg = new MimeMessage(msgSession);

		//From�� �����մϴ�.
		//InternetAddress from = new InternetAddress(fromemail);
		//msg.setFrom(from);
		InternetAddress fadd = new InternetAddress();
		fadd.setAddress(fromemail); // ������ ��� email
		fadd.setPersonal(from,"EUC-KR"); // ������ ��� �̸�
		msg.setFrom(fadd);	

		//������ �����մϴ�.
		msg.setSubject(subject);

		//������ �����մϴ�.
		//msg.setText(msgtext, "euc-kr");
		
		//������ �����մϴ�.
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