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
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("pre_request_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("noinput_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("request_chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
					    "         to_char(a.APPROYM,'YYYY.MM.DD') APPROYM,   " + 
					    "         a.APPROSEQ,   " + 
					    "         a.CHG_CNT,   " + 
					    "         a.APPROVAL_UNQ_NUM,   " + 
					    "         a.APPRODETAILSEQ,   " + 
					    "         a.MTRCODE,   " + 
					    "         a.NAME,   " + 
					    "         a.SSIZE,   " + 
					    "         a.UNITCODE,   " + 
					    "         a.QTY,   " + 
					    "         a.UNITPRICE,   " + 
					    "         a.AMT,   " + 
					    "         a.CONF_AMT,   " + 
					    "         a.VATAMT,   " + 
					    "         a.SPEC_NO_SEQ,   " + 
					    "         a.SPEC_UNQ_NUM,   " + 
					    "         a.REQUEST_UNQ_NUM,   " + 
					    "         a.EST_UNQ_NUM,   " + 
					    "         F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name  ," + 
					    "         b.pre_request_qty, " +
					    "         a.noinput_qty ," +
					    "         a.request_chg_cnt " +
					    "    FROM M_APPROVAL_DETAIL a,   " + 
					    "         m_request_detail b " +
					    "   WHERE a.dept_code = b.dept_code (+)" +
					    "     AND a.request_unq_num = b.request_unq_num (+) " +
					    "     AND a.request_chg_cnt = b.chg_cnt (+) " +
					    "     AND a.DEPT_CODE = '" + arg_dept_code + "'" + 
					    "     AND a.APPROYM   = '" + arg_date + "'" + 
					    "     AND a.APPROSEQ  = '" + arg_seq  + "'" + 
					    "     AND a.CHG_CNT   = "  + arg_chg_cnt + 
					    "ORDER BY a.APPRODETAILSEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>