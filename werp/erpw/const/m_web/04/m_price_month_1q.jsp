<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_dept_code = req.getParameter("arg_dept_code");
	String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("basic_date",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
   dSet.addDataColumn(new GauceDataColumn("input_section",GauceDataColumn.TB_STRING,1));
	dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("standard_amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
	dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
	dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
   dSet.addDataColumn(new GauceDataColumn("slip_st",GauceDataColumn.TB_STRING,1));
	String  query = "  SELECT  a.dept_code ," + 
						 "          to_char(a.yymmdd,'YYYY.MM.DD') yymmdd, " +
						 "          a.seq, " +
						 "          a.input_unq_num, " +
						 "          to_char(a.month,'YYYY.MM.DD') month, " +
						 "          to_char(a.basic_date,'YYYY.MM.DD') basic_date, " +
						 "          a.qty, " +
						 "          a.amt, " +
						 "          a.vatamt, " +
						 "          a.spec_no_seq, " +
						 "          a.spec_unq_num, " +
						 "          a.invoice_num, " +
						 "          b.input_section, " +
						 "          b.unitprice, " +
						 "          b.standard_amt, " +
						 "          c.mtrcode, " +
						 "          c.name, " +
						 "          c.ssize, " +
						 "          c.unitcode, " +
						 "          d.sbcr_name, " +
						 "          F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name, " +
						 "          decode(a.invoice_num,null,'A',F_T_SLIP_STAT(to_number(a.invoice_num))) slip_st " +
						 "     from m_price_month a, " +
						 "          m_input_price b, " +
						 "          m_input_detail c, " +
						 "          s_sbcr d " +
						 "    where a.dept_code = b.dept_code " +
						 "      and a.yymmdd = b.yymmdd " +
						 "      and a.seq = b.seq " +
						 "      and a.input_unq_num = b.input_unq_num " +
						 "      and a.dept_code = c.dept_code " +
						 "      and a.yymmdd = c.yymmdd " +
						 "      and a.seq = c.seq " +
						 "      and a.input_unq_num = c.input_unq_num " +
						 "      and b.sbcr_code = d.sbcr_code " +
						 "      and a.dept_code = '" + arg_dept_code + "'" +
						 "      and trunc(a.month,'MM') = '" + arg_date + "' " +
						 " order by c.mtrcode asc " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>