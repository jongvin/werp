<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("repay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("repay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("interest_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT " + 
     "          a.spec_no_seq ," + 
     "          to_char(a.repay_date, 'YYYY.MM.DD') repay_date ," + 
     "          a.repay_amt ," + 
     "          a.interest_amt ," + 
     "          a.remark     FROM p_gen_repay a, p_gen_loan b   " +
     "    where a.spec_no_seq = b.spec_no_seq " +
     "      and a.spec_no_seq = " + arg_spec_no_seq + "    		 " + 
     " ORDER BY a.repay_date          ASC     				 " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>