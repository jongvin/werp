<%--
/*
 * ���ϸ� : doDownload.jsp
 * �ۼ��� : �ȿ���
 * ��  �� : ÷������ �ٿ�ε� ����
 */
--%><%@ page contentType="application/unknown" language="java" import="java.io.*"
%><%
String filenameDB = request.getParameter("file");
String filenameUp = filenameDB;  //������ ����� �̸�
String filenameDn = filenameDB;  //����ڰ� �޴� �̸�

int qmark = filenameDB.lastIndexOf('?');
if (qmark != -1) {  //����ǥ?���� �� �ִٸ�, �� ���ϸ�ó���� �ؾ��Ѵٸ�
 filenameDn = filenameDB.substring(0,qmark);

 int insert = filenameDB.lastIndexOf('.');  //���� ���ϸ��� ���ڰ� �� ��ġ
 if (insert == -1) {
  insert = qmark;
 }
 filenameUp = filenameDB.substring(0,insert) + filenameDB.substring(qmark+1) + filenameDB.substring(insert,qmark);    //���ϸ�պκ�+����+Ȯ����
}

// IE 5.5�� ������ �ٸ��Ƿ� ����� ���� �ٸ��� ó���� �ش�.
if (request.getHeader("User-Agent").indexOf("MSIE 5.5") > -1) {
 response.setHeader("Content-Disposition", "filename="+filenameDn);
} else {
 response.setHeader("Content-Disposition", "attachment; filename="+filenameDn);
}

String path = application.getRealPath("/uploads/mail/" + new String(filenameUp.getBytes("ISO-8859-1"), "KSC5601"));
File file = new File(path);
response.setContentLength((int)file.length());  //����ũ�⸦ �������� �˷��ش�.
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
