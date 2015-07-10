<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_bank_head_code = req.getParameter("arg_bank_head_code");
     String arg_bank_head_name = req.getParameter("arg_bank_head_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("bank_head_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  A.BANK_MAIN_CODE bank_head_code ," + 
                   "          A.BANK_MAIN_NAME bank_head_name  " + 
                   "     FROM T_BANK_MAIN A  " + 
                   "    WHERE ( A.BANK_MAIN_CODE like '" + arg_bank_head_code + "%'     " + 
                   "          or  A.BANK_MAIN_NAME like '" + arg_bank_head_name + "%' )    " + 
                   " order by A.BANK_MAIN_NAME, A.BANK_MAIN_CODE ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>