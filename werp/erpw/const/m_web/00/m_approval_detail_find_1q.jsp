<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
     String arg_chg_cnt = req.getParameter("arg_chg_cnt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approval_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approdetailseq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("conf_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tmp_vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noinput_qty",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  SELECT DEPT_CODE,   " + 
     "         to_char(APPROYM,'YYYY.MM.DD')  APPROYM,  " + 
     "         APPROSEQ,   " + 
     "         CHG_CNT,   " + 
     "         APPROVAL_UNQ_NUM,   " + 
     "         APPRODETAILSEQ,   " + 
     "         MTRCODE,   " + 
     "         NAME,   " + 
     "         SSIZE,   " + 
     "         UNITCODE,   " + 
     "         QTY,   " + 
     "         UNITPRICE,   " + 
     "         AMT,   " + 
     "         CONF_AMT,   " + 
     "         VATAMT,   " + 
     "         0 tmp_vatamt, " +
     "         SPEC_NO_SEQ,   " + 
     "         SPEC_UNQ_NUM,   " + 
     "         REQUEST_UNQ_NUM,   " + 
     "         EST_UNQ_NUM,   " + 
     "         0        input_qty, " +
     "         ''           comp_chk, " +
     "         F_PARENT_DETAIL_NAME(dept_code,spec_unq_num) spec_name,  " + 
     "         NOINPUT_QTY  " + 
     "    FROM M_APPROVAL_DETAIL  " + 
     "   WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( APPROYM = " + "'" + arg_date + "'" + " ) AND  " + 
     "         ( APPROSEQ = " + "'" + arg_seq + "'" + " ) AND  " + 
     "         ( CHG_CNT = " + "'" + arg_chg_cnt + "'" + " ) AND  " + 
     "         ( NOINPUT_QTY > 0 )   " + 
     "                 ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>