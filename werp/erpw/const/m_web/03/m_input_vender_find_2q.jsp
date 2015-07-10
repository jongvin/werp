<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("from_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = "  select a.sbcr_code, " +
                   "         to_char(a.from_dt,'YYYY.MM.DD') from_dt, " +
                   "         to_char(a.to_dt,'YYYY.MM.DD') to_dt,  " +
                   "         a.seq_num, " +
                   "         b.sbcr_name, " +
                   "         a.remark " +
                   "    from m_price_contract a, " +
                   "         s_sbcr b " +
                   "   where a.sbcr_code = b.sbcr_code (+) " +
                   "     and a.from_dt <= '" + arg_date + "'" +
                   "     and a.to_dt >= '" + arg_date + "'" + 
                   " order by b.sbcr_name " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>