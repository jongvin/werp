<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("check_method",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT max(a.DEPT_CODE) dept_code,   " + 
   					 "         max(b.REQUESTSEQ) REQUESTSEQ,   " + 
   					 "         max(c.chg_cnt) chg_cnt, " +
   					 "         max(c.APPROTITLE) APPROTITLE, " + 
   					 "         max(c.order_class) order_class, " +
   					 "         max(c.owner)  owner," +
   					 "         max(c.check_method) check_method " +
   					 "    FROM M_EST_DETAIL a,   " + 
   					 "         M_REQUEST_DETAIL b,   " + 
   					 "         M_REQUEST  c" + 
   					 "   WHERE a.DEPT_CODE = b.DEPT_CODE  and  " + 
   					 "         a.REQUEST_UNQ_NUM = b.REQUEST_UNQ_NUM  and  " + 
   					 "         a.chg_cnt = b.chg_cnt and " +
   					 "         b.DEPT_CODE = c.DEPT_CODE  and  " + 
   					 "         b.REQUESTSEQ = c.REQUESTSEQ  and  " + 
   					 "         b.CHG_CNT = c.CHG_CNT  and  " + 
   					 "         a.ESTIMATEYYMM = '" + arg_date + "' AND  " + 
   					 "         a.ESTIMATESEQ = " + arg_seq + " AND " +
		   			 "        ( a.dept_code || a.est_unq_num || a.request_unq_num  not in " +
		   			 "           ( select dept_code || est_unq_num || request_unq_num from m_approval_detail )) " +
   					 " group by c.dept_code,c.requestseq ,c.chg_cnt    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>
  
