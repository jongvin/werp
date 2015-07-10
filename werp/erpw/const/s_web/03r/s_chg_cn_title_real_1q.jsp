<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
    String query = " " + 
       " select  a.dept_code, " + 
       "         a.order_number,  " + 
       "         c.sbcr_name,  " + 
       "         e.profession_wbs_name,  " + 
       "         b.sbc_name,   " + 
       "         a.chg_degree, " + 
       "         b.order_class, " + 
       "         b.approve_class " + 
       "     from (  " + 
			         "  SELECT s_chg_cn_list.dept_code dept_code,   " + 
			         "         s_chg_cn_list.order_number order_number,   " + 
			         "         max(chg_degree) chg_degree,   " + 
			         "         min(approve_class) approve_class " + 
			         "    FROM s_chg_cn_list " + 
			         "    where    s_chg_cn_list.dept_code = '" + arg_dept_code + "' " + 
			         " GROUP BY s_chg_cn_list.dept_code,   " + 
			         "         s_chg_cn_list.order_number,   " + 
			         "         s_chg_cn_list.order_name ) a, s_chg_cn_list b, s_sbcr c, s_order_list d, s_profession_wbs e " +
            " where a.dept_code = b.dept_code and  " + 
            "       a.order_number = b.order_number and " + 
            "       a.chg_degree = b.chg_degree  and " + 
            "       b.sbcr_code = c.sbcr_code and" + 
            "       a.dept_code = d.dept_code and  " + 
            "       a.order_number = d.order_number and " + 
            "       d.profession_wbs_code = e.profession_wbs_code " + 
            " order by a.order_number desc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>