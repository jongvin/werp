<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date      = req.getParameter("arg_date");
     String arg_seq       = req.getParameter("arg_seq");
     String arg_vender    = req.getParameter("arg_vender");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chgprice",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("estimatedetailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("comp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_chgamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT to_char(a.ESTIMATEYYMM,'YYYY.MM.DD') ESTIMATEYYMM,   " + 
     "         a.ESTIMATESEQ,   " + 
     "	       a.sbcr_code," + 
     "         a.EST_UNQ_NUM,  " + 
     "	       a.unitprice," + 
     "	       a.chgprice," + 
     "         b.ESTIMATEDETAILSEQ,   " + 
     "         b.MTRCODE,   " + 
     "         b.NAME,   " + 
     "         b.SSIZE,   " + 
     "         b.UNITCODE,   " + 
     "         trunc(a.unitprice * b.qty,0)  comp_amt,   " + 
     "         trunc(a.chgprice * b.qty,0)  comp_chgamt,   " + 
     "         b.QTY,   " + 
     "         c.long_name " +
     "    FROM M_EST_DETAIL  b," + 
     "			m_vender_est_detail a," + 
     "         z_code_dept c " +
     "   WHERE b.dept_code = c.dept_code and " +
     "         a.estimateyymm = b.estimateyymm and" + 
     "			a.estimateseq  = b.estimateseq and" + 
     "			a.est_unq_num  = b.est_unq_num and" + 
     "         a.ESTIMATEYYMM = " + "'" + arg_date + "'" + " AND  " + 
     "         a.ESTIMATESEQ = " + arg_seq + "   and" + 
     "			a.sbcr_code = " + "'" + arg_vender + "'" +
     " ORDER BY b.name,b.ssize,b.unitcode,b.est_unq_num ASC " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>