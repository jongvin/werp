<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
     String arg_sbcr = '%' + req.getParameter("arg_sbcr") + '%';
     String arg_dept = '%' + req.getParameter("arg_dept") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("in_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("in_sum_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("out_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("out_sum_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("m_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("n_qty",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  select i.sbcr_code,	"	+
"									  (select sbcr_name from s_sbcr where sbcr_code = i.sbcr_code) sbcr_name, "	+    
"			 						  i.dept_code, "	+
"									  (select long_name from z_code_dept where dept_code = i.dept_code) long_name, "	+
"			 						  i.mtrcode, "	+
"			 						  i.name, "	+
"			 						  i.ssize, "	+
"			 						  i.unitcode, "	+
"			 						  sum( case when i.yymmdd >= '" + arg_from_date + "' and i.yymmdd <= '" + arg_to_date + "' "	+
"			 			  							then i.qty "	+
"													else 0 "	+
"											 end ) in_qty, "	+
"			 						  sum(i.qty) in_sum_qty, "	+
"			 						  sum( case when o.yymmdd >= '" + arg_from_date + "' and o.yymmdd <= '" + arg_to_date + "' "	+
"			 			  							then nvl(o.qty,0) "	+
"													else 0 "	+
"											 end ) out_qty, "	+
"			 						  sum(nvl(o.qty,0)) out_sum_qty, "	+
"			 						  sum( case when m.month >= '" + arg_from_date + "' and m.month <= '" + arg_to_date + "' "	+
"			 			  						  	then nvl(m.amt,0) "	+
"													else 0 "	+
"											 end ) m_amt, "	+
"			 						  sum(nvl(m.amt,0)) s_amt, "	+
"									  sum(i.qty) - sum(nvl(o.qty,0)) n_qty "	+
"			 			  											  "	+
"  						from	  (select a.dept_code, "	+
"			 									 a.sbcr_code, "	+
"			 									 a.yymmdd, "	+
"			 									 a.seq, "	+
"			 									 a.input_unq_num, "	+
"			 									 a.mtrcode, "	+
"			 									 a.name, "	+
"			 									 a.ssize, "	+
"			 									 a.unitcode, "	+
"			 									 a.qty "	+
"  									from m_input_detail a "	+
" 										where a.inouttypecode = '9' and "	+
"  		 									a.yymmdd <= '" + arg_to_date + "') i, "	+
"			 																 "	+
"									  (select a.dept_code, "	+
"			 									 a.yymmdd, "	+
"			 									 a.input_unq_num, "	+
"			 									 a.qty "	+
" 										from m_output_detail a "	+
" 										where a.inouttypecode = 'A' and "	+
"  		 									a.yymmdd <= '" + arg_to_date + "'		) o, "	+
"			 																	  "	+
"									  (select a.dept_code, "	+
"			 									 a.yymmdd, "	+
"			 									 a.seq, "	+
"			 									 a.input_unq_num, "	+
"			 									 a.month, "	+
"			 									 a.amt "	+
" 										from m_price_month a "	+
" 										where a.month <= '" + arg_to_date + "') m "	+
"  																	  "	+
" 							where i.dept_code = o.dept_code(+) and "	+
"  		 						i.input_unq_num = o.input_unq_num(+) and "	+
"			 						i.dept_code = m.dept_code(+) and "	+
"			 						i.yymmdd = m.yymmdd(+) and "	+
"			 						i.seq = m.seq(+) and "	+
"			 						i.input_unq_num = m.input_unq_num(+) and "	+ 
"									i.sbcr_code like '" + arg_sbcr + "' and "	+
"									i.dept_code like '" + arg_dept + "' "	+
" 						group by i.sbcr_code, "	+
"			 						i.dept_code, "	+
"			 						i.mtrcode, "	+
"			 						i.name, "	+
"			 						i.ssize, "	+
"			 						i.unitcode "	+
" 						order by i.sbcr_code, "	+
"			 						i.dept_code, "	+
"			 						i.mtrcode, "	+
"			 						i.name, "	+
"			 						i.ssize, "	+
"			 						i.unitcode			       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>