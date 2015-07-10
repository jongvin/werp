<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("est_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("est_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ctrl_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("emat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("emat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("elab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("elab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("eexp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("eexp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cmat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cmat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("clab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("clab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cexp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cexp_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT s_estimate_detail.dept_code,   " + 
     "         s_estimate_detail.order_number,   " + 
     "         s_estimate_detail.sbcr_code,   " + 
     "         s_estimate_detail.spec_no_seq,   " + 
     "         s_estimate_detail.detail_unq_num,   " + 
     "         s_order_detail.seq,   " + 
     "         s_order_detail.name,   " + 
     "         s_order_detail.unit,   " + 
     "         s_order_detail.ssize,   " + 
     "         s_order_detail.res_class,   " + 
     "         s_estimate_detail.est_qty,   " + 
     "         s_estimate_detail.est_price,   " + 
     "         s_estimate_detail.est_amt,   " + 
     "         s_estimate_detail.ctrl_qty,   " + 
     "         s_estimate_detail.ctrl_price,   " + 
     "         s_estimate_detail.ctrl_amt,   " + 
     "         s_estimate_detail.emat_price,   " + 
     "         s_estimate_detail.emat_amt,   " + 
     "         s_estimate_detail.elab_price,   " + 
     "         s_estimate_detail.elab_amt,   " + 
     "         s_estimate_detail.eexp_price,   " + 
     "         s_estimate_detail.eexp_amt,   " + 
     "         s_estimate_detail.cmat_price,   " + 
     "         s_estimate_detail.cmat_amt,   " + 
     "         s_estimate_detail.clab_price,   " + 
     "         s_estimate_detail.clab_amt,   " + 
     "         s_estimate_detail.cexp_price,   " + 
     "         s_estimate_detail.cexp_amt  " + 
     "    FROM s_estimate_detail,   " + 
     "         s_order_detail  " + 
     "   WHERE ( s_order_detail.dept_code = s_estimate_detail.dept_code ) and  " + 
     "         ( s_order_detail.order_number = s_estimate_detail.order_number ) and  " + 
     "         ( s_order_detail.spec_no_seq = s_estimate_detail.spec_no_seq ) and  " + 
     "         ( s_order_detail.detail_unq_num = s_estimate_detail.detail_unq_num ) and  " + 
     "         ( s_order_detail.sub_qty <> 0 ) and " +
     "         ( ( s_estimate_detail.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( s_estimate_detail.order_number = " + arg_order_number + " ) AND  " + 
     "         ( s_estimate_detail.sbcr_code = '" + arg_sbcr_code + "') AND  " + 
     "         ( s_estimate_detail.spec_no_seq = " + arg_spec_no_seq + ")   " + 
     "         )         " +
     " order by s_order_detail.seq asc";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>