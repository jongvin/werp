<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_QUALITY_SECTION = req.getParameter("arg_QUALITY_SECTION");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("DEPT_NAME",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("SEQ",GauceDataColumn.TB_NUMBER,18));
	  dSet.addDataColumn(new GauceDataColumn("SCHEDULE_START_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("SCHEDULE_END_DT",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("RESULT_START_DT",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("RESULT_END_DT",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("REMARK",GauceDataColumn.TB_STRING,100));
	  dSet.addDataColumn(new GauceDataColumn("CHK",GauceDataColumn.TB_STRING,1));


    String query = " select  to_char(YEAR,'yyyy') year, " +
						"  QUARTER_YEAR , " +
						"  DEPT_CODE , " ;

	if ( Integer.parseInt(arg_QUALITY_SECTION) < 3 ) 
   {
		query += "( select long_name from z_code_dept where dept_code = v_ins_plan.dept_code ) dept_name , " ;
	}
	else if ( Integer.parseInt(arg_QUALITY_SECTION) == 3) 
	{
		query += "( select distinct part_name from v_inter_audit_result_master " +
					" where year = v_ins_plan.YEAR and " +
					" half_year = v_ins_plan.QUARTER_YEAR and " + 
					"  part_code = v_ins_plan.dept_code " + 
					" ) dept_name , " ;
	}
		query += 	"  QUALITY_SECTION , " +
						"  SEQ , " +
						"  to_char(SCHEDULE_START_DT,'yyyy.mm.dd') SCHEDULE_START_DT  , " +
 						"  to_char(SCHEDULE_END_DT,'yyyy.mm.dd') SCHEDULE_END_DT , " +
						"  to_char(RESULT_START_DT,'yyyy.mm.dd') RESULT_START_DT  , " +
						"  to_char(RESULT_END_DT,'yyyy.mm.dd') RESULT_END_DT  , " +     
						"  REMARK , " + 
						"  '1' CHK " +
						"from v_ins_plan " +
						"WHERE  to_char(YEAR,'yyyy') = '" + arg_year + "'" +
						"  and QUARTER_YEAR = '"+ arg_quarter_year  +"'" +
						"  and QUALITY_SECTION = '"+ arg_QUALITY_SECTION + "'" +
						"ORDER BY SCHEDULE_START_DT ASC " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>