<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_QUALITY_SECTION = req.getParameter("arg_QUALITY_SECTION");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_seq = req.getParameter("arg_seq");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("SEQ",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("D_SEQ",GauceDataColumn.TB_NUMBER,18));
	  dSet.addDataColumn(new GauceDataColumn("POSITION",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("POSITION_NAME",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("EMP_NO",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("NAME",GauceDataColumn.TB_STRING,20));


    String query = " select  to_char(YEAR,'yyyymmdd') year, " +
						"  QUARTER_YEAR , " +
						"  DEPT_CODE , " +
						"  QUALITY_SECTION , " +
						"  SEQ  , " +
						"  D_SEQ  , " +
 						"  POSITION , " +
 						"  decode(POSITION,1,'감사원',2,'선임감사원') POSITION_NAME , " +
						"  EMP_NO  , " +
						"  NAME   " +     
						"from v_ins_plan_person " +
						"WHERE  to_char(YEAR,'yyyy') = '" + arg_year + "'" +
						"  and QUARTER_YEAR = '"+ arg_quarter_year  +"'" +
						"  and QUALITY_SECTION ='"+ arg_QUALITY_SECTION + "'" +
						"  and DEPT_CODE = '"+ arg_dept_code +"'" +
						"  and seq = '"+ arg_seq +"'" +
						"ORDER BY d_SEQ ASC " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>