<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("temp_term",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  b.long_name ," + 
     					 "          a.sbc_name ," + 
     					 "          to_char(c.sbc_dt,'YYYY.MM.DD') sbc_dt ," + 
     					 "          to_char(a.start_dt,'YYYY.MM.DD') || '~' || to_char(a.end_dt,'YYYY.MM.DD') temp_term ," + 
     					 "          a.sbc_amt " +
     					 "     FROM z_code_dept b," + 
     					 "          s_cn_list  a, " +
     					 "          s_chg_cn_list c " +
     					 "    WHERE a.dept_code = c.dept_code " +
     					 "      and a.order_number = c.order_number " +
     					 "      and c.chg_degree = 1 " +
     					 "      and b.dept_code = a.dept_code " +
     					 "      and a.SBCR_CODE = '" + arg_sbcr_code + "'" +
     					 " ORDER BY a.sbc_dt          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>