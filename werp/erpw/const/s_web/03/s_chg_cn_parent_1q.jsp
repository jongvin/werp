<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("copy_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("cunt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT A.dept_code,   " + 
     "         A.order_number,   " + 
     "         A.chg_degree,   " + 
     "         A.spec_no_seq,   " + 
     "         A.seq,   " + 
     "         A.direct_class,   " + 
     "         A.llevel,   " + 
     "         A.sum_code,   " + 
     "         A.parent_sum_code,   " + 
     "         A.invest_class,   " + 
     "         A.copy_yn,   " + 
     "         A.name,  " + 
	 "         nvl(b.cunt,0) cunt " +
     "    FROM s_chg_cn_parent A, " + 
	 "		   (" +
 	 "			SELECT" +
	 "				DEPT_CODE,ORDER_NUMBER,CHG_DEGREE,spec_no_seq,nvl(COUNT(*),0) cunt" +
	 "			FROM" +
	 "				S_CHG_CN_DETAIL" +
	 "			WHERE " +
	 "             DEPT_CODE = '" + arg_dept_code + "' AND ORDER_NUMBER = " + arg_order_number + " AND CHG_DEGREE = " + arg_chg_degree  +
	 "			GROUP BY" +
	 "				DEPT_CODE,ORDER_NUMBER,CHG_DEGREE,spec_no_seq " +
	 "         ) B " +
     "   WHERE ( A.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( A.order_number = " + arg_order_number + ") AND  " + 
     "         ( A.chg_degree = " + arg_chg_degree + ")   " + 
	 "   AND A.DEPT_CODE = B.DEPT_CODE(+) AND A.ORDER_NUMBER = B.ORDER_NUMBER(+) AND A.CHG_DEGREE = B.CHG_DEGREE(+) AND A.spec_no_seq = B.spec_no_seq(+) " +
     "ORDER BY A.seq ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>