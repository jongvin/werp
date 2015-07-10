<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">    
    SELECT DUTY_CD, DUTY_NM, CREATE_DT, DUTY_DESC FROM TB_DUTY_2
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="DUTY_CD"    type="string" size="5"/>
      <def name="DUTY_NM"    type="string" size="20"/>
      <def name="CREATE_DT"  type="string" size="8"/>
      <def name="DUTY_DESC"  type="string" size="200"/>
      <def name="COLOR"      type="string" size="10"/>
      <def name="CHECK_FL"   type="string" size="1"/>
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>
      <dd><c:out value="${rs_user.DUTY_CD}"/></dd>
      <dd><c:out value="${rs_user.DUTY_NM}"/></dd>
      <dd><c:out value="${rs_user.CREATE_DT}"/></dd>
      <dd><c:out value="${rs_user.DUTY_DESC}"/></dd>
      <dd>#E6E6FF</dd>
      <dd>F</dd>
    </dr></c:forEach>
  </dataset>
</gdml>