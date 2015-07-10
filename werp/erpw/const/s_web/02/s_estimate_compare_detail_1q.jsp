<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
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
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ctrl_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.dept_code,   " + 
     "         a.order_number,   " + 
     "         a.sbcr_code,   " + 
     "         a.spec_no_seq,   " + 
     "         a.detail_unq_num,   " + 
     "         b.seq,   " + 
     "         b.name,   " + 
     "         b.unit,   " + 
     "         b.ssize,   " + 
     "         b.exe_amt,   " + 
     "         b.cnt_amt,   " +
     "         a.ctrl_qty,   " + 
     "         a.ctrl_price,   " + 
     "         a.ctrl_amt,   " + 
     "         c.sbcr_name ,  " + 
     "         nvl(c.tot_amt,0) tot_amt " +
     "    FROM s_estimate_detail a ,   " + 
     "         s_order_detail b,  " + 
     "         ( select  a.sbcr_code sbcr_code,rownum || '-' || a.sbcr_name sbcr_name ,a.ctrl_amt tot_amt" +
     "             from ( select c.sbcr_code,c.sbcr_name ,b.ctrl_amt" +
     "           				 from s_order_parent a, " +
     "                 				s_estimate_parent b, " +
	  "					 				s_sbcr   c " +
	  "		     				where b.sbcr_code = c.sbcr_code " +
	  "		     				  and a.dept_code = b.dept_code " +
	  "		     				  and a.order_number = b.order_number " +
	  "		     				  and a.spec_no_seq  = b.spec_no_seq " +
	  "		     				  and a.dept_code = '" + arg_dept_code + "'" +
	  "		     				  and a.order_number = " + arg_order_number +
	  "		     				  and a.llevel = 1 " +
	  "        				order by b.ctrl_amt asc) a ) c " +
     "   WHERE ( a.sbcr_code = c.sbcr_code ) and  " + 
     "         ( b.dept_code = a.dept_code ) and  " + 
     "         ( b.order_number = a.order_number ) and  " + 
     "         ( b.spec_no_seq = a.spec_no_seq ) and  " + 
     "         ( b.detail_unq_num = a.detail_unq_num ) and  " + 
     "         ( ( a.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( a.order_number = " + arg_order_number + " ) AND  " + 
     "         ( a.spec_no_seq = " + arg_spec_no_seq + ")   " + 
     "          )         " + 
     "     order by b.seq,c.sbcr_name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>