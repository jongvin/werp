<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date 	  = req.getParameter("arg_date");
     String arg_to_date 	  = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("inputtitle",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("relative_proj_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("output_yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("relative_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("paymethod",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("total_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.YYMMDD,'YYYY.MM.DD') YYMMDD,  " + 
     "         to_char(a.YYMMDD,'YYYY.MM.DD') KEY_YYMMDD,  " + 
     "         a.SEQ,   " + 
     "         a.INPUTTITLE,   " + 
     "         a.RELATIVE_PROJ_CODE,   " + 
     "         to_char(a.OUTPUT_YYMMDD,'YYYY.MM.DD') OUTPUT_YYMMDD,   " + 
     "         a.RELATIVE_SEQ,   " + 
     "         a.sbcr_code,   " + 
     "         a.INOUTTYPECODE,   " + 
     "         a.PAYMETHOD,   " + 
     "         a.TOTAL_AMT,   " + 
     "         a.MEMO," + 
     "			b.long_name," + 
     "			c.sbcr_name," + 
     "         a.invoice_num " +
     "    FROM M_INPUT  a," + 
     "			Z_CODE_DEPT b," + 
     "			s_sbcr c" + 
     "   WHERE ( a.RELATIVE_PROJ_CODE = b.dept_code (+)) AND" + 
     "			( a.sbcr_code = c.sbcr_code (+)) and" + 
     "			( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( a.YYMMDD >= " + "'" + arg_date + "'" + " )  and a.SEQ > 0 and " + 
     "         ( a.YYMMDD <= '" + arg_to_date + "')" +
     "order by a.YYMMDD DESC," + 
     "			a.SEQ DESC" + 
     "            " + 
     "     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>