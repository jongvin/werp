<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">
    SELECT TOP ? * FROM customers
<sql:param value="${param.strRowCnt}"/>
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="CUSTOMERID"   type="string" size="60"/>
      <def name="COMPANYNAME"  type="string" size="60"/>
      <def name="CONTACTNAME"  type="string" size="60"/>
      <def name="CONTACTTITLE" type="string" size="60"/>
      <def name="CITY"         type="string" size="60"/>
      <def name="REGION"       type="string" size="60"/>
      <def name="COUNTRY"      type="string" size="60"/>
      <def name="FAX"          type="string" size="60"/>
      <def name="REGION1"      type="string" size="60"/>
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>
      <dd><c:out value="${rs_user.CUSTOMERID}"/></dd>
      <dd><c:out value="${rs_user.COMPANYNAME}"/></dd>
      <dd><c:out value="${rs_user.CONTACTNAME}"/></dd>
      <dd><c:out value="${rs_user.CONTACTTITLE}"/></dd>
      <dd><c:out value="${rs_user.CITY}"/></dd>
      <dd><c:out value="${rs_user.REGION}"/></dd>
      <dd><c:out value="${rs_user.COUNTRY}"/></dd>
      <dd><c:out value="${rs_user.FAX}"/></dd>
      <dd><c:out value="${rs_user.REGION1}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>