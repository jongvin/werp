<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gong_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT NVL(s_chg_cn_list.supply_amt_tax,0) +    " + 
     "         NVL(s_chg_cn_list.supply_amt_notax,0) + NVL(s_chg_cn_list.vat,0) tot_amt,   " + 
     "         NVL(s_chg_cn_list.vat,0) vat,  " + 
     "         NVL(s_chg_cn_list.supply_amt_tax,0) + NVL(s_chg_cn_list.supply_amt_notax,0) gong_amt " +  
     "    FROM s_chg_cn_list" + 
     "   WHERE          ( ( s_chg_cn_list.dept_code = '" + arg_dept_code + "') AND  " + 
     "         ( s_chg_cn_list.order_number = " + arg_order_number + " ) AND  " + 
     "         ( s_chg_cn_list.chg_degree = " + arg_chg_degree + " )   " + 
     "         )         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>