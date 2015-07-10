<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("est_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("est_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("est_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ctrl_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("emat_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("emat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("elab_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("elab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("eexp_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("eexp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cmat_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cmat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("clab_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("clab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cexp_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cexp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_ctrl_price",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_ctrl_amt",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_cmat_price",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_cmat_amt",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_clab_price",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_clab_amt",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_cexp_price",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_cexp_amt",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  a.dept_code ," + 
     					 "          a.order_number ," + 
     					 "          a.sbcr_code ," + 
     					 "          a.spec_no_seq ," + 
     					 "          a.detail_unq_num ," + 
     					 "          a.est_qty ," + 
     					 "          a.est_price ," + 
     					 "          a.est_amt ," + 
     					 "          a.ctrl_qty ," + 
     					 "          a.ctrl_price ," + 
     					 "          a.ctrl_amt ," + 
     					 "          a.emat_price ," + 
     					 "          a.emat_amt ," + 
     					 "          a.elab_price ," + 
     					 "          a.elab_amt ," + 
     					 "          a.eexp_price ," + 
     					 "          a.eexp_amt ," + 
     					 "          a.cmat_price ," + 
     					 "          a.cmat_amt ," + 
     					 "          a.clab_price ," + 
     					 "          a.clab_amt ," + 
     					 "          a.cexp_price ," + 
     					 "          a.cexp_amt ," + 
     					 "          b.ctrl_price  b_ctrl_price ," + 
     					 "          b.ctrl_amt    b_ctrl_amt ," + 
     					 "          b.cmat_price  b_cmat_price ," + 
     					 "          b.cmat_amt    b_cmat_amt ," + 
     					 "          b.clab_price  b_clab_price ," + 
     					 "          b.clab_amt    b_clab_amt ," + 
     					 "          b.cexp_price  b_cexp_price ," + 
     					 "          b.cexp_amt    b_cexp_amt  " +
     					 "     FROM s_estimate_detail a," + 
     					 "          s_estimate_detail_web b " +
     					 "    WHERE a.dept_code = b.dept_code " +
     					 "      and a.order_number = b.order_number " +
     					 "      and a.sbcr_code = b.sbcr_code " +
     					 "      and a.spec_no_seq = b.spec_no_seq " +
     					 "      and a.detail_unq_num = b.detail_unq_num " +
     					 "      and a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      And a.ORDER_NUMBER = " + arg_order_number +
     					 "      And a.SBCR_CODE = '" + arg_sbcr_code + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>