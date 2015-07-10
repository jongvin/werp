<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("request_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("approve_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.degree,   " + 
     "         to_char(a.apply_date,'yyyy.mm.dd') apply_date,   " + 
     "         to_char(a.work_date,'yyyy.mm.dd') work_date,   " + 
     "         to_char(a.request_date,'yyyy.mm.dd') request_date,   " + 
     "         to_char(a.approve_date,'yyyy.mm.dd') approve_date,   " + 
     "         a.title,   " + 
     "         a.approve_class  " + 
     "    FROM z_code_dept_degree a" + 
     "  order by  a.degree desc   " + 
     "                 ";
%><%@ include file="../comm_function/conn_q_end.jsp"%>