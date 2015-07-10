<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("paymentmethod",GauceDataColumn.TB_STRING,200));
     
    String query = "select max(c.sbcr_name) sbcr_name," + 
    					 "       max(a.sbcr_code) sbcr_code," +
					    "       to_char(max(a.yymmdd),'YYYY.MM.DD') approym," + 
					    "       nvl(max(a.seq),0) approseq," + 
					    "       1 chg_cnt," + 
					    "       max(b.inputtitle) approtitle , " + 
					    "       max(b.paymethod) paymentmethod  " + 
					    "  from m_input_detail a," + 
					    "       m_input b," +
					    "	      s_sbcr c" + 
					    " where a.sbcr_code = c.sbcr_code" + 
					    "   and a.dept_code = b.dept_code " +
					    "   and a.yymmdd    = b.yymmdd " +
					    "   and a.seq       = b.seq " +
					    "   and a.dept_code = '" + arg_dept_code + "'" + 
					    "   and a.inouttypecode = '9' " +
					    "   and a.ditag <> '5' " +
					    "   and a.vat_unq_num = 0 and a.SEQ > 0 " + 
					    " group by a.dept_code,a.yymmdd,a.seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>