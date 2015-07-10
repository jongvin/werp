<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%  
    String tmp = new String(request.getParameter("dong").getBytes("8859_1"), "ksc5601");
    request.setAttribute("param_DONG", tmp);
%>
<sql:query var="zipcode" dataSource="${GauceDB$sampledb}">    
    <c:choose>
        <c:when test="${empty param.dong}">
            SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI, SIDO||GUGUN||DONG||BUNJI ADDR FROM zipcode
        </c:when>
        <c:otherwise>
            SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI, SIDO||GUGUN||DONG||BUNJI ADDR FROM zipcode                                                
            WHERE DONG LIKE '%<c:out value="${param_DONG}"/>%'
        </c:otherwise>    
    </c:choose>
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="ZIPCODE"   type="string" size="10"/>
      <def name="SIDO"      type="string" size="60"/>
      <def name="GUGUN"     type="string" size="60"/>
      <def name="DONG"      type="string" size="60"/>
      <def name="BUNJI"     type="string" size="60"/>
      <def name="ADDR"      type="string" size="100"/>
    </dh><c:forEach var="rs_zipcode" items="${zipcode.rows}">
    <dr>
      <dd><c:out value="${rs_zipcode.ZIPCODE}"/></dd>
      <dd><c:out value="${rs_zipcode.SIDO}"/></dd>
      <dd><c:out value="${rs_zipcode.GUGUN}"/></dd>
      <dd><c:out value="${rs_zipcode.DONG}"/></dd>
      <dd><c:out value="${rs_zipcode.BUNJI}"/></dd>
      <dd><c:out value="${rs_zipcode.ADDR}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>