<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pr_date",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("exe_prof",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("br_date",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("choice_kind",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("chg_start_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_end_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("warrant_term",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("warrant_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("delay_rt2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sbc_guarantee_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("previous_pay1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_previous_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("previous_pay2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("directamt_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bill_rt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,100));
    String query = "SELECT   0 unq_num," + 
     "             g.long_name, " + 
     "              l.exe_amt cnt_amt, " + 
     "              l.order_name s_profession_wbs_name," + 
     "              amt.sub_amt exe_amt,     " + 
     "              to_char(l.pr_dt,'yyyy.mm.dd hh24:mi') pr_date, " + 
     "              decode(l.exe_amt, 0, 0, (amt.sub_amt/l.exe_amt) * 100) exe_prof,    " + 
     "              to_char(l.br_date,'yyyy.mm.dd hh24:mi') br_date, " + 
     "              decode(l.choice_kind, 1, '수의계약', 2, '지명경쟁') choice_kind," + 
     "              to_char(g.chg_const_start_date,'yyyy.mm.dd') chg_start_dt, " + 
     "              to_char(g.chg_const_end_date,'yyyy.mm.dd') chg_end_dt,   " + 
     "              to_char(l.start_dt,'yyyy.mm.dd') start_dt, " + 
     "              to_char(l.end_dt,'yyyy.mm.dd') end_dt,   " + 
     "              l.warrant_term," + 
     "              l.warrant_guarantee_rt," + 
     "              l.delay_rt2," + 
     "              l.sbc_guarantee_rt," + 
     "              l.previous_pay1," + 
     "              l.cnt_previous_amt," + 
     "              l.previous_pay2," + 
     "              l.directamt_rt," + 
     "              100 - nvl(l.directamt_rt,0) bill_rt," + 
     "              '    ' title " + 
     "        FROM  z_code_dept g, " + 
     "              s_order_list l,     " + 
     "              s_profession_wbs w, " + 
     "         (select dept_code, order_number,												" + 
     "         			sum(NVL(sub_amt, 0)) sub_amt                             " +
     "         		from s_order_parent                                         " +
     "         	where llevel = 1																" +	
     "              and dept_code =  '" + arg_dept_code + "'                          " +
     "              and order_number =  " + arg_order_number + "              " +
     "         	group by dept_code, order_number )	amt                        " +
     "        WHERE g.dept_code         = l.dept_code       " + 
     "          and w.profession_wbs_code(+) = l.profession_wbs_code     " + 
	  "          and l.dept_code				= amt.dept_code(+)				 " +	
	  "          and l.order_number			= amt.order_number(+)          " +
     "          and l.dept_code         = '" + arg_dept_code + "' " + 
     "          and l.order_number      = " + arg_order_number + "     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>