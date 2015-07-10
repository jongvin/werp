<%--
/*
 * 파일명 : doDownload.jsp
 * 작성자 : 안영섭
 * 내  용 : 첨부파일 다운로드 실행
 */
--%><%@ page contentType="application/unknown" language="java" import="java.io.*"
%><%
String filenameDB = request.getParameter("file");
String filenameUp = filenameDB;  //서버에 저장된 이름
String filenameDn = filenameDB;  //사용자가 받는 이름

int qmark = filenameDB.lastIndexOf('?');
if (qmark != -1) {  //물음표?숫자 가 있다면, 즉 파일명처리를 해야한다면
 filenameDn = filenameDB.substring(0,qmark);

 int insert = filenameDB.lastIndexOf('.');  //서버 파일명에서 숫자가 들어갈 위치
 if (insert == -1) {
  insert = qmark;
 }
 filenameUp = filenameDB.substring(0,insert) + filenameDB.substring(qmark+1) + filenameDB.substring(insert,qmark);    //파일명앞부분+숫자+확장자
}

// IE 5.5는 형식이 다르므로 헤더를 각각 다르게 처리해 준다.
if (request.getHeader("User-Agent").indexOf("MSIE 5.5") > -1) {
 response.setHeader("Content-Disposition", "filename="+filenameDn);
} else {
 response.setHeader("Content-Disposition", "attachment; filename="+filenameDn);
}

String path = application.getRealPath("/uploads/mail/" + new String(filenameUp.getBytes("ISO-8859-1"), "KSC5601"));
File file = new File(path);
response.setContentLength((int)file.length());  //파일크기를 브라우저에 알려준다.
byte buffer[] = new byte[2048];
BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
BufferedOutputStream sout = new BufferedOutputStream(response.getOutputStream());

try {
 int n=0;
 while((n = fin.read(buffer,0,2048)) != -1) {
  sout.write(buffer,0,n);
 }
} finally {
 sout.close();
 fin.close();
}
%>
