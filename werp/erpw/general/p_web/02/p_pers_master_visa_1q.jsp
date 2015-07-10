<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("nation_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("visa_div_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  p_pers_visa.resident_no ," + 
     "          p_pers_visa.spec_no_seq ," + 
     "          p_pers_visa.seq ," + 
     "          p_pers_visa.nation_code ," + 
     "          p_pers_visa.visa_div_code ," + 
     "          to_char(p_pers_visa.s_date,'yyyy.mm.dd') s_date ," + 
     "          to_char(p_pers_visa.e_date,'yyyy.mm.dd') e_date ," + 
     "          p_pers_visa.remark   " +
     "  FROM p_pers_visa    " +
     "   where p_pers_visa.resident_no = '" + arg_resident_no   + "'    " +
     "  ORDER BY p_pers_visa.seq                ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>