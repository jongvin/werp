<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
     String arg_profession_wbs_code = req.getParameter("arg_profession_wbs_code");
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("tot_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("old_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("detail",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT a.SBCR_UNQ_NUM,   " + 
     "                       a.profession_wbs_code, " +
     "                       a.EMP_NO,   " + 
     "                       a.CLASS,   " + 
     "                       a.SEQ,   " + 
     "                       a.NAME,   " + 
     "                       a.TOT_SCORE,   " + 
     "                       a.SPEC_SEQ,   " + 
     "                       a.SCORE,   " + 
     "                       a.SCORE old_score,   " + 
     "                       a.EVL_CLASS,   " + 
     "                       a.REMARK ,a.detail  " + 
     "                  FROM S_REQ_EVL_PARENT a " + 
     "                 WHERE a.SBCR_UNQ_NUM = " + arg_unq_num  + 
     "                   and a.profession_wbs_code = '" + arg_profession_wbs_code + "'" + 
     "                   and a.EMP_NO = '" + arg_emp_no + "'" + 
     "              ORDER BY a.CLASS ASC,   " + 
     "                       a.SEQ ASC   " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>