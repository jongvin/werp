<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("main_process_bigo",GauceDataColumn.TB_STRING,1000));
    String query = "  SELECT  c_question_replay.dept_code ," + 
     "          to_char(c_question_replay.yymm,'yyyy.mm.dd') yymm ," + 
     "          c_question_replay.main_process_bigo  " + 
     "       FROM c_question_replay " + 
     "      WHERE ( c_question_replay.dept_code = '" + arg_dept_code + "' ) " + 
     "        and c_question_replay.yymm = '" + arg_yymm + "' " + 
     "      ORDER BY c_question_replay.yymm          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>