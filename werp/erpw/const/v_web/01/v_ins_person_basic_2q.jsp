<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("school_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("major",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("graduation_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("school_section",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.emp_no,															" + 
     "                       a.seq,																" + 
     "                       a.school_name,													" + 
     "             			  a.major,															" + 
     "                       a.grade,															" + 
     "                       to_char(a.graduation_dt, 'yyyy.mm.dd') graduation_dt,	" + 
     "                       a.school_section        										" +
     "                  FROM v_ip_achievement a   											" +
     "                 WHERE a.emp_no = '" + arg_emp_no + "' 							" +
     "				  ORDER BY a.emp_no ASC,													" + 
     "                       a.seq ASC         												";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>