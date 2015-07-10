<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_wbs_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("order_wbs_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,6));
    String query = "  SELECT a.dept_code dept_code,   " + 
     "         a.order_number order_number,   " + 
     "         a.order_wbs_code order_wbs_code,   " + 
     "         b.name order_wbs_name," + 
     "         a.order_name order_name,   " + 
     "         a.sbcr_code sbcr_code,   " + 
     "         c.sbcr_name sbcr_name," + 
     "         d.chg_degree chg_degree," + 
     "         d.approve_class approve_class " + 
     "    FROM s_order_list a," + 
     "         s_order_wbs b," + 
     "         s_sbcr c," + 
     "         (select a.dept_code, a.order_number,a.chg_degree, " + 
     "                 max(approve_class) approve_class" + 
     "				from (select dept_code,order_number, max(chg_degree) chg_degree" + 
     "						  from s_chg_cn_list " + 
     "						 where dept_code = '" + arg_dept_code + "' " + 
     "					 group by dept_code,order_number ) a," + 
     "		            s_chg_cn_list b" + 
     "		     where a.dept_code    = b.dept_code" + 
     "		       and a.order_number = b.order_number" + 
     "		       and a.chg_degree   = b.chg_degree" + 
     "		  group by a.dept_code, a.order_number ,a.chg_degree)d" + 
     "   WHERE a.sbcr_code      	= c.sbcr_code" + 
     "     AND a.order_wbs_code 	= b.order_wbs_code" + 
     "     AND a.dept_code 		= d.dept_code" + 
     "     AND a.order_number 	= d.order_number" + 
     "     AND a.dept_code 		= '" + arg_dept_code + "'   " + 
     "     AND a.approve_class 	= '5'" + 
     "ORDER BY a.order_number DESC        ";
//     "                 decode(max(approve_class),'1','작성중', '2', '요청', '3', '반송', '4', '승인','5','승인') approve_class" + 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>