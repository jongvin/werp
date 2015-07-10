<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">
    <c:choose>
        <c:when test="${empty param.EMP_NO}">
            SELECT   	SEQ, 			IN_DT, 			OUT_DT, 		COMPANY_NM, 	
            			JIKCHK_NM, 		JOB, 			OUT_CAUSE,      CAREER_YEAR, 	
            			CAREER_MONTH,  	AUDIT_ID, 		AUDIT_TM, 		EMP_NO 			
            FROM        T_HM1200
        </c:when>
        <c:otherwise>
            SELECT   	SEQ, 			IN_DT, 			OUT_DT, 		COMPANY_NM, 	
            			JIKCHK_NM, 		JOB, 			OUT_CAUSE,      CAREER_YEAR, 	
            			CAREER_MONTH,  	AUDIT_ID, 		AUDIT_TM, 		EMP_NO 			
            FROM        T_HM1200                                       
            WHERE       EMP_NO = '<c:out value="${param.EMP_NO}"/>'
        </c:otherwise>    
    </c:choose>
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="SEQ"            type="int" size="10"/>
      <def name="IN_DT"          type="string" size="50"/>
      <def name="OUT_DT"         type="string" size="50"/>
      <def name="COMPANY_NM"     type="string" size="50"/>
      <def name="JIKCHK_NM"      type="string" size="50"/>
      <def name="JOB"            type="string" size="10"/>
      <def name="OUT_CAUSE"      type="string" size="10"/>
      <def name="CAREER_YEAR"    type="int" size="10"/>
      <def name="CAREER_MONTH"   type="int" size="10"/>
      <def name="AUDIT_ID"       type="string" size="50"/>
      <def name="AUDIT_TM"       type="string" size="50"/>
      <def name="EMP_NO"         type="string" size="50"/>                                   
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>         
      <dd><c:out value="${rs_user.SEQ}"/></dd>
      <dd><c:out value="${rs_user.IN_DT}"/></dd>
      <dd><c:out value="${rs_user.OUT_DT}"/></dd>
      <dd><c:out value="${rs_user.COMPANY_NM}"/></dd>
      <dd><c:out value="${rs_user.JIKCHK_NM}"/></dd>
      <dd><c:out value="${rs_user.JOB}"/></dd>
      <dd><c:out value="${rs_user.OUT_CAUSE}"/></dd>
      <dd><c:out value="${rs_user.CAREER_YEAR}"/></dd>      
      <dd><c:out value="${rs_user.CAREER_MONTH}"/></dd>
      <dd><c:out value="${rs_user.AUDIT_ID}"/></dd>
      <dd><c:out value="${rs_user.AUDIT_TM}"/></dd>
      <dd><c:out value="${rs_user.EMP_NO}"/></dd>
    </dr></c:forEach>
  </dataset>     
</gdml>

