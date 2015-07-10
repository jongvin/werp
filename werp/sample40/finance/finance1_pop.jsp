<%@ page import="java.io.*,com.gauce.common.*" contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<gdml>
  <dataset name="GAUCE">
    <dh>    
      <def name="A" type="string" size="20"/>
      <def name="B" type="int" size="25"/>
      <def name="C" type="int" size="15"/>
      <def name="D" type="int" size="15"/>
      <def name="E" type="int" size="15"/>
      <def name="F" type="int" size="15"/>
      <def name="G" type="int" size="15"/>
      <def name="H" type="int" size="15"/>
      <def name="I" type="int" size="15"/>
      <def name="J" type="int" size="15"/>
      <def name="K" type="int" size="15"/>
    </dh><c:forEach var="list" items="${SelectFinance1Pop}">
    <dr>      
      <dd><c:out value="${list.A}"/></dd>
      <dd><c:out value="${list.B}"/></dd>
      <dd><c:out value="${list.C}"/></dd> 
      <dd><c:out value="${list.D}"/></dd> 
      <dd><c:out value="${list.E}"/></dd> 
      <dd><c:out value="${list.F}"/></dd>
      <dd><c:out value="${list.G}"/></dd> 
      <dd><c:out value="${list.H}"/></dd> 
      <dd><c:out value="${list.I}"/></dd> 
      <dd><c:out value="${list.J}"/></dd>
      <dd><c:out value="${list.K}"/></dd>
    </dr></c:forEach>
  </dataset>
  <message>성공했습니다.</message>
  <!--exception code="7500" type="INTERNAL">실패했습니다.</exception-->
</gdml>