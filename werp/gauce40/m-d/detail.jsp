<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="100"> 
    <dh>
      <def name="DEPTCD" type="string" size="10"/>
      <def name="EMPNO" type="string" size="20"/>
      <def name="EMPNM" type="string" size="20"/>
      <def name="POSITION" type="string" size="20"/>
      <def name="TELNO" type="string" size="20"/>
      <def name="EMAIL" type="string" size="20"/>
    </dh><%
    java.io.FileInputStream is = new java.io.FileInputStream(pageContext.getServletContext().getRealPath("gauce40/detail.dat"));
    String[][] values = com.gauce.common.CommonUtil.loadCSV(is);
    String DEPTCD = request.getParameter("DEPTCD");
    for (int i = 0; i < values.length; i++) {
      if (values[i][0].equals(DEPTCD)) {%>
    <dr>
      <dd><%= values[i][0]%></dd>
      <dd><%= values[i][1]%></dd>
      <dd><%= values[i][2]%></dd> 
      <dd><%= values[i][3]%></dd>
      <dd><%= values[i][4]%></dd>
      <dd><%= values[i][5]%></dd>
    </dr><%} } is.close();%>
  </dataset>
  <message>성공입니다...</message>
  <!--exception code="7500" type="internal">오류 메시지</exception-->
</gdml>
