<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("rate_kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("mnth",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cutoff_std",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cutoff_unit",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_rate_kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_mnth",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("old_s_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  h_base_delay_rate.dept_code ," + 
     "          h_base_delay_rate.sell_code ," + 
     "          h_base_delay_rate.rate_kind ," + 
     "          h_base_delay_rate.mnth ," + 
     "          to_char(h_base_delay_rate.s_date,'yyyymmdd') s_date ," + 
     "          to_char(h_base_delay_rate.e_date,'yyyymmdd') e_date ," + 
     "          h_base_delay_rate.rate ," + 
     "          h_base_delay_rate.cutoff_std ," + 
     "          h_base_delay_rate.cutoff_unit,  " + 
     "          h_base_delay_rate.rate_kind old_rate_kind," + 
     "          h_base_delay_rate.mnth old_mnth," + 
     "          to_char(h_base_delay_rate.s_date,'yyyymmdd') old_s_date " + 
     "         FROM h_base_delay_rate    " + 
     "         WHERE ( h_base_delay_rate.dept_code = '" + arg_dept_code  + "') and " + 
     "               ( h_base_delay_rate.sell_code = '" + arg_sell_code  + "')       " + 
     "          order by  h_base_delay_rate.rate_kind, h_base_delay_rate.s_date, h_base_delay_rate.mnth  "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>