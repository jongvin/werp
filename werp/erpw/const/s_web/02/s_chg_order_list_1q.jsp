<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("re_est_cnt",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cancel_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("open_per",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("estimate_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  a.dept_code ," + 
     					 "          a.order_number ," + 
     					 "          a.bef_order_number ," + 
     					 "          a.re_est_cnt || '차 견적' re_est_cnt," + 
     					 "          a.cancel_yn ," + 
     					 "          a.open_yn ," + 
			          "          to_char(a.open_dt,'yyyy.mm.dd hh24:mi') open_dt ," +
     					 "          a.open_per ," + 
					    "          to_char(a.estimate_dt,'yyyy.mm.dd hh24:mi') estimate_dt ," +
     					 "          b.sbcr_code ," + 
     					 "          b.ctrl_amt, " +
     					 "          c.sbcr_name " +
     					 "     FROM s_order_list a," + 
     					 "          s_estimate_list b, " +
     					 "          s_sbcr c " +
     					 "    WHERE b.sbcr_code = c.sbcr_code " +
     					 "      and a.dept_code = b.dept_code (+)" +
     					 "      and a.order_number = b.order_number (+) " +
     					 "      and a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      and a.BEF_ORDER_NUMBER = " + arg_order_number +
     					 "      and a.open_yn = 'Y' " +
     					 " order by b.sbcr_code ,a.re_est_cnt ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>