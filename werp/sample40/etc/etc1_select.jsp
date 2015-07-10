<%@ page import="java.io.*,com.gauce.common.*" contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ include file ="../common/randomGenerate.jsp"%>
<gdml>
  <dataset name="GAUCE">
    <dh>        
      <def name="Partno" type="string"    size="16"/>
      <def name="Partnm" type="string"    size="40"/>
      <def name="Month" type="string"   size="6"/>
      <def name="Qty" type="decimal"    size="10"/>
      <def name="Amt" type="decimal"    size="10"/>
    </dh><c:forEach var="list" items="${EtcSelect}">
    <dr>      
      <dd><c:out value="${list.Partno}"/></dd>
      <dd><c:out value="${list.Partnm}"/></dd>
      <dd><c:out value="${list.Month}"/></dd>
      <dd><c:out value="${list.Qty}"/></dd>
      <dd><c:out value="${list.Amt}"/></dd>
    </dr></c:forEach>
  </dataset>
  <message>성공했습니다.</message>
  <!--exception code="7500" type="INTERNAL">실패했습니다.</exception-->
</gdml>
