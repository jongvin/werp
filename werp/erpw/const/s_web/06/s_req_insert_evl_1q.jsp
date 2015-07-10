<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
     String arg_profession_wbs_code = req.getParameter("arg_profession_wbs_code");
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("evl_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fi_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_note",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("rep_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("capital1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("property1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("debt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("capital_tot1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_amt2",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.sbcr_unq_num ," + 
     					 "          a.emp_no ," + 
     					 "          a.emp_name ," + 
     					 "          to_char(a.evl_date,'YYYY.MM.DD') evl_date ," + 
     					 "          a.const_score ," + 
     					 "          a.fi_score ," + 
     					 "          a.etc_score ," + 
     					 "          a.const_score + a.fi_score + a.etc_score  tot_score," + 
     					 "          a.evl_note ," + 
     					 "          a.remark,  " +
     					 "          b.sbcr_name, " +
     					 "          b.businessman_number , " +
     					 "          c.profession_wbs_code, " + 
     					 "          c.rep_year, " +
     					 "          b.capital1, " +
     					 "          b.property1, " +
     					 "          b.debt1, " +
     					 "          b.capital_tot1, " +
     					 "          b.sale_amt1, " +
     					 "          b.profit1, " +
     					 "          b.sale_amt2 " +
     					 "     FROM s_req_evl_summary a, " +
     					 "          s_req_sbcr b, " +
     					 "          s_req_wbs_request c " +
     					 "    WHERE a.sbcr_unq_num = b.sbcr_unq_num " +
     					 "      and a.sbcr_unq_num = c.sbcr_unq_num " +
     					 "      and a.profession_wbs_code = c.profession_wbs_code " +
     					 "      and a.SBCR_UNQ_NUM = " + arg_unq_num +
     					 "      and a.profession_wbs_code = '" + arg_profession_wbs_code + "'" +
     					 "      and a.EMP_NO = " + "'" + arg_emp_no + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>