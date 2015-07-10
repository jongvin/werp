<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_useq",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_kind_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("contract_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chrg_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_cell",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_fax",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
	  dSet.addDataColumn(new GauceDataColumn("attrib1",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("attrib2",GauceDataColumn.TB_STRING,20));

    String query =  " SELECT														" +
							"		a.sbcr_useq,										" +	
							"		a.dept_code,										" +
							"		a.sbcr_kind_tag,									" +
							"		a.sbcr_code,										" +	
							"		a.sbcr_name,										" +	
							"		a.contract_name,									" +
							"		a.chrg_name,										" +
							"		a.chrg_phone,										" +
							"		a.chrg_cell,										" +	
							"		a.chrg_fax,											" +
							"     a.remark,											" +
							"		a.attrib1,											" +
							"	   a.attrib2											" +
							" from														" +
							"		a_as_sbcr a											" +	
							" where														" +
							"		dept_code = '"+ arg_dept_code +"'			" +
							" order by													" +
							"		a.sbcr_name											" ;
					

	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>