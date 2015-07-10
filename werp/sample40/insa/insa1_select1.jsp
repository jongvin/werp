<%@ page contentType="text/gdml; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jstl/sql" %>
<%  
    String tmp = new String(request.getParameter("SEARCH_NM").getBytes("8859_1"), "ksc5601");
    request.setAttribute("param_SEARCH_NM", tmp);
%>
<sql:query var="user" dataSource="${GauceDB$sampledb}">
    <c:choose>
        <c:when test="${empty param.SEARCH_NM}">
                     SELECT   ARMY_TYPE, BEF_EMP, KOR_NM, BRANCHE_GB, GRADE_CD, ENG_NM, ARMS_GB, HANJA_NM,   
                      JUMIN_NO, BIRTH_DT, ACC_CD, DEPT_CD, JIKGUP_CD, JIKCHK_CD, ACCEPT_GB, TRAIN_ST_DT, TRAIN_ED_DT,
                      LAST_SCHOOL, LEVEL_GB, PRO_GB, IN_DT, OUT_STD_DT, OUT_DT, BON_ADDRESS, BORN_AREA_GB, CUR_ZIP_NO,
                      CUR_ADDRESS, PHONE_NO, H_PHONE_NO, IN_PHONE_NO, MAIL_ADDRESS, PASS_NO, PASS_VALID_DT, 
                      FOREIGN_YN, PARTNER, BUYANG_CNT, BANK_OWN1, 	BANK_CD1, BANK_RECV1, BANK_AMT1, JANGAE_CNT, 
                      OLDMAN_CNT, BANK_CD2, BANK_ACCNO1, BANK_ACCNO2, HEIGHT, BANK_OWN2, WEIGHT, BANK_RECV2, BANK_AMT2,
                      BANK_SEQNO, E_INSURE_YN, BLOOD_TYPE, CHILD6_CNT, PENSION_YN, WOMANHD_YN, ETCMAN1_CNT, PENSION_CD,
                      ETCMAN2_CNT, 	AUDIT_ID,  H_INSURE_CD, AUDIT_TM, H_INSURE_YN, H_INSURE_NO, PROMOT_DT, COMP_GB, ORDER_CD,
                      ORDER_DT, LAYOFF_YN, LAYOFF_DT, PHOTO_URL, SERVE_STATUS, ETC_CD2, ADDJOB_DEPTCD, ADDJOB_DT, STAFF_GB, 
                      ETC_CD1, ADDJOB_JIKCHK, ETC_CD3, ADDJOB_YN, SEX_GB, EMP_NO 
              FROM    T_HM1000         
        </c:when>
        <c:otherwise>
                     SELECT   ARMY_TYPE, BEF_EMP, KOR_NM, BRANCHE_GB, GRADE_CD, ENG_NM, ARMS_GB, HANJA_NM,   
                      JUMIN_NO, BIRTH_DT, ACC_CD, DEPT_CD, JIKGUP_CD, JIKCHK_CD, ACCEPT_GB, TRAIN_ST_DT, TRAIN_ED_DT,
                      LAST_SCHOOL, LEVEL_GB, PRO_GB, IN_DT, OUT_STD_DT, OUT_DT, BON_ADDRESS, BORN_AREA_GB, CUR_ZIP_NO,
                      CUR_ADDRESS, PHONE_NO, H_PHONE_NO, IN_PHONE_NO, MAIL_ADDRESS, PASS_NO, PASS_VALID_DT, 
                      FOREIGN_YN, PARTNER, BUYANG_CNT, BANK_OWN1, 	BANK_CD1, BANK_RECV1, BANK_AMT1, JANGAE_CNT, 
                      OLDMAN_CNT, BANK_CD2, BANK_ACCNO1, BANK_ACCNO2, HEIGHT, BANK_OWN2, WEIGHT, BANK_RECV2, BANK_AMT2,
                      BANK_SEQNO, E_INSURE_YN, BLOOD_TYPE, CHILD6_CNT, PENSION_YN, WOMANHD_YN, ETCMAN1_CNT, PENSION_CD,
                      ETCMAN2_CNT, 	AUDIT_ID,  H_INSURE_CD, AUDIT_TM, H_INSURE_YN, H_INSURE_NO, PROMOT_DT, COMP_GB, ORDER_CD,
                      ORDER_DT, LAYOFF_YN, LAYOFF_DT, PHOTO_URL, SERVE_STATUS, ETC_CD2, ADDJOB_DEPTCD, ADDJOB_DT, STAFF_GB, 
                      ETC_CD1, ADDJOB_JIKCHK, ETC_CD3, ADDJOB_YN, SEX_GB, EMP_NO 
              FROM    T_HM1000 
              WHERE   KOR_NM like '%<c:out value="${param_SEARCH_NM}"/>%'
        </c:otherwise>    
    </c:choose>
