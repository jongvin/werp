<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">    
    SELECT DEPT_CD, DEPT_NM  FROM TB_DEPT_2
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="DEPT_CD"       type="string" size="5"/>
      <def name="DEPT_NM"       type="string" size="20"/>
      <def name="COLOR"         type="string" size="10"/>
      <def name="CHECK_FL"      type="string" size="1"/>
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>
      <dd><c:out value="${rs_user.DEPT_CD}"/></dd>
      <dd><c:out value="${rs_user.DEPT_NM}"/></dd>
      <dd>#E6E6FF</dd>
      <dd>F</dd>
    </dr></c:forEach>
  </dataset>
</gdml>