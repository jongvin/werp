<%@ page session="true"   contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT b.dept_code,   " + 
     "         b.order_number,   " + 
     "         a.sbcr_code,   " + 
     "         b.spec_no_seq,   " + 
     "         b.seq,   " + 
     "         b.direct_class,   " + 
     "         b.llevel,   " + 
     "         b.sum_code,   " + 
     "         b.name,   " + 
     "         b.exe_amt,   " + 
     "         b.cnt_amt,   " + 
     "         b.parent_sum_code,   " + 
     "         a.ctrl_amt,   " + 
     "         nvl(c.tot_amt,0) tot_amt," +
     "         c.sbcr_name   " + 
     "    FROM s_estimate_parent a,   " + 
     "         s_order_parent b,  " + 
     "         ( select a.sbcr_code sbcr_code,rownum || '-' || a.sbcr_name sbcr_name,a.ctrl_amt tot_amt " +
     "             from ( select c.sbcr_code,c.sbcr_name,b.ctrl_amt " +
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
     "   WHERE ( c.sbcr_code = a.sbcr_code ) and  " + 
     "         ( b.dept_code = a.dept_code ) and  " + 
     "         ( b.order_number = a.order_number ) and  " + 
     "         ( b.spec_no_seq = a.spec_no_seq ) and  " + 
     "         ( ( a.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( a.order_number = " + arg_order_number + " ) AND  " + 
     "         ( b.parent_sum_code = '" + arg_parent_sum_code + "' ) )   " + 
     "ORDER BY b.seq,c.sbcr_name  ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>