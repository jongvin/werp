<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("exe_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("qty_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("input_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("mod_qty",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("mod_qtyrate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("mod_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mod_amtrate",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  select mtrcode, name, unitcode, sum(qty) exe_qty, sum(mat_amt) exe_amt,           			" +
    	"				sum(input_qty) input_qty,                                                                    " +
		"	  			decode(sum(qty),0,0,sum(input_qty)/sum(qty))*100 qty_rate,                                       " +
		"	  			sum(input_amt) input_amt,                                                                    " +
		"	  			decode(sum(mat_amt),0,0,sum(input_amt)/sum(mat_amt))*100 amt_rate,                               " +
		"	  			sum(qty) - sum(input_qty) mod_qty,                                                           " +
		"	  			decode(sum(qty),0,0,(sum(qty) - sum(input_qty))/sum(qty))*100 mod_qtyrate,                       " +
		"	  			sum(mat_amt) - sum(input_amt) mod_amt,                                                       " +
		"	  			decode(sum(mat_amt),0,0,(sum(mat_amt) - sum(input_amt))/sum(mat_amt))*100 mod_amtrate            " +
		"		  from  (select a.mtrcode, a.name, a.unitcode, sum(b.qty) qty, sum(b.mat_amt) mat_amt,             " +
		"		  					 0 input_qty, 0 input_amt                                                           " +
		"						from m_code_main_material a,                                                           " +            
		"							  y_budget_detail b                                                                 " +
		"					where b.dept_code = '" + arg_dept_code + "'                                               " +         
		"					and substr(b.mat_code,1,6) = substr(a.mtrcode,1,6)                                        " +
		"					and length(a.mtrcode) = 6                                                                 " +
		"					group by a.mtrcode, a.name, a.unitcode                                                    " +
		"					union all                                                                                 " +
		"					select a.mtrcode, a.name, a.unitcode, 0, 0, sum(b.qty), sum(b.amt)                        " +
		"					   from m_code_main_material a,                                                           " +
		"							  m_input_detail b                                                                  " +
		"					where b.dept_code = '" + arg_dept_code + "'                                               " +         
		"					and substr(b.mtrcode,1,6) = substr(a.mtrcode,1,6)                                         " +
		"					and length(a.mtrcode) = 6                                                                 " +
		"					group by a.mtrcode, a.name, a.unitcode )                                                  " +
		"	   group by mtrcode, name, unitcode                                                                   " +
		"	  UNION ALL                                                                                           " +
		"	  select mtrcode, name, unitcode, sum(qty) exe_qty, sum(mat_amt) exe_amt, sum(input_qty) input_qty,   " +
		"	  			decode(sum(qty),0,0,sum(input_qty)/sum(qty)) qty_rate,                                       " +
		"	  			sum(input_amt) input_amt,                                                                    " +
		"	  			decode(sum(mat_amt),0,0,sum(input_amt)/sum(mat_amt)) amt_rate,                               " +
		"	  			sum(qty) - sum(input_qty) mod_qty,                                                           " +
		"	  			decode(sum(qty),0,0,(sum(qty) - sum(input_qty))/sum(qty)) mod_qtyrate,                       " +
		"	  			sum(mat_amt) - sum(input_amt) mod_amt,                                                       " +
		"	  			decode(sum(mat_amt),0,0,(sum(mat_amt) - sum(input_amt))/sum(mat_amt)) mod_amtrate            " +
		"		  from  (select a.mtrcode, a.name, a.unitcode, sum(b.qty) qty, sum(b.mat_amt) mat_amt,             " +
		"		  					 0 input_qty, 0 input_amt                                                           " +
		"						from m_code_main_material a,                                                           " +            
		"							  y_budget_detail b                                                                 " +
		"					where b.dept_code = '" + arg_dept_code + "'                                               " +         
		"					and b.mat_code    = a.mtrcode                                                             " +
		"					group by a.mtrcode, a.name, a.unitcode                                                    " +
		"					union all                                                                                 " +
		"					select a.mtrcode, a.name, a.unitcode, 0, 0, sum(b.qty), sum(b.amt)                        " +
		"					   from m_code_main_material a,                                                           " +
		"							  m_input_detail b                                                                  " +
		"					where b.dept_code = '" + arg_dept_code + "'                                               " +         
		"					and b.mtrcode = a.mtrcode                                                                 " +
		"					group by a.mtrcode, a.name, a.unitcode )                                                  " +
		"	   group by mtrcode, name, unitcode                                                                   " ;                     		         		                     		              
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>