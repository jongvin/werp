<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,24));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT DEPT_CODE,   " + 
     "         CHG_NO_SEQ,   " + 
     "         SPEC_NO_SEQ,   " + 
     "         NO_SEQ,   " + 
     "         SUM_CODE,   " + 
     "         PARENT_SUM_CODE,   " + 
     "         DIRECT_CLASS,   " + 
     "         WBS_CODE,   " + 
     "         LLEVEL,   " + 
     "         INVEST_CLASS,   " + 
     "         NAME,   " + 
     "         SSIZE,   " + 
     "         UNIT,   " + 
     "         CNT_AMT,   " + 
     "         CNT_MAT_AMT,   " + 
     "         CNT_LAB_AMT,   " + 
     "         CNT_EXP_AMT,   " + 
     "         AMT,   " + 
     "         MAT_AMT,   " + 
     "         LAB_AMT,   " + 
     "         EXP_AMT,   " + 
     "         EQU_AMT,   " + 
     "         SUB_AMT,   " + 
     "         REMARK,   " + 
     "         to_char(INPUT_DT,'YYYY.MM.DD') INPUT_DT,   " + 
     "         INPUT_NAME  " + 
     "    FROM T_BUDGET_PARENT  " + 
     "   WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( PARENT_SUM_CODE = " + "'" + arg_parent_sum_code + "'" + " ) AND  " + 
     "         ( CHG_NO_SEQ = 1 )   " + 
     "ORDER BY SUM_CODE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>