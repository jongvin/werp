<%@ page language="java" page contentType="text/html;charset=euc-kr"  
%><%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy, java.util.*, java.io.*" 
%>

<%! String fileName; 
        String dir_name; %>

<%
 dir_name = request.getParameter("dir_name");
 dir_name=new String(dir_name.getBytes("8859_1"), "KSC5601"); 

 int sizeLimit = 20 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생

 try{

    String upload_dir = (String) session.getAttribute("file_upload_dir");
	//dir_name = "안전관리";
	String savePath= upload_dir+dir_name+"\\";

	File file = new File(savePath);
	if (! file.isDirectory() ) {
		file.mkdir();
	}
    
    MultipartRequest multi=new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
 	Enumeration formNames=multi.getFileNames();  // 폼의 이름 반환
	String formName=(String)formNames.nextElement(); // 자료가 많을 경우엔 while 문을 사용
	fileName=multi.getFilesystemName(formName); // 파일의 이름 얻기

	 

	if(fileName == null) {   // 파일이 업로드 되지 않았을때
	    throw new Exception("Upload Error");
		//out.print("파일 업로드 되지 않았음");
	} else {  // 파일이 업로드 되었을때
		fileName=new String(fileName.getBytes("KSC5601"), "8859_1");
		//out.print("User Name : " + multi.getParameter("userName") + "<BR>");
		//out.print("Form Name : " + formName + "<BR>");
		out.print("File Name  : " + fileName);
	} // end if

 } catch(Exception ex) {
	//out.print("예외 상황 발생..! ");
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
