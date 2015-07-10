<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">    
    <c:choose>
        <c:when test="${empty param.search_fl}">
            SELECT a.dept_cd, b.dept_nm, a.duty_cd, c.duty_nm, a.deploy_dt, a.close_dt, a.close_op,a.job_desc FROM TB_JOB_2 a, TB_DEPT_2 b, TB_DUTY_2 c WHERE a.dept_cd = b.dept_cd and a.duty_Cd = c.duty_cd
        </c:when>
        <c:otherwise>
            SELECT a.dept_cd, b.dept_nm, a.duty_cd, c.duty_nm, a.deploy_dt, a.close_dt, a.close_op,a.job_desc FROM TB_JOB_2 a, TB_DEPT_2 b, TB_DUTY_2 c WHERE a.dept_cd = b.dept_cd and a.duty_Cd = c.duty_cd and a.close_op = '<c:out value="${param.search_fl}"/>'
        </c:otherwise>    
    </c:choose>
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="DEPT_CD"    type="string" size="5"/>
      <def name="DEPT_NM"    type="string" size="20"/>
      <def name="DUTY_CD"  type="string" size="5"/>
      <def name="DUTY_NM"  type="string" size="20"/>
      <def name="DEPLOY_DT"      type="string" size="8"/>
      <def name="CLOSE_DT"   type="string" size="8"/>
      <def name="CLOSE_OP"      type="string" size="1"/>
      <def name="JOB_DESC"   type="string" size="200"/>
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>
      <dd><c:out value="${rs_user.DEPT_CD}"/></dd>
      <dd><c:out value="${rs_user.DEPT_NM}"/></dd>
      <dd><c:out value="${rs_user.DUTY_CD}"/></dd>
      <dd><c:out value="${rs_user.DUTY_NM}"/></dd>
      <dd><c:out value="${rs_user.DEPLOY_DT}"/></dd>
      <dd><c:out value="${rs_user.CLOSE_DT}"/></dd>
      <dd><c:out value="${rs_user.CLOSE_OP}"/></dd>
      <dd><c:out value="${rs_user.JOB_DESC}"/></dd>
    </dr></c:forEach>
  </dataset>
</gdml>