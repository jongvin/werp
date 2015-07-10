<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_process_code = req.getParameter("arg_process_code");
     arg_dept_code = arg_dept_code + '%';
     arg_process_code = arg_process_code + '%';
     String arg_mtrcode = req.getParameter("arg_mtrcode");
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
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,100));
    String query = "  select a.dept_code,a.mtrcode, a.name, a.unitcode, a.exe_qty, a.exe_amt,           			" +
    	"				a.input_qty,                                                                    " +
		"	  			a.qty_rate,                                       " +
		"	  			a.input_amt,                                                                    " +
		"	  			a.amt_rate,                               " +
		"	  			a.mod_qty,                                                           " +
		"	  			a.mod_qtyrate,                       " +
		"	  			a.mod_amt,                                                       " +
		"	  			a.mod_amtrate,            " +
		"	  			b.long_name            " +
      "  from ( select dept_code,mtrcode, name, unitcode, sum(qty) exe_qty, sum(mat_amt) exe_amt,           			" +
    	"				sum(input_qty) input_qty,                                                                    " +
		"	  			decode(sum(qty),0,0,sum(input_qty)/sum(qty))*100 qty_rate,                                       " +
		"	  			sum(input_amt) input_amt,                                                                    " +
		"	  			decode(sum(mat_amt),0,0,sum(input_amt)/sum(mat_amt))*100 amt_rate,                               " +
		"	  			sum(qty) - sum(input_qty) mod_qty,                                                           " +
		"	  			decode(sum(qty),0,0,(sum(qty) - sum(input_qty))/sum(qty))*100 mod_qtyrate,                       " +
		"	  			sum(mat_amt) - sum(input_amt) mod_amt,                                                       " +
		"	  			decode(sum(mat_amt),0,0,(sum(mat_amt) - sum(input_amt))/sum(mat_amt))*100 mod_amtrate            " +
		"		  from  (select b.dept_code,a.mtrcode, a.name, a.unitcode, sum(b.qty) qty, sum(b.mat_amt) mat_amt,             " +
		"		  					 0 input_qty, 0 input_amt                                                           " +
		"						from m_code_main_material a,                                                           " +            
		"							  y_budget_detail b                                                                 " +
		"					where substr(b.mat_code,1,6) = substr(a.mtrcode,1,6)                                        " +
		"					and length(a.mtrcode) = 6                                                                 ";
      if ( arg_dept_code.equals("%") ) query = query + "and a.mtrcode = '" + arg_mtrcode + "' ";
		query = query +     
		"					and a.mtrcode = '" + arg_mtrcode + "' " +   
		"					and b.dept_code like '" + arg_dept_code + "' " +   
		"					group by b.dept_code,a.mtrcode, a.name, a.unitcode                                                    " +
		"					union all                                                                                 " +
		"					select b.dept_code,a.mtrcode, a.name, a.unitcode, 0, 0, sum(b.qty), sum(b.amt)                        " +
		"					   from m_code_main_material a,                                                           " +
		"							  m_input_detail b                                                                  " +
		"					where substr(b.mtrcode,1,6) = substr(a.mtrcode,1,6)                                         " +
		"					and length(a.mtrcode) = 6                                                                 ";
      if ( arg_dept_code.equals("%") ) query = query + "and a.mtrcode = '" + arg_mtrcode + "' ";
		query = query +     
		"					and b.dept_code like '" + arg_dept_code + "' " +   
		"					group by b.dept_code,a.mtrcode, a.name, a.unitcode )                                                  " +
		"	   group by dept_code,mtrcode, name, unitcode                                                                   " +
		"	  UNION ALL                                                                                           " +
		"	  select dept_code,mtrcode, name, unitcode, sum(qty) exe_qty, sum(mat_amt) exe_amt, sum(input_qty) input_qty,   " +
		"	  			decode(sum(qty),0,0,sum(input_qty)/sum(qty)) qty_rate,                                       " +
		"	  			sum(input_amt) input_amt,                                                                    " +
		"	  			decode(sum(mat_amt),0,0,sum(input_amt)/sum(mat_amt)) amt_rate,                               " +
		"	  			sum(qty) - sum(input_qty) mod_qty,                                                           " +
		"	  			decode(sum(qty),0,0,(sum(qty) - sum(input_qty))/sum(qty)) mod_qtyrate,                       " +
		"	  			sum(mat_amt) - sum(input_amt) mod_amt,                                                       " +
		"	  			decode(sum(mat_amt),0,0,(sum(mat_amt) - sum(input_amt))/sum(mat_amt)) mod_amtrate            " +
		"		  from  (select b.dept_code,a.mtrcode, a.name, a.unitcode, sum(b.qty) qty, sum(b.mat_amt) mat_amt,             " +
		"		  					 0 input_qty, 0 input_amt                                                           " +
		"						from m_code_main_material a,                                                           " +            
		"							  y_budget_detail b                                                                 " +
		"					where b.mat_code    = a.mtrcode                                                             ";
      if ( arg_dept_code.equals("%") ) query = query + "and a.mtrcode = '" + arg_mtrcode + "' ";
		query = query +     
		"					and b.dept_code like '" + arg_dept_code + "' " +   
		"					group by b.dept_code,a.mtrcode, a.name, a.unitcode                                                    " +
		"					union all                                                                                 " +
		"					select b.dept_code,a.mtrcode, a.name, a.unitcode, 0, 0, sum(b.qty), sum(b.amt)                        " +
		"					   from m_code_main_material a,                                                           " +
		"							  m_input_detail b                                                                  " +
		"					where b.mtrcode = a.mtrcode                                                                 ";
      if ( arg_dept_code.equals("%") ) query = query + "and a.mtrcode = '" + arg_mtrcode + "' ";
		query = query +     
		"					and b.dept_code like '" + arg_dept_code + "' " +   
		"					group by b.dept_code,a.mtrcode, a.name, a.unitcode )                                      " +
		"	   group by dept_code,mtrcode, name, unitcode  ) a,                                " +                      		         		                     		              
		"	   z_code_dept b " + 
		"   where a.dept_code = b.dept_code " + 
		"    and  b.process_code like '" + arg_process_code + "' " + 
		"   order by b.long_name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>