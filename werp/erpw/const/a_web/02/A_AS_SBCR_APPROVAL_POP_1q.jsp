<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_name = req.getParameter("arg_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_owner",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tel_fax",GauceDataColumn.TB_STRING,30));

    String query =  "SELECT a.DEPT_CODE, " +
						"     c.LONG_NAME,     " +
						"	   a.approtitle ,   " +
						"     b.sbcr_code ,    " +
						"     d.sbcr_name,     " +
						"	   b.SBCR_OWNER,    " +
						"	   b.TEL_FAX        " + 
						"FROM M_APPROVAL a ,   " +
						"       M_APPROVAL_SBCR b  , " +
						"       z_code_dept  c ,    " +
						"	   s_sbcr d   " +
						"WHERE a.app_tag = '3' and  " +
						"      a.dept_code = b.dept_code and " +
						"      a.dept_code = c.dept_code(+) and   " + 
						"	  a.APPROYM = b.APPROYM and " +
						"	  a.APPROSEQ = b.APPROSEQ and " +
						"	  a.CHG_CNT = b.CHG_CNT  and " +    
						"	  b.sbcr_code = d.sbcr_code(+) and " +    
						"    a.dept_code = '"+arg_dept_code+"' and " +
						"    d.sbcr_name like '%"+arg_name+"%'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>