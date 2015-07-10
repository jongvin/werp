<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_unit = req.getParameter("arg_unit");
     String arg_sum_code = req.getParameter("arg_sum_code") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("change_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcv_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcv_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rcv_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("norcv_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rem_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code," + 
     "       b.long_name," + 
     "       trunc(round(nvl(a.change_sum_amt,0) / " + arg_unit + "),0 ) change_sum_amt," + 
     "       trunc(round(nvl(c.supply_amt,0) / " + arg_unit + "),0 )     supply_amt," + 
     "       trunc(round(nvl(c.vat_amt,0) / " + arg_unit + "),0 )        vat_amt," + 
     "       trunc(round(nvl(c.sum_amt,0) / " + arg_unit + "),0 )        sum_amt," + 
     "       trunc(round(nvl(f.supply_amt,0) / " + arg_unit + "),0 ) rcv_amt," + 
     "       trunc(round(nvl(f.vat_amt,0) / " + arg_unit + "),0 )    rcv_vat," + 
     "       trunc(round(nvl(f.sum_amt,0) / " + arg_unit + "),0 )    rcv_sum," + 
     "       trunc(round((nvl(c.sum_amt,0) - nvl(f.sum_amt,0)) / " + arg_unit + "),0 ) norcv_sum," + 
     "       trunc(round((nvl(a.change_sum_amt,0) - nvl(f.sum_amt,0)) / " + arg_unit + "),0 ) rem_amt" + 
     "  from r_contract_register a," + 
     "	  	 z_code_dept b," + 
     "		 c_spec_class_parent d," + 
     "		 c_spec_class_child e ," + 
     "		 ( select max(dept_code) dept_code," + 
     "				    sum(nvl(supply_amt,0)) supply_amt," + 
     "                sum(nvl(vat_amt,0)) vat_amt," + 
     "                sum(nvl(supply_amt,0)) + sum(nvl(vat_amt,0)) sum_amt" + 
     "			  from r_contract_time_extablished " + 
     "			group by dept_code) c," + 
     "       ( select max(dept_code) dept_code," + 
     "					 sum(nvl(supply_amt,0)) supply_amt," + 
     "                sum(nvl(vat_amt,0)) vat_amt," + 
     "                sum(nvl(supply_amt,0)) + sum(nvl(vat_amt,0)) sum_amt" + 
     "           from r_contract_time_collection" + 
     "			group by dept_code ) f" + 
     " where a.last_tag = 'Y'" + 
     "   and a.dept_code = c.dept_code (+)" + 
     "   and a.dept_code = f.dept_code (+)" + 
     "	and b.dept_code = a.dept_code (+)" + 
     "	and e.dept_code = b.dept_code" + 
     "	and d.spec_no_seq = e.spec_no_seq " + 
     "	and d.sum_code like " + "'" + arg_sum_code + "'" + 
     "	and b.chg_const_start_date is not null " + 
     "	and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "	and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" +
     " order by a.dept_code asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>