</sql:query>
<gdml>
  <dataset name="tbds_list">
    <dh>    
      <def name="ARMY_TYPE"            type="string" size="50"/>
      <def name="BEF_EMP"              type="string" size="50"/>
      <def name="KOR_NM"               type="string" size="50"/>
      <def name="BRANCHE_GB"           type="string" size="50"/>
      <def name="GRADE_CD"             type="string" size="50"/>
      <def name="ENG_NM"               type="string" size="50"/>
      <def name="ARMS_GB"              type="string" size="50"/>
      <def name="HANJA_NM"             type="string" size="50"/>
      <def name="JUMIN_NO"             type="string" size="50"/>
      <def name="BIRTH_DT"             type="string" size="50"/>
      <def name="ACC_CD"               type="string" size="50"/>
      <def name="DEPT_CD"              type="string" size="50"/>
      <def name="JIKGUP_CD"            type="string" size="50"/>
      <def name="JIKCHK_CD"            type="string" size="50"/>
      <def name="ACCEPT_GB"            type="string" size="50"/>
      <def name="TRAIN_ST_DT"          type="string" size="50"/>
      <def name="TRAIN_ED_DT"          type="string" size="50"/>
      <def name="LAST_SCHOOL"          type="string" size="50"/>
      <def name="LEVEL_GB"             type="string" size="50"/>
      <def name="PRO_GB"               type="string" size="50"/>
      <def name="IN_DT"                type="string" size="50"/>
      <def name="OUT_STD_DT"           type="string" size="50"/>
      <def name="OUT_DT"               type="string" size="50"/>
      <def name="BON_ADDRESS"          type="string" size="50"/>
      <def name="BORN_AREA_GB"         type="string" size="50"/>
      <def name="CUR_ZIP_NO"           type="string" size="50"/>
      <def name="CUR_ADDRESS"          type="string" size="50"/>
      <def name="PHONE_NO"             type="string" size="50"/>
      <def name="H_PHONE_NO"           type="string" size="50"/>
      <def name="IN_PHONE_NO"          type="string" size="50"/>
      <def name="MAIL_ADDRESS"         type="string" size="50"/>
      <def name="PASS_NO"              type="string" size="50"/>
      <def name="PASS_VALID_DT"        type="string" size="50"/>
      <def name="FOREIGN_YN"           type="string" size="50"/>
      <def name="PARTNER"              type="string" size="50"/>
      <def name="BUYANG_CNT"           type="string" size="50"/>
      <def name="BANK_OWN1"            type="string" size="50"/>
      <def name="BANK_CD1"             type="string" size="50"/>
      <def name="BANK_RECV1"           type="string" size="50"/>
      <def name="BANK_AMT1"            type="string" size="50"/>
      <def name="JANGAE_CNT"           type="string" size="50"/>
      <def name="OLDMAN_CNT"           type="string" size="50"/>
      <def name="BANK_CD2"             type="string" size="50"/>
      <def name="BANK_ACCNO1"          type="string" size="50"/>
      <def name="BANK_ACCNO2"          type="string" size="50"/>
      <def name="HEIGHT"               type="string" size="50"/>
      <def name="BANK_OWN2"            type="string" size="50"/>
      <def name="WEIGHT"               type="string" size="50"/>
      <def name="BANK_RECV2"           type="string" size="50"/>
      <def name="BANK_AMT2"            type="string" size="50"/>
      <def name="BANK_SEQNO"           type="string" size="50"/>
      <def name="E_INSURE_YN"          type="string" size="50"/>
      <def name="BLOOD_TYPE"           type="string" size="50"/>
      <def name="CHILD6_CNT"           type="string" size="50"/>
      <def name="PENSION_YN"           type="string" size="50"/>
      <def name="WOMANHD_YN"           type="string" size="50"/>
      <def name="ETCMAN1_CNT"          type="string" size="50"/>
      <def name="PENSION_CD"           type="string" size="50"/>
      <def name="ETCMAN2_CNT"          type="string" size="50"/>
      <def name="AUDIT_ID"             type="string" size="50"/>
      <def name="H_INSURE_CD"          type="string" size="50"/>
      <def name="AUDIT_TM"             type="string" size="50"/>
      <def name="H_INSURE_YN"          type="string" size="50"/>
      <def name="H_INSURE_NO"          type="string" size="50"/>
      <def name="PROMOT_DT"            type="string" size="50"/>
      <def name="COMP_GB"              type="string" size="50"/>
      <def name="ORDER_CD"             type="string" size="50"/>
      <def name="ORDER_DT"             type="string" size="50"/>
      <def name="LAYOFF_YN"            type="string" size="50"/>
      <def name="LAYOFF_DT"            type="string" size="50"/>
      <def name="PHOTO_URL"            type="string" size="400"/>
      <def name="SERVE_STATUS"         type="string" size="50"/>
      <def name="ETC_CD2"              type="string" size="50"/>
      <def name="ADDJOB_DEPTCD"        type="string" size="50"/>
      <def name="ADDJOB_DT"            type="string" size="50"/>
      <def name="STAFF_GB"             type="string" size="50"/>
      <def name="ETC_CD1"              type="string" size="50"/>
      <def name="ADDJOB_JIKCHK"        type="string" size="50"/>
      <def name="ETC_CD3"              type="string" size="50"/>
      <def name="ADDJOB_YN"            type="string" size="50"/>
      <def name="SEX_GB"               type="string" size="50"/>
      <def name="EMP_NO"               type="string" size="50"/>                                                
    </dh><c:forEach var="rs_user" items="${user.rows}">
    <dr>         
      <dd><c:out value="${rs_user.ARMY_TYPE}"/></dd>
      <dd><c:out value="${rs_user.BEF_EMP}"/></dd>
      <dd><c:out value="${rs_user.KOR_NM}"/></dd>
      <dd><c:out value="${rs_user.BRANCHE_GB}"/></dd>
      <dd><c:out value="${rs_user.GRADE_CD}"/></dd>
      <dd><c:out value="${rs_user.ENG_NM}"/></dd>
      <dd><c:out value="${rs_user.ARMS_GB}"/></dd>
      <dd><c:out value="${rs_user.HANJA_NM}"/></dd>
      <dd><c:out value="${rs_user.JUMIN_NO}"/></dd>
      <dd><c:out value="${rs_user.BIRTH_DT}"/></dd>
      <dd><c:out value="${rs_user.ACC_CD}"/></dd>
      <dd><c:out value="${rs_user.DEPT_CD}"/></dd>
      <dd><c:out value="${rs_user.JIKGUP_CD}"/></dd>
      <dd><c:out value="${rs_user.JIKCHK_CD}"/></dd>
      <dd><c:out value="${rs_user.ACCEPT_GB}"/></dd>
      <dd><c:out value="${rs_user.TRAIN_ST_DT}"/></dd>
      <dd><c:out value="${rs_user.TRAIN_ED_DT}"/></dd>
      <dd><c:out value="${rs_user.LAST_SCHOOL}"/></dd>
      <dd><c:out value="${rs_user.LEVEL_GB}"/></dd>
      <dd><c:out value="${rs_user.PRO_GB}"/></dd>
      <dd><c:out value="${rs_user.IN_DT}"/></dd>
      <dd><c:out value="${rs_user.OUT_STD_DT}"/></dd>
      <dd><c:out value="${rs_user.OUT_DT}"/></dd>
      <dd><c:out value="${rs_user.BON_ADDRESS}"/></dd>
      <dd><c:out value="${rs_user.BORN_AREA_GB}"/></dd>
      <dd><c:out value="${rs_user.CUR_ZIP_NO}"/></dd>
      <dd><c:out value="${rs_user.CUR_ADDRESS}"/></dd>
      <dd><c:out value="${rs_user.PHONE_NO}"/></dd>
      <dd><c:out value="${rs_user.H_PHONE_NO}"/></dd>
      <dd><c:out value="${rs_user.IN_PHONE_NO}"/></dd>
      <dd><c:out value="${rs_user.MAIL_ADDRESS}"/></dd>
      <dd><c:out value="${rs_user.PASS_NO}"/></dd>
      <dd><c:out value="${rs_user.PASS_VALID_DT}"/></dd>
      <dd><c:out value="${rs_user.FOREIGN_YN}"/></dd>
      <dd><c:out value="${rs_user.PARTNER}"/></dd>
      <dd><c:out value="${rs_user.BUYANG_CNT}"/></dd>
      <dd><c:out value="${rs_user.BANK_OWN1}"/></dd>
      <dd><c:out value="${rs_user.BANK_CD1}"/></dd>
      <dd><c:out value="${rs_user.BANK_RECV1}"/></dd>
      <dd><c:out value="${rs_user.BANK_AMT1}"/></dd>
      <dd><c:out value="${rs_user.JANGAE_CNT}"/></dd>
      <dd><c:out value="${rs_user.OLDMAN_CNT}"/></dd>
      <dd><c:out value="${rs_user.BANK_CD2}"/></dd>
      <dd><c:out value="${rs_user.BANK_ACCNO1}"/></dd>
      <dd><c:out value="${rs_user.BANK_ACCNO2}"/></dd>
      <dd><c:out value="${rs_user.HEIGHT}"/></dd>
      <dd><c:out value="${rs_user.BANK_OWN2}"/></dd>
      <dd><c:out value="${rs_user.WEIGHT}"/></dd>
      <dd><c:out value="${rs_user.BANK_RECV2}"/></dd>
      <dd><c:out value="${rs_user.BANK_AMT2}"/></dd>
      <dd><c:out value="${rs_user.BANK_SEQNO}"/></dd>
      <dd><c:out value="${rs_user.E_INSURE_YN}"/></dd>
      <dd><c:out value="${rs_user.BLOOD_TYPE}"/></dd>
      <dd><c:out value="${rs_user.CHILD6_CNT}"/></dd>
      <dd><c:out value="${rs_user.PENSION_YN}"/></dd>
      <dd><c:out value="${rs_user.WOMANHD_YN}"/></dd>
      <dd><c:out value="${rs_user.ETCMAN1_CNT}"/></dd>
      <dd><c:out value="${rs_user.PENSION_CD}"/></dd>
      <dd><c:out value="${rs_user.ETCMAN2_CNT}"/></dd>
      <dd><c:out value="${rs_user.AUDIT_ID}"/></dd>
      <dd><c:out value="${rs_user.H_INSURE_CD}"/></dd>
      <dd><c:out value="${rs_user.AUDIT_TM}"/></dd>
      <dd><c:out value="${rs_user.H_INSURE_YN}"/></dd>
      <dd><c:out value="${rs_user.H_INSURE_NO}"/></dd>
      <dd><c:out value="${rs_user.PROMOT_DT}"/></dd>
      <dd><c:out value="${rs_user.COMP_GB}"/></dd>
      <dd><c:out value="${rs_user.ORDER_CD}"/></dd>
      <dd><c:out value="${rs_user.ORDER_DT}"/></dd>
      <dd><c:out value="${rs_user.LAYOFF_YN}"/></dd>
      <dd><c:out value="${rs_user.LAYOFF_DT}"/></dd>
      <dd><c:out value="${rs_user.PHOTO_URL}"/></dd>
      <dd><c:out value="${rs_user.SERVE_STATUS}"/></dd>
      <dd><c:out value="${rs_user.ETC_CD2}"/></dd>
      <dd><c:out value="${rs_user.ADDJOB_DEPTCD}"/></dd>
      <dd><c:out value="${rs_user.ADDJOB_DT}"/></dd>
      <dd><c:out value="${rs_user.STAFF_GB}"/></dd>
      <dd><c:out value="${rs_user.ETC_CD1 }"/></dd>
      <dd><c:out value="${rs_user.ADDJOB_JIKCHK}"/></dd>
      <dd><c:out value="${rs_user.ETC_CD3}"/></dd>
      <dd><c:out value="${rs_user.ADDJOB_YN}"/></dd>
      <dd><c:out value="${rs_user.SEX_GB}"/></dd>
      <dd><c:out value="${rs_user.EMP_NO}"/></dd>                   
    </dr></c:forEach>
  </dataset>     
</gdml>