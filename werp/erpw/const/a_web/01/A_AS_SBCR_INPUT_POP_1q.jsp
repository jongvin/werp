<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("chrg_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_phone",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("chrg_cell",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_fax",GauceDataColumn.TB_STRING,20));

    String query = " SELECT												" +
						"	  'F' chk,											" +			
						"	  	'"+arg_dept_code+"' dept_code ,        " +
						"		b.sbcr_code,									" +
						"		b.sbcr_name ,									" +
						"		b.tel_number1 chrg_phone,					" +
						"		b.fax_number  chrg_fax,						" +
						"		b.chrg_name1 chrg_name ,					" +
						"		b.chrg_hp chrg_cell							" +
						" FROM													" +
						"		s_sbcr b											" +
						" WHERE													" +	
						"		b.SBCR_CODE =									" +	
						"( SELECT												" +
						"		a.sbcr_code										" +
						" FROM													" +	
						"		s_cn_list a,									" +
						"		s_sbcr b,										" +	
						"		s_order_list c									" +	
						" where													" +
						"		a.sbcr_code = b.sbcr_code and				" +
						"		c.dept_code = a.DEPT_CODE and				" +
						"		c.order_number = a.order_number and    " +
						"		a.dept_code ='"+arg_dept_code+"'       " +
						" minus													" +		
						" SELECT													" +
						"		a.sbcr_code										" +
						" FROM													" +	
						"		a_as_sbcr a										" +	
						" where													" +	
						"        a.sbcr_kind_tag <> '2'	and			" +
						"		a.dept_code ='"+arg_dept_code+"'   )	" ;	
	
					

	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>