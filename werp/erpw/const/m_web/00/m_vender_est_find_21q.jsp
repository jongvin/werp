<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//    String arg_dept_code = req.getParameter("arg_dept_code");
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("requestdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("requestseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
    String query = "     SELECT a.dept_code, " +
    					 "            c.long_name, " + 
						 "				  to_char(a.requestdate,'YYYY.MM.DD')  requestdate,   " + 
						 "				  a.requestseq,    " + 
						 "            a.chg_cnt, " +
						 "				  a.approtitle    " + 
						 "		   FROM m_request a,    " + 
						 "			  ( select max(dept_code) dept_code, max(requestseq) requestseq " + 
						 "					from m_request_detail " + 
						 "				  where nappr_qty <> 0 " + 
						 "					 and chg_cnt = 1 " + 
						 "				group by dept_code,requestseq ) b , " + 
						 "				z_code_dept c " + 
						 "		WHERE a.dept_code = c.dept_code(+) " + 
						 "		  and a.dept_code  = b.dept_code  " + 
						 "		 and a.requestseq   = b.requestseq " +  
						 "		  and a.order_class = '2'    " + 
						 "      and a.chg_cnt = 1 " +
						 "		  and a.receipdate is not null " + 
						 "	  ORDER BY a.requestdate DESC,    " + 
						 "				 a.requestseq DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>