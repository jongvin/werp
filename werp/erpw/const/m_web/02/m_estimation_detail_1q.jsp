<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date      = req.getParameter("arg_date");
     String arg_seq       = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("estimateyymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("estimateseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("estimatedetailseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("est_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.ESTIMATEYYMM,'yyyy.mm.dd') ESTIMATEYYMM,   " + 
     "         a.ESTIMATESEQ,   " + 
     "         a.ESTIMATEDETAILSEQ,   " + 
     "         a.MTRCODE,   " + 
     "         a.NAME,   " + 
     "         a.SSIZE,   " + 
     "         a.UNITCODE,   " + 
     "         a.QTY,   " + 
     "         a.SPEC_NO_SEQ,   " + 
     "         a.SPEC_UNQ_NUM,   " + 
     "         a.REQUEST_UNQ_NUM,   " + 
     "         F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num)      SPEC_NAME, " +
     "         a.EST_UNQ_NUM , " + 
     "         c.long_name ,a.chg_cnt" +
     "    FROM M_EST_DETAIL a, " + 
     "         z_code_dept c " +
     "   WHERE ( a.dept_code = c.dept_code ) and " +
     "         ( a.ESTIMATEYYMM = " + "'" + arg_date + "'" + ") AND  " + 
     "         ( a.ESTIMATESEQ = " + "'" + arg_seq + "'" + ")   " +
     "  ORDER BY a.name,a.ssize,a.unitcode,a.est_unq_num ASC " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>