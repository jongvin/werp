<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_search = req.getParameter("arg_search");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("join_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("charge_business",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("work_range",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("effect_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_item",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("position",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT a.emp_no,																" + 
     "                       a.name,																" + 
     "							  a.dept_code,															" +
     "                       (select long_name from z_code_dept where dept_code=a.dept_code) dept_name, " + 
     "                       to_char(a.join_dt, 'yyyymmdd') join_dt,						" + 
     "                       a.charge_business,													" + 
     "                       a.work_range,														" + 
     "                       to_char(a.approve_dt, 'yyyymmdd') approve_dt,				" + 
     "                       to_char(a.effect_dt, 'yyyymmdd') effect_dt,				" + 
     "                       a.approve_item,														" + 
     "                       a.position,															" + 
     "                       a.remark        													" +
     "						FROM v_ins_person a														" +
     "                 WHERE " + arg_search + 													
     "              ORDER BY a.emp_no ASC         												";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>