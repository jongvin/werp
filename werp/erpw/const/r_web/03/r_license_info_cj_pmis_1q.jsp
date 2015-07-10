<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_check = req.getParameter("arg_check");
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("company",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("hname",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("dept",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("deptnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("stsgbn",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("coentdt",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("retdt",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_cd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_cdnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_grd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_grdnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ymdfr",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ymdto",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("pay_yn",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("licorg",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("logymd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("logno",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("std_yn",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("wrkymd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("wrkemp",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("pre_person",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,50));
     
    String query ="  select a.company, a.empno, 		/*사원번호*/"   +
" 	         b.hname, 		/*한글성명*/"   +
" 			 b.dept,	 		/*부서코드*/"   +
" 			 b.deptnm,		/*부서명*/"   +
" 			 b.stsgbn, 		/*재직구분*/"   +
" 			 b.coentdt, 		/*당사입사일*/"   +
"         b.retdt,           /*당사퇴사일*/"   +
" 			 a.lic_cd,		/*자격증코드*/"   +
" 			 a.lic_cdnm,	/*자격증명*/"   +
" 			 a.lic_grd,     /*자격증등급코	드*/"   +
" 			 a.lic_grdnm,	/*자격증등급명*/"   +
" 			 a.ymdfr,		/*취득일자*/"   +
" 			 a.ymdto,		/*만료일자*/"   +
" 			 decode(a.pay_yn,'Y','T','F') pay_yn,		/*수당지급여부*/"   +
" 			 a.licorg,		/*발행처*/"   +
" 			 a.logymd,		/*등록일자*/"   +
" 			 a.logno,		/*등록번호*/"   +
" 			 a.std_yn,		/*적용여부*/"   +
" 			 a.remark,		/*비고*/"   +
" 			 a.wrkymd,		/*시스템등록일자*/"   +
" 			 a.wrkemp, 		/*시스템등록사원*/"   +
"         c.pre_person, " +
"         c.remark remark1 " +
" 	from PLIC001VV@CJHRM a,"   +
" 		     PMAS001VV@CJHRM b,"   +
"          R_LICENSE_INFO_CJ_DETAIL c " +
"  where A.company = B.company(+)"   +
"     and A.empno   = B.empno(+)" +
"     and A.company = c.company " +
"     and A.empno = c.empno " +
"     and A.lic_cd = c.lic_cd " +
"     and A.lic_grd = c.lic_grd " +
"		and B.stsgbn like '%" + arg_check + "%' " +
"ORDER BY A.EMPNO";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>