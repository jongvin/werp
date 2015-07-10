<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("part_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,100));
    String query = "  select " +
       "                 substr(a.safety_code,1,2) part_code, " +
       "                 b.child_name part_name, " +
       "                 a.safety_code item_code, " +
       "                 a.child_name item_name " +
       "              from e_safety_code_child a, " +
       "                  (select safety_code, child_name from e_safety_code_child where class_tag=77) b " +
       "              where a.class_tag=78 " +
       "                and substr(a.safety_code,1,2)=b.safety_code" +
       "              order by a.safety_code asc";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>