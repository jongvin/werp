<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("PROFESSION_WBS_CODE",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("SBCR_CODE",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("SBC_NAME",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("SBCR_NAME",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("START_DATE",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("END_DATE",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approve_class_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));

	 String query = " select												" +			 
					"	  a.dept_code,										" +
					"	  a.ORDER_NUMBER,									" +
					"	  to_char(a.yymm , 'yyyymm' ) yymm,					" +	
					"	  to_char(a.yymm , 'yyyymmdd' ) yymmdd,				" +
					"	  a.PROFESSION_WBS_CODE,							" +
					"	  a.SBCR_CODE,										" +
					"	  a.SBC_NAME,										" +
					"	  a.SBCR_NAME,										" +	
					"	  a.START_DATE,										" +
					"	  a.END_DATE,										" +
					"	  a.approve_class ,									" +	 	
					"	  decode( a.approve_class,'3','�򰡿Ϸ�',				" + 
					"	  a.approve_class ) approve_class_chk  ,			" +
					"	  a.remark											" + 	
					" from													" + 			 	
					"	  e_comp_opinion a							 		" + 
					" where													" + 		 
					"	  a.dept_code = '"+arg_dept_code+"' and				" +
					"    to_char(a.yymm,'yyyymm') like '%"+arg_yymm+"%'		" +
					" order by												" + 			 
					"    a.yymm desc										" ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>