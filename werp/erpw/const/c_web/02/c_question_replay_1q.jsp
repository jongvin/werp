<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
//     String arg_where = req.getParameter("arg_where");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("yymm_disp",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("main_process_bigo",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("hang_1",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("question_1",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("replay_1",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("bigo_1",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("hang_2",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("question_2",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("replay_2",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("bigo_2",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("hang_3",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("question_3",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("replay_3",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("bigo_3",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("hang_4",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("question_4",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("replay_4",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("bigo_4",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("bigo_1_chumbu",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("bigo_2_chumbu",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("bigo_3_chumbu",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("bigo_4_chumbu",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,255));
    String query = "  SELECT  c_question_replay.dept_code ," + 
     "          to_char(c_question_replay.yymm,'yyyy.mm.dd') yymm ," + 
     "          to_char(c_question_replay.yymm,'yyyy.mm') yymm_disp ," + 
     "          c_question_replay.main_process_bigo ," + 
     "          c_question_replay.hang_1 ," + 
     "          c_question_replay.question_1 ," + 
     "          c_question_replay.replay_1 ," + 
     "          c_question_replay.bigo_1 ," + 
     "          c_question_replay.hang_2 ," + 
     "          c_question_replay.question_2 ," + 
     "          c_question_replay.replay_2 ," + 
     "          c_question_replay.bigo_2 ," + 
     "          c_question_replay.hang_3 ," + 
     "          c_question_replay.question_3 ," + 
     "          c_question_replay.replay_3 ," + 
     "          c_question_replay.bigo_3 ," + 
     "          c_question_replay.hang_4 ," + 
     "          c_question_replay.question_4 ," + 
     "          c_question_replay.replay_4 ," + 
     "          c_question_replay.bigo_4, " + 
     "          c_question_replay.bigo_1_chumbu, " + 
     "          c_question_replay.bigo_2_chumbu, " + 
     "          c_question_replay.bigo_3_chumbu, " + 
     "          c_question_replay.bigo_4_chumbu, " + 
     "          c_question_replay.bigo_4_chumbu, " + 
     "          c_question_replay.bigo_1_chumbu cdir, " + 
     "          '                                                             ' name " + 
     "       FROM c_question_replay   " + 
     "     WHERE ( c_question_replay.dept_code = '" + arg_dept_code + "')       " + 
//     "    " + arg_where + " " + 
     "   order by c_question_replay.yymm ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>