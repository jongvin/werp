<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("part_name",GauceDataColumn.TB_STRING,50));
    String query =" select  " + 
						" etc_code part_code, child_name part_name" +
						" from z_code_etc_child where class_tag = '041' " +
						" order by part_code " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>