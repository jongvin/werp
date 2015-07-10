<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_mtrcode = req.getParameter("arg_mtrcode");
     String arg_ditag = req.getParameter("arg_ditag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("detail_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       to_char(a.YYMMDD,'YYYY.MM.DD') yymmdd,   " + 
     "                       a.MTRCODE,   " + 
     "                       a.ditag, " +
     "                       a.SEQ,   " + 
     "                       a.QTY,   " + 
     "                       a.UNITPRICE,   " + 
     "                       a.AMT,   " + 
     "                       a.SPEC_NO_SEQ,   " + 
     "                       a.SPEC_UNQ_NUM,   " + 
     "                       F_PARENT_NAME(b.dept_code,b.sum_code,b.llevel + 1) parent_name,   " + 
     "                       c.NAME detail_name" + 
     "                  FROM M_INVEST_DETAIL a,   " + 
     "                       Y_BUDGET_PARENT b,   " + 
     "                       Y_BUDGET_DETAIL c " + 
     "                 WHERE a.DEPT_CODE    = b.DEPT_CODE (+)" + 
     "                   AND a.SPEC_NO_SEQ  = b.SPEC_NO_SEQ (+)" + 
     "                   AND a.DEPT_CODE    = c.DEPT_CODE (+) " + 
     "                   AND a.SPEC_UNQ_NUM = c.SPEC_UNQ_NUM (+)" + 
     "                   AND a.SPEC_NO_SEQ  = c.SPEC_NO_SEQ (+)" + 
     "                   AND a.DEPT_CODE    = " + "'" + arg_dept_code + "'" + 
     "                   AND a.YYMMDD       = " + "'" + arg_date  + "'" + 
     "                   AND a.MTRCODE      = " + "'" + arg_mtrcode + "'" + 
     "                   AND a.ditag        = " + "'" + arg_ditag + "'" +
     "              ORDER BY a.SPEC_NO_SEQ ASC,   " + 
     "                       a.SPEC_UNQ_NUM ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>