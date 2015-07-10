<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE" fragment="100"> 
    <dh>
      <def name="DEPTCD" type="string" size="10"/>
      <def name="DEPTNM" type="string" size="20"/>
      <def name="EMPNUM" type="int" size="5"/>
      <def name="DESCRIPTION" type="string" size="20"/>
    </dh><%
    java.io.FileInputStream is = new java.io.FileInputStream(pageContext.getServletContext().getRealPath("gauce40/master.dat"));
    String[][] values = com.gauce.common.CommonUtil.loadCSV(is);
    for (int i = 0; i < values.length; i++) {%>
    <dr>
      <dd><%= values[i][0]%></dd>
      <dd><%= values[i][1]%></dd>
      <dd><%= values[i][2]%></dd> 
      <dd><%= values[i][3]%></dd>
    </dr><%} is.close();%>
  </dataset>
  <message>성공입니다...</message>
  <!--exception code="7500" type="internal">오류 메시지</exception-->
</gdml>