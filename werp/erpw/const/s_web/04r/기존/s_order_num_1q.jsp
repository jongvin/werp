<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prgs_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("prgs_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.dept_code,   " + 
     "         to_char(a.yymm,'yyyy.mm.dd') yymm,   " + 
     "         a.seq,   " + 
     "         a.order_number, " + 
     "         a.prgs_degree," + 
     "         to_char(a.prgs_start_dt,'yyyy.mm.dd') prgs_start_dt," + 
     "         to_char(a.prgs_end_dt,'yyyy.mm.dd') prgs_end_dt," + 
     "         c.sbcr_name," + 
     "         b.sbc_name," + 
     "         d.long_name" + 
     "    FROM s_pay a, s_cn_list b, s_sbcr c, z_code_dept d " + 
     "   WHERE a.dept_code    = d.dept_code    AND " + 
     "         a.dept_code    = b.dept_code    AND" + 
     "         a.order_number = b.order_number AND" + 
     "         b.sbcr_code    = c.sbcr_code    AND" + 
     "         a.dept_code    = '" + arg_dept_code + "'  AND  " + 
     "         a.yymm         = '" + arg_yymm  + "'     AND" + 
     "         a.seq          = " + arg_seq + "  " + 
     " order by a.seq DESC,   " + 
     "          a.order_number DESC" + 
     "              ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>