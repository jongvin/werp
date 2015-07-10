<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<gdml>
  <dataset name="SALESDEPT" buffer="50">
    <sql:query var="dept" dataSource="${GauceDB$sampledb}">  
      SELECT SALESDEPT_CD, SALESDEPT_NM  FROM TB_SALESDEPT_3
    </sql:query>
    <dh>
      <def name="SALESDEPT_CD" type="string" size="5"/>
      <def name="SALESDEPT_NM" type="string" size="20"/>
    </dh><c:forEach var="rs_dept" items="${dept.rows}">
    <dr>
      <dd><c:out value="${rs_dept.SALESDEPT_CD}"/></dd>
      <dd><c:out value="${rs_dept.SALESDEPT_NM}"/></dd>
    </dr></c:forEach>
  </dataset>

  <dataset name="CHARGE" buffer="50">
    <sql:query var="charge" dataSource="${GauceDB$sampledb}">
      SELECT SALESDEPT_CD,CHARGE_CD, CHARGE_NM  FROM TB_CHARGE_3
    </sql:query>
    <dh>
      <def name="SALESDEPT_CD" type="string" size="5"/>
      <def name="CHARGE_CD" type="string" size="5"/>
      <def name="CHARGE_NM" type="string" size="20"/>
    </dh><c:forEach var="rs_charge" items="${charge.rows}">
    <dr>
      <dd><c:out value="${rs_charge.SALESDEPT_CD}"/></dd>
      <dd><c:out value="${rs_charge.CHARGE_CD}"/></dd>
      <dd><c:out value="${rs_charge.CHARGE_NM}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>