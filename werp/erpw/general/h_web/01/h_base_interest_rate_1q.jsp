<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_sell_code = req.getParameter("as_sell_code");
     String as_rate_kind = req.getParameter("as_rate_kind");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("rate_kind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("days",GauceDataColumn.TB_STRING,23));
     dSet.addDataColumn(new GauceDataColumn("term",GauceDataColumn.TB_STRING,23));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cutoff_std",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cutoff_unit",GauceDataColumn.TB_STRING,2));
    String query = "SELECT A.DEPT_CODE," + 
     "	    A.SELL_CODE," + 
     "	    A.RATE_KIND," + 
     "	    TO_CHAR(A.S_DAYS) || ' - ' || TO_CHAR(A.E_DAYS) DAYS," + 
     "	    TO_CHAR(A.S_DATE, 'YYYY.MM.DD') || ' ~ ' ||TO_CHAR(A.E_DATE, 'YYYY.MM.DD') TERM," + 
     "	    A.RATE," + 
     "	    A.CUTOFF_STD," + 
     "	    A.CUTOFF_UNIT" + 
     "  FROM H_BASE_DELAY_RATE A" + 
     " WHERE A.DEPT_CODE = '" + as_dept_code + "'" + 
     "   AND A.SELL_CODE = '" + as_sell_code + "'" +
     "   AND A.RATE_KIND LIKE" + "'" + as_rate_kind +  "%'"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>