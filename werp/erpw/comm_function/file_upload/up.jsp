<%@ page language="java" page contentType="text/html;charset=euc-kr"  
%><%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, java.util.*, java.io.*" 
%>

<%! String fileName; 
        String dir_name; %>

<%
 dir_name = request.getParameter("dir_name");
 dir_name=new String(dir_name.getBytes("8859_1"), "KSC5601"); 

 int sizeLimit = 20 * 1024 * 1024 ; // 5�ް����� ���� �Ѿ�� ���ܹ߻�

 try{

    String upload_dir = (String) session.getAttribute("file_upload_dir");
	//dir_name = "��������";
	String savePath= upload_dir+dir_name+"\\";

	File file = new File(savePath);
	if (! file.isDirectory() ) {
		file.mkdir();
	}
    
    MultipartRequest multi=new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
 	Enumeration formNames=multi.getFileNames();  // ���� �̸� ��ȯ
	String formName=(String)formNames.nextElement(); // �ڷᰡ ���� ��쿣 while ���� ���
	fileName=multi.getFilesystemName(formName); // ������ �̸� ���

	 

	if(fileName == null) {   // ������ ���ε� ���� �ʾ�����
	    throw new Exception("Upload Error");
		//out.print("���� ���ε� ���� �ʾ���");
	} else {  // ������ ���ε� �Ǿ�����
		fileName=new String(fileName.getBytes("KSC5601"), "8859_1");
		//out.print("User Name : " + multi.getParameter("userName") + "<BR>");
		//out.print("Form Name : " + formName + "<BR>");
		out.print("File Name  : " + fileName);
	} // end if

 } catch(Exception ex) {
	//out.print("���� ��Ȳ �߻�..! ");
	throw new Exception(ex.getMessage());
 } 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<META http-equiv=Content-Type content="text/html; charset=euc-kr">
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			function set_name(){
				parent.upload_ok("<%=fileName%>")
                //alert("<%=dir_name%>")
		    }
		//-->
		</SCRIPT>
	</head>
	<body onload="set_name()">
	</body>
</html>
