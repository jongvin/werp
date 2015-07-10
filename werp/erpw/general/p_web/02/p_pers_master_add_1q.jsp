<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,4,0));
     dSet.addDataColumn(new GauceDataColumn("add_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("add_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));
    String query = "select a.seq," + 
     "		 a.add_dept_code," + 
     "		 b.long_name add_dept_name," + 
     "		 to_char(a.start_date,'yyyy.mm.dd') start_date," + 
     "		 to_char(a.end_date  ,'yyyy.mm.dd') end_date" + 
     "  from p_order_add_dept a, " + 
     "       z_code_dept b, " + 
     "  	   (select max(a.spec_no_seq) spec_no_seq	 		" +		
	  "		     from p_order_add_dept a,						" +
	  "		  		 p_order_master   b							" +
	  "			 where a.emp_no = b.emp_no						" +
	  "		   and a.spec_no_seq = b.spec_no_seq			" +
	  "		   and a.emp_no = '" + arg_emp_no + "' 		" +			
	  "			and b.confirm_tag = '1'			) m_add		" +	
	  " where a.spec_no_seq  = m_add.spec_no_seq	 			" +
	  "   and a.add_dept_code= b.dept_code						" +	
	  "	and a.cancel_tag <> 'T'			 						" +
     "   and a.emp_no        = '" + arg_emp_no + "' 		" +
     " order by a.seq  ";     
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>