<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
	  dSet.addDataColumn(new GauceDataColumn("req_useq",GauceDataColumn.TB_STRING,25));
	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("req_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("req_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("req_phone",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("req_desc",GauceDataColumn.TB_STRING,200));
	  dSet.addDataColumn(new GauceDataColumn("code_wbs",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("code_wbs_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("plan_visit_date",GauceDataColumn.TB_STRING,16));
	  dSet.addDataColumn(new GauceDataColumn("plan_proc_method",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_useq",GauceDataColumn.TB_STRING,25));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_useq_as",GauceDataColumn.TB_STRING,25));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_chrg_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_chrg_phone",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("res_comp_date",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("res_desc",GauceDataColumn.TB_STRING,200));
	  dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));

    String query =" select a.req_useq, " +
      "                    a.dept_code, " +
      "                    (select long_name from z_code_dept where dept_code=a.dept_code) long_name, " +
		"                    a.dong, " +
		"	                  a.ho, " +
		"	 						(a.dong||'동'||a.ho||'호') dongho, " +
		"	 						a.floor, " +
		"	 						a.req_date, " +
		"	 						a.req_name, " +
		"	 						a.req_phone, " +
		"	 						a.req_desc, " +
		"	 						a.code_wbs, " +
		"                    (select name from a_as_comm_code where code=a.code_wbs and class='2') code_wbs_name, " +
		"	 						a.plan_visit_date, " +
		"	 						a.plan_proc_method, " +
		"	 						a.sbcr_useq, " +
		"	 						a.sbcr_useq_as, " +
//		"	 						decode(a.plan_proc_method, '1', (select sbcr_name from s_sbcr where sbcr_code=a.sbcr_useq), " +
//		"                                               '2', (select sbcr_name from s_sbcr where sbcr_code=a.sbcr_useq_as)) sbcr_name, " +
		"     					(select sbcr_name from s_sbcr where sbcr_code= decode(a.sbcr_useq,null,a.sbcr_useq_as , sbcr_useq)) sbcr_name, " +
		"	 						a.sbcr_chrg_name, " +
		"	 						a.sbcr_chrg_phone, " +
		"	 						a.res_comp_date, " +
		"	 						a.res_desc, " +
		"	 						a.remark " +
  		"					 from a_as_req_master a	" +	
		"	            WHERE  " ;

		if ( arg_dept_code.equals("@"))
		{
		}
		else
		{
		query +="                a.dept_code = '"+arg_dept_code+"' and " ;
		}

		
		query += "                    a.prog_st = '2' " +
		"           order by a.dept_code, a.dong, a.ho	" ;
	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>