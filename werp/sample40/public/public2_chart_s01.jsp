<%@ page import="java.io.*,com.gauce.common.*" contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<c:set var="cond_year" value="${param.cond_year}" scope="page"/>
<c:set var="v_index" value="${param.index}" scope="page"/>
<c:set var="v_level" value="${param.level}" scope="page"/>
<gdml>	
  <dataset name="tbds_list">    
    <dh>    
      <def name="Yyyymm"  type="string" size="6"/>
      <def name="A1"      type="int" size="6"/>
      <def name="A2"      type="int" size="6"/>
      <def name="A3"      type="int" size="6"/>
      <def name="A4"      type="int" size="6"/>
      <def name="A5"      type="int" size="6"/>
      <def name="A6"      type="int" size="6"/>
      <def name="A7"      type="int" size="6"/>
      <def name="A8"      type="int" size="6"/>
      <def name="A9"      type="int" size="6"/>
      <def name="A10"     type="int" size="6"/>
      <def name="A11"     type="int" size="6"/>
      <def name="A12"     type="int" size="6"/>              
    </dh><c:forEach var="list" items="${Public2Chart}">
    <dr>      
      <dd><c:out value="${list.Yyyymm}"/></dd>
      <dd><c:out value="${list.A1}"/></dd> 
      <dd><c:out value="${list.A2}"/></dd> 
      <dd><c:out value="${list.A3}"/></dd>
      <dd><c:out value="${list.A4}"/></dd>
      <dd><c:out value="${list.A5}"/></dd>
      <dd><c:out value="${list.A6}"/></dd>    
      <dd><c:out value="${list.A7}"/></dd>
      <dd><c:out value="${list.A8}"/></dd> 
      <dd><c:out value="${list.A9}"/></dd> 
      <dd><c:out value="${list.A10}"/></dd>
      <dd><c:out value="${list.A11}"/></dd>
      <dd><c:out value="${list.A12}"/></dd>                            
    </dr></c:forEach>
  </dataset>
  <message>성공했습니다.</message>
</gdml>