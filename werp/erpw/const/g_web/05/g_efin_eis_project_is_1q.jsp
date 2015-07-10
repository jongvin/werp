<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ptd_amount",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ytd_amount",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pjt_amount",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  " + 
                 " select a.account_name,  " +  
                 "        a.ptd_amount,  " +  
                 "        a.ytd_amount,  " +  
                 "        a.pjt_amount  " +  
                 " from efin_eis_project_is a" + 
                 " where group_id = " + arg_group_id + " " +  
                 " order by a.account_seq  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>