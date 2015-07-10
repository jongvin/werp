<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("passport_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("passport_type_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pass_s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pass_e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pass_remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  p_pers_passport.resident_no ," + 
     "          p_pers_passport.passport_no ," + 
     "          p_pers_passport.passport_type_code ," + 
     "          to_char(p_pers_passport.s_date,'yyyy.mm.dd') pass_s_date ," + 
     "          to_char(p_pers_passport.e_date,'yyyy.mm.dd') pass_e_date ," + 
     "          p_pers_passport.remark pass_remark   " +
     "  FROM p_pers_passport        " +
     "   where p_pers_passport.resident_no = '" + arg_resident_no   + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>