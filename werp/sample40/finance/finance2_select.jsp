<%@ page import="java.io.*,com.gauce.common.*" contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<c:set var="service" value="${param.dsn}" scope="page"/>
<gdml>	
  <dataset name="tbds_list">
    <c:choose>			
        <c:when test="${service eq '2dchart'}">
            <dh>    
              <def name="DD"        type="string" size="10"/>
              <def name="SILJUK"      type="int" size="10"/>
              <def name="SILJUKL"  type="int" size="10"/>
              <def name="INCRATE"    type="decimal" size="5.5"/>
            </dh>
        </c:when>			
        <c:when test="${service eq '3dchart'}">
            <dh>    
              <def name="Index" type="string" size="30"/>
              <def name="X"     type="string" size="30"/>
              <def name="Y"     type="string" size="30"/>
              <def name="Z"     type="string" size="30"/>
            </dh>
        </c:when>		
        <c:when test="${service eq 'grid1'}">
            <dh>
              <def name="Index" type="string"  size="30"/>
              <def name="X"     type="int"     size="10"/>
              <def name="Y"     type="decimal" size="5.3"/>
              <def name="Z"     type="decimal"  size="30"/>
            </dh>           
        </c:when>          
    </c:choose><c:forEach var="list" items="${SelectFinance2}">
        <c:choose>                
            <c:when test="${service eq '2dchart'}">
                <dr>
                  <dd><c:out value="${list.DD}"/></dd>
                  <dd><c:out value="${list.SILJUK}"/></dd>
                  <dd><c:out value="${list.SILJUKL}"/></dd>
                  <dd><c:out value="${list.INCRATE}"/></dd>
                </dr>
            </c:when>
            <c:when test="${service eq '3dchart'}">
                <dr>
                  <dd><c:out value="${list.Index}"/></dd>
                  <dd><c:out value="${list.X}"/></dd>
                  <dd><c:out value="${list.Y}"/></dd>
                  <dd><c:out value="${list.Z}"/></dd>
                </dr>
            </c:when>  
            <c:when test="${service eq 'grid1'}">
                <dr>
                  <dd><c:out value="${list.Index}"/></dd>
                  <dd><c:out value="${list.X}"/></dd>
                  <dd><c:out value="${list.Y}"/></dd>
                  <dd><c:out value="${list.Z}"/></dd>
                </dr>
            </c:when>                                                                                
        </c:choose>
    </c:forEach>
  </dataset>
  <message>성공했습니다.</message>
</gdml>
