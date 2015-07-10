<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("license_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("license_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("gain_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ioffice",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("last_update_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("career_s_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("print_order",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("license_years",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("license_order",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tech_level",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("con_license_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_type_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("chg_year_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_next_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("license_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("allow",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("validity_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("eval_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,400));
     dSet.addDataColumn(new GauceDataColumn("repair_edu_sdate",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("repair_edu_edate",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT a.resident_no,   " + 
     "         a.spec_no_seq,   " + 
     "			a.license_code,   " + 
     "			a.license_no,   " + 
     "			to_char(a.gain_date,'yyyy.mm.dd') gain_date,     " + 
     "			a.ioffice,   " + 
     "			to_char(a.last_update_date,'yyyy.mm.dd') last_update_date ,     " + 
     "			to_char(a.career_s_date,'yyyy.mm.dd') career_s_date,      " + 
     "			a.print_order,   " + 
     "			a.license_years,   " + 
     "			a.license_order,   " + 
     "			a.tech_level,   " + 
     "			a.con_license_yn,   " + 
     "			a.license_type_code,   " + 
     "			to_char(a.chg_year_date,'yyyy.mm.dd') chg_year_date,      " + 
     "			to_char(a.chg_next_date,'yyyy.mm.dd') chg_next_date,      " + 
     "			a.license_yn,   " + 
     "			a.allow,   " + 
     "			to_char(a.validity_date,'yyyy.mm.dd') validity_date,   " + 
     "			a.eval_score,   " + 
     "			a.remark,   " + 
     "			to_char(a.repair_edu_sdate,'yyyy.mm.dd') repair_edu_sdate,   " + 
     "			to_char(a.repair_edu_edate,'yyyy.mm.dd') repair_edu_edate   " + 
     "	 FROM p_pers_license   a" + 
     "	where a.resident_no = '"  + arg_resident_no + "' " + 
     "order by a.license_code     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>