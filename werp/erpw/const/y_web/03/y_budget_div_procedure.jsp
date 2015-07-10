<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code			= req.getParameter("arg_dept_code");
     String arg_spec_unq_num	= req.getParameter("arg_spec_unq_num");
	 String arg_qty_org				= req.getParameter("arg_qty_org");
	 String arg_qty_new				= req.getParameter("arg_qty_new");
	 String arg_cnt_qty_org		= req.getParameter("arg_cnt_qty_org");
	 String arg_cnt_qty_new		= req.getParameter("arg_cnt_qty_new");
	 String arg_no_seq_new		= req.getParameter("arg_no_seq_new");
	 String arg_empname			= req.getParameter("arg_empname");

     
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_y_budget_div(?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_spec_unq_num	  );
	  stmt.setString(3,arg_qty_org				  );
	  stmt.setString(4,arg_qty_new				  );
	  stmt.setString(5,arg_cnt_qty_org		  );
	  stmt.setString(6,arg_cnt_qty_new		  );
	  stmt.setString(7,arg_no_seq_new		  );
	  stmt.setString(8,arg_empname			  );
      
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>