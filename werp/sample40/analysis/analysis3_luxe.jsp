<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="company" dataSource="${GauceDB$sampledb}">
    SELECT top 100 COMPANYNAME FROM customers
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>
      <def name="COMPANYNAME" type="string" size="100"/>
    </dh><c:forEach var="rs_company" items="${company.rows}">
    <dr>
      <dd><c:out value="${rs_company.COMPANYNAME}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>