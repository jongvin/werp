<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="list" dataSource="${GauceDB$sampledb}">    
    SELECT *  FROM TB_SALES_3
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="SALESDEPT_CD"   type="string" size="5" constraint="key"/>
      <def name="CHARGE_CD"      type="string" size="5" constraint="key"/>
      <def name="YYYY"           type="string" size="4"/>
      <def name="SALES_AMT"      type="decimal" size="15.0"/>
      <def name="SALES_CNT"      type="decimal" size="15.0" />
      <def name="PROFIT_AMT"     type="decimal" size="15.0"/>
      <def name="COST_AMT"       type="decimal" size="15.0"/>
    </dh><c:forEach var="rs_list" items="${list.rows}">
    <dr>
      <dd><c:out value="${rs_list.SALESDEPT_CD}"/></dd>
      <dd><c:out value="${rs_list.CHARGE_CD}"/></dd>
      <dd><c:out value="${rs_list.YYYY}"/></dd>
      <dd><c:out value="${rs_list.SALES_AMT}"/></dd>
      <dd><c:out value="${rs_list.SALES_CNT}"/></dd>
      <dd><c:out value="${rs_list.PROFIT_AMT}"/></dd>
      <dd><c:out value="${rs_list.COST_AMT}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>