<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
     String arg_wbs = req.getParameter("arg_wbs");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("c_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("p_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("t_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  rownum c_no, " +
    					 " 			a.eva_score + a.add_score p_score," + 
     					 "          a.eva_score + a.add_score + b.ctrl_score t_score," + 
     					 "          b.long_name " +
     					 "     FROM s_evl_proj_evlsbcr a ," + 
     					 "          s_evl_evldept b " +
     					 "    WHERE b.evl_year = a.evl_year " +
     					 "      and b.degree = a.degree " +
     					 "      and b.evl_class = a.evl_class " +
     					 "      and b.dept_code = a.dept_code " +
     					 "      and a.EVL_YEAR = '" + arg_year + "'" +
     					 "      and a.DEGREE = " + arg_degree +
     					 "      and a.EVL_CLASS = '" + arg_class + "'" +
     					 "      and a.PROFESSION_WBS_CODE = '" + arg_wbs + "'" +
     					 "      and a.SBCR_CODE = '" + arg_sbcr_code + "'" + 
     					 "      and a.EVL_YN = 'Y'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>