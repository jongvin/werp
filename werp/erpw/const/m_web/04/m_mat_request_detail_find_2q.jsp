<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_approym = req.getParameter("arg_approym");
     String arg_approseq = req.getParameter("arg_approseq");
     String arg_ditag = req.getParameter("arg_ditag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
    String query = "select a.dept_code," + 
 					    "       to_char(a.yymmdd,'YYYY.MM.DD') yymmdd," + 
 					    "       a.seq," + 
 					    "       a.input_unq_num," + 
 					    "       a.name," + 
 					    "       a.ssize," + 
 					    "       a.unitcode," + 
 					    "       a.ditag," + 
 					    "       a.qty," + 
 					    "       a.unitprice," + 
 					    "       a.amt," + 
 					    "       a.vatamt," + 
 					    "       a.vat_unq_num," + 
 					    "       a.vattag, " + 
					    "       ''      comp_chk " +
 					    "  from m_input_detail a" + 
 					    " where a.dept_code = '" + arg_dept_code + "'" + 
 					    "   and a.yymmdd = '" + arg_approym + "'" +
 					    "   and a.seq = " + arg_approseq + 
 					    "   and a.vat_unq_num = 0" + 
 					    "   and a.ditag <> '5' " +
 					    "   and a.ditag = '" + arg_ditag + "'" +
 					    " order by a.yymmdd,a.seq,a.detailseq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>