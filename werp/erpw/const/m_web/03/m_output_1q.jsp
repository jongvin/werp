<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("outputtitle",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("relative_proj_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("input_yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("relative_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("paymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("total_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("trans_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("sale_amt",GauceDataColumn.TB_DECIMAL,10,0));
	 dSet.addDataColumn(new GauceDataColumn("sale_vat",GauceDataColumn.TB_DECIMAL,10,0));
	 dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,10,0));
	 dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
	 dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("slip_unq_num",GauceDataColumn.TB_DECIMAL,18,0));

    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.YYMMDD,'YYYY.MM.DD')  YYMMDD,  " + 
     "         to_char(a.YYMMDD,'YYYY.MM.DD')  KEY_YYMMDD,  " + 
     "         a.SEQ,   " + 
     "         a.SEQ  KEY_SEQ, " + 
     "         rtrim(nvl(a.OUTPUTTITLE,'')) OUTPUTTITLE,   " + 
     "         a.RELATIVE_PROJ_CODE,   " + 
     "	       to_char(a.INPUT_YYMMDD,'YYYY.MM.DD') INPUT_YYMMDD," + 
     "         NVL(a.RELATIVE_SEQ,0)  RELATIVE_SEQ, " + 
     "         a.INOUTTYPECODE,   " + 
     "         a.PAYMETHOD,   " + 
     "         a.TOTAL_AMT,   " + 
     "	       a.TRANS_TAG," + 
     "         a.MEMO," + 
     "	       b.long_name," +
	 "		   nvl(c.sale_amt,0) sale_amt," +
	 "		   nvl(c.sale_vat,0) sale_vat," +
     "         to_char(c.rqst_date,'YYYY.MM.DD') rqst_date, " +
	 "	       c.cust_code," +
	 "         c.cust_name," +
	 "         c.invoice_num," +
	 "         nvl(c.SLIP_SPEC_UNQ_NUM,-1) slip_unq_num " +
     "    FROM m_output  a," + 
	 "		   m_output_sale c, " +
     "	       Z_CODE_DEPT b" + 
     "   WHERE ( a.RELATIVE_PROJ_CODE = b.dept_code (+)) AND" + 
	 "         ( a.dept_code = c.dept_code(+) and a.yymmdd = c.yymmdd(+) and a.seq = c.seq(+)) AND" +
     "	       ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( a.YYMMDD >= " + "'" + arg_date + "'" + " )  and a.SEQ > 0 and " + 
     "         ( a.YYMMDD <= '" + arg_to_date + "')" +
     "order by a.YYMMDD DESC," + 
     "	       a.SEQ DESC";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>