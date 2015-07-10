<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("org_div_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("in_out_div",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("career_div_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("retire_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("permit_year_number",GauceDataColumn.TB_DECIMAL,4,2));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("duty",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_pers_career.resident_no ," + 
     "          p_pers_career.spec_no_seq ," + 
     "          p_pers_career.seq ," + 
     "          p_pers_career.org_div_code ," + 
     "          p_pers_career.comp_name ," + 
     "          p_pers_career.in_out_div ," + 
     "          p_pers_career.career_div_code ," + 
     "          to_char(p_pers_career.join_date,'yyyy.mm.dd') join_date ," + 
     "          to_char(p_pers_career.retire_date,'yyyy.mm.dd') retire_date ," + 
     "          p_pers_career.permit_year_number ," + 
     "          p_pers_career.grade ," + 
     "          p_pers_career.duty ," + 
     "          p_pers_career.remark  " +
     "   FROM p_pers_career           " +
     "   where p_pers_career.resident_no = '" + arg_resident_no   + "'    " +
     "  ORDER BY p_pers_career.seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>