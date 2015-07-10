<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_yyyy = req.getParameter("arg_yyyy");
      String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("completion_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("change_status",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("pre_sum",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_12",GauceDataColumn.TB_DECIMAL,18,0));

    String query =" select r.receive_tag,"   +
"        ( select z.child_name from z_code_etc_child z where z.class_tag = '011' and z.etc_code = r.receive_tag) tag_name, "   +
"        r.dept_code,"   +
"        r.const_name,"   +
" 			 r.cont_no,"   +
" 			 to_char(r.start_date,'yyyy.mm.dd') start_date,"   +
" 			 to_char(r.completion_date,'yyyy.mm.dd') completion_date,"   +
" 			 r.change_status,"   +
" 			 sum(case when to_char(cont_date,'yyyy') < '"+arg_yyyy+"'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				  end) pre_sum,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'01'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				  end) sum_01,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'02'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_02,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'03'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_03,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'04'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_04,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'05'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_05,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'06'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_06,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'07'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_07,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'08'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_08,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'09'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_09,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'10'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_10,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'11'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_11,"   +
" 			 sum(case when to_char(cont_date,'yyyymm') = '"+arg_yyyy+"'||'12'"   +
" 				       then NVL(r.change_sum_amt, 0)/"   + arg_won +
" 				 		 else 0 "   +
" 				 end) sum_12"   +
" 			 	 "   +
"   from r_contract_register r,"   +
" 	     ( select r.dept_code,"   +
" 				         r.cont_no,"   +
" 				         max(r.chg_degree) chg_degree "   +
" 				    from r_contract_register r"   +
" 					group by r.dept_code, r.cont_no"   +
" 				) mx "   +
" 	 where mx.dept_code = r.dept_code"   +
" 	   and mx.cont_no   = r.cont_no"   +
" 		  and mx.chg_degree = r.chg_degree"   +
"         and r.change_sum_amt > 0 "+
"         and to_char(r.cont_date,'yyyy') = '"+arg_yyyy +"'"+
" group by r.receive_tag,"   +
"        r.dept_code,"   +
"        r.const_name,"   +
" 			 r.cont_no,"   +
" 			 r.start_date,"   +
" 			 r.completion_date,"   +
" 			 r.change_status"   +
" order by r.receive_tag, r.dept_code, r.cont_no"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>