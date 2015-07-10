<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_dept_code = req.getParameter("arg_dept_code");
      String arg_proc_code = req.getParameter("arg_proc_code");
      String arg_prog_st = req.getParameter("arg_prog_st");

 //---------------------------------------------------------- 
	  dSet.addDataColumn(new GauceDataColumn("REQ_USEQ",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("PROC_CODE",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("LOC_USEQ",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("DONGHO",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("DONG",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("HO",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("FLOOR",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("PROG_ST",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("PROG_ST_CHK",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("REQ_DATE",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("REQ_NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("REQ_PHONE",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("REQ_DESC",GauceDataColumn.TB_STRING,200));
	  dSet.addDataColumn(new GauceDataColumn("IDX_CODE_POS",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("CODE_POS",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("IDX_CODE_WBS",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("CODE_WBS",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("IDX_CODE_CAT",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("CODE_CAT",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("IDX_CODE_CAU",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("CODE_CAU",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("PROC_STATUS",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("PLAN_VISIT_DATE",GauceDataColumn.TB_STRING,14));
	  dSet.addDataColumn(new GauceDataColumn("PLAN_PROC_CAT",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("PLAN_PROC_DATE",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("PLAN_PROC_METHOD",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("SBCR_USEQ",GauceDataColumn.TB_STRING,25));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("CONTRACT_NAME",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("SBCR_USEQ_AS",GauceDataColumn.TB_STRING,25));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_name_as",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("SBCR_CHRG_NAME",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("SBCR_CHRG_PHONE",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("RES_COMP_DATE",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("RES_INSU_YN",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("RES_DESC",GauceDataColumn.TB_STRING,200));
	  dSet.addDataColumn(new GauceDataColumn("RES_COST",GauceDataColumn.TB_STRING,13));
	  dSet.addDataColumn(new GauceDataColumn("RES_COST_VAT",GauceDataColumn.TB_STRING,13));
	  dSet.addDataColumn(new GauceDataColumn("INSERT_DATE",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("UPDATE_DATE",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("INSERT_USER",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("UPDATE_USER",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("ATTRIB1",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("ATTRIB2",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("REMARK",GauceDataColumn.TB_STRING,100));
	  dSet.addDataColumn(new GauceDataColumn("wbs_name",GauceDataColumn.TB_STRING,100));

    String query =" SELECT																							" +
						"		REQ_USEQ   ,																			" +
						"		PROC_CODE  ,																			" +
						"		DEPT_CODE  ,																			" +       
						"		LOC_USEQ   ,																			" +       
						"		(DONG||'-'||HO) DONGHO   ,	 														" +    
						"		DONG       ,																			" +       
						"		HO         ,																			" +
						"		FLOOR      ,																			" +       
						"     prog_st    ,																			" +
						"     prog_st  prog_st_chk  ,																" +
						"		to_char(REQ_DATE,'yyyymmdd') REQ_DATE ,										" +       
						"		REQ_NAME   ,																			" +       
						"		REQ_PHONE  ,																			" +       
						"		REQ_DESC   , 																			" +      
						"		decode(CODE_POS,null,0,to_number(substr(CODE_POS,2,3))) IDX_CODE_POS," + 
						"		CODE_POS   ,																			" +       
						"		decode(CODE_WBS,null,0,to_number(substr(CODE_WBS,2,3))) IDX_CODE_WBS," + 
						"		CODE_WBS   , 																			" +      
						"		decode(CODE_CAT,null,0,to_number(substr(CODE_CAT,2,3))) IDX_CODE_CAT," + 
						"		CODE_CAT   , 																			" +      
						"		decode(CODE_CAU,null,0,to_number(substr(CODE_CAU,2,3))) IDX_CODE_CAU," + 
						"		CODE_CAU   , 																			" +      
 						"		PROC_STATUS    , 																		" +  
 						"		to_char(PLAN_VISIT_DATE,'yyyymmddhh24mi') PLAN_VISIT_DATE ,				" +
 						"		PLAN_PROC_CAT    ,																	" + 
 						"		to_char(PLAN_PROC_DATE,'yyyymmdd') PLAN_PROC_DATE  ,						" +
 						"		PLAN_PROC_METHOD ,																	" + 
 						"		SBCR_USEQ   ,																			" + 
 						"		(select sbcr_name from s_sbcr														" +
 						"		where sbcr_code = a.sbcr_useq) sbcr_name ,									" +
						"     CONTRACT_NAME ,																		" +
 						"		SBCR_USEQ_AS     ,																	" +
 						"		(select sbcr_name from s_sbcr														" +
 						"		where sbcr_code = a.sbcr_useq_as) sbcr_name_as ,							" +
						"		SBCR_CHRG_NAME   ,																	" + 
 						"		SBCR_CHRG_PHONE  ,																	" + 
 						"		to_char(RES_COMP_DATE,'yyyymmdd') RES_COMP_DATE  ,							" + 
 						"		RES_INSU_YN      , 																	" + 
 						"		RES_DESC        , 																	" + 
 						"		RES_COST        , 																	" +  
 						"		RES_COST_VAT    ,										 								" +  
 						"		to_char(INSERT_DATE,'yyyymmdd') INSERT_DATE  , 								" +  
  						"		to_char(UPDATE_DATE,'yyyymmdd') UPDATE_DATE  , 								" +  
						"		INSERT_USER     , 																	" +  
						"	   UPDATE_USER     , 									 								" + 
						"		ATTRIB1         , 																	" +
						"		ATTRIB2         , 																	" +
						"		REMARK			 ,																		" +
						"		( select name from a_as_comm_code where class = '2' and  code= a.CODE_WBS) wbs_name			" +
						"	FROM																							" +
						"		a_as_req_master a																		" +	
						"	WHERE																							" +		 
						"		dept_code = '"+arg_dept_code+"' and												" +
						"		proc_code like '%"+arg_proc_code+"%' and										" + 
						"     prog_st like '%"+arg_prog_st+"%'  												" +
						"  order by prog_st,  req_date															" ;
					

	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>