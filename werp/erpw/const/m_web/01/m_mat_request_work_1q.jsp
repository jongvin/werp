<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_mat_code = req.getParameter("arg_mat_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("request_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("remaind_qty",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  SELECT a.SPEC_NO_SEQ,   " + 
      				 "         a.SPEC_UNQ_NUM,   " + 
      				 "         a.QTY,   " + 
      				 "         a.mat_price PRICE,   " + 
      				 "         a.mat_amt AMT  ," + 
      				 "         F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name , " +
      				 "  		  b.request_qty," + 
      				 "  		  nvl(a.qty,0) - nvl(b.request_qty,0) remaind_qty " + 
      				 "    FROM Y_BUDGET_DETAIL a ," + 
      				 "			( select max(dept_code) dept_code,max(spec_no_seq) spec_no_seq, " +
      				 "                max(spec_unq_num) spec_unq_num,nvl(sum(qty),0) request_qty" + 
      				 "				 from M_REQUEST_DETAIL " + 
      				 "				where dept_code = '" + arg_dept_code + "'" + 
      				 "			 group by dept_code,spec_no_seq,spec_unq_num ) b" + 
      				 "   WHERE a.dept_code = b.dept_code (+)" + 
      				 "	  AND a.spec_no_seq = b.spec_no_seq (+)" + 
      				 "	  AND a.spec_unq_num = b.spec_unq_num (+)" + 
      				 "	  AND a.DEPT_CODE = '" + arg_dept_code + "'" + 
      				 "     AND a.MAT_CODE = '" + arg_mat_code + "'" + 
      				 "	  AND a.mat_amt > 0     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>