<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("part",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("problem",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("measure",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,1000));

	 String query =  " select 	to_char(a.yymm,'yyyymmdd' ) as yymm,						" +
					"	 				a.part,																" +
					"	 				a.problem,															" +
					"	 				a.measure,															" +
					"	 				a.remark																" +
					" 		 from    E_SAFTY_COST_MEASURE a											" +
					" 		where		to_char(a.yymm,'yyyymmdd' ) like '%" + arg_yymm + "%' " +	
					" 		order by a.yymm																" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>