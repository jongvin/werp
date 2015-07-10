<%@ page import="java.io.*,com.gauce.common.*" contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ include file ="../common/randomGenerate.jsp"%>
<gdml>
  <dataset name="GAUCE">
    <dh>        
      <def name="A" type="int"    size="7"/>
      <def name="B" type="string" size="15"/>
      <def name="C" type="int"    size="7"/>
      <def name="D" type="string" size="15"/>
    </dh><c:forEach var="list" items="${SelectPublic1}">
    <dr>      
      <dd><c:out value="${list.A}"/></dd>
      <dd><c:out value="${list.B}"/></dd> 
      <dd><%=getMathRandomInt(11)%></dd>
      <dd><c:out value="${list.D}"/></dd>
    </dr></c:forEach>
  </dataset>
  <message>성공했습니다.</message>
  <!--exception code="7500" type="INTERNAL">실패했습니다.</exception-->
</gdml>