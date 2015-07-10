<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "   SELECT	IN_A.dept_code,                                    " + 
     "				            IN_A.CONT_NO,                                      " + 
     "	 			               A.CONST_NAME,                                   " + 
     "				            to_char(A.CONT_DATE,'yyyy.mm.dd') CONT_DATE,       " + 
     "                           A.CONST_TAG,												" + 
     "				            IN_A.CHG_DEGREE,												" + 
     "				            (nvl(SUM(A.CHANGE_SUPPLY_AMT),0) + nvl(SUM(A.exempt_amt),0)) SUPPLY_AMT,			" + 
     "				            nvl(SUM(A.CHANGE_VAT_AMT),0) VAT_AMT					" + 
     "                   FROM R_CONTRACT_REGISTER A,										" + 
     "	      	            (SELECT A.dept_code,											" + 
     "						 	           A.CONT_NO,											" + 
     "				  			           MAX(A.CHG_DEGREE) CHG_DEGREE					" + 
     "			 		            FROM R_CONTRACT_REGISTER A								" + 
     "			  	              WHERE A.dept_code 	= '" + arg_dept_code + "'  	" + 
     "		  	              GROUP BY A.dept_code,											" + 
     "							           A.CONT_NO ) IN_A									" + 
     "                  WHERE A.dept_code 	= '" + arg_dept_code + "' 				" + 
     "                    AND A.CONT_NO = IN_A.CONT_NO									" + 
     " 	                 AND A.CHG_DEGREE = IN_A.CHG_DEGREE  							" + 
     "               GROUP BY IN_A.dept_code,												" + 
     "				            IN_A.CONT_NO,													" + 
     "	 			               A.CONST_NAME,												" + 
     "				               A.CONT_DATE,												" + 
     "                           A.CONST_TAG,												" + 
     "				            IN_A.CHG_DEGREE     											";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>