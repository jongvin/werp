<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_degree = req.getParameter("arg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("company1",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("owner1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bonsa_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("class2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("company2",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("owner2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sbcr_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT '본사' class1,   " + 
					    "         c.comp_name company1,   " + 
					    "         c.comp_owner owner1,   " + 
					    "         to_char(a.bonsa_dt,'yyyy.mm.dd') bonsa_dt, " + 
					    "	        '수급사' class2," + 
					    "	        b.sbcr_name company2," + 
					    "	        b.rep_name1 owner2," + 
					    "         to_char(a.sbcr_dt,'yyyy.mm.dd') sbcr_dt, " + 
					    "         a.approve_class " +
					    "    FROM s_chg_cn_list a, " + 
					    "         s_sbcr b, " + 
					    "         z_code_comp c " +
					    "   WHERE (substr(a.dept_code,1,2) = c.comp_code(+)) and " +
					    "         ( a.sbcr_code = b.sbcr_code ) and" + 
					    "         ( a.dept_code = '" + arg_dept + "')  and " +
					    "         ( a.order_number = " + arg_order_number + " ) and " +
					    "         ( a.chg_degree = " + arg_degree + " )" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>