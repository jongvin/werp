<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<sql:query var="user" dataSource="${GauceDB$sampledb}">
    <c:choose>
        <c:when test="${empty param.EMP_NO}">
            SELECT   	SEQ, 		RELATION, 			NAME, 			JUMIN_NO,
            			JOB, 		PARTNER_YN, 		BUYANG_YN,      AUDIT_ID,
            			OLDMAN_YN,  AUDIT_TM, 			JANGAE_YN, 		ADDRESS, 
            			EMP_NO,     CHILD6_YN                                    
            FROM        T_HM1100
        </c:when>
        <c:otherwise>
            SELECT   	SEQ, 		RELATION, 			NAME, 			JUMIN_NO,
            			JOB, 		PARTNER_YN, 		BUYANG_YN,      AUDIT_ID,
            			OLDMAN_YN,  AUDIT_TM, 			JANGAE_YN, 		ADDRESS, 
            			EMP_NO,     CHILD6_YN                                    
            FROM        T_HM1100                                                   
            WHERE       EMP_NO = '<c:out value="${param.EMP_NO}"/>'
        </c:otherwise>    
    </c:choose>
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="SEQ"            type="int" size="10"/>
      <def name="RELATION"       type="string" size="50"/>
      <def name="NAME"           type="string" size="50"/>
      <def name="JUMIN_NO"       type="string" size="50"/>
      <def name="JOB"            type="string" size="50"/>
      <def name="PARTNER_YN"     type="int" size="50"/>
      <def name="BUYANG_YN"      type="int" size="50"/>
      <def name="AUDIT_ID"       type="string" size="50"/>
      <def name="OLDMAN_YN"      type="int" size="50"/>
      <def name="AUDIT_TM"       type="string" size="50"/>
      <def name="JANGAE_YN"      type="int" size="50"/>
      <def name="ADDRESS"        type="string" size="50"/>
      <def name="EMP_NO"         type="string" size="50"/>
      <def name="CHILD6_YN"      type="int" size="50"/>                                          
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>         
      <dd><c:out value="${rs_user.SEQ}"/></dd>
      <dd><c:out value="${rs_user.RELATION}"/></dd>
      <dd><c:out value="${rs_user.NAME}"/></dd>
      <dd><c:out value="${rs_user.JUMIN_NO}"/></dd>
      <dd><c:out value="${rs_user.JOB}"/></dd>
      <dd><c:out value="${rs_user.PARTNER_YN}"/></dd>
      <dd><c:out value="${rs_user.BUYANG_YN}"/></dd>
      <dd><c:out value="${rs_user.AUDIT_ID}"/></dd>      
      <dd><c:out value="${rs_user.OLDMAN_YN}"/></dd>
      <dd><c:out value="${rs_user.AUDIT_TM}"/></dd>
      <dd><c:out value="${rs_user.JANGAE_YN}"/></dd>
      <dd><c:out value="${rs_user.ADDRESS}"/></dd>
      <dd><c:out value="${rs_user.EMP_NO}"/></dd>
      <dd><c:out value="${rs_user.CHILD6_YN}"/></dd>
    </dr></c:forEach>
  </dataset>     
</gdml>
