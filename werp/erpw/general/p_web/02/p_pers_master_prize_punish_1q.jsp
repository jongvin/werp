<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rnp_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("rnp_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("enforce_office",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("p_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("eval_affect_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_pers_prize_punish.resident_no ," + 
     "          p_pers_prize_punish.spec_no_seq ," + 
     "          p_pers_prize_punish.seq ," + 
     "          p_pers_prize_punish.rnp_code ," + 
     "          to_char(p_pers_prize_punish.rnp_date,'yyyy.mm.dd') rnp_date ," + 
     "          p_pers_prize_punish.enforce_office ," + 
     "          p_pers_prize_punish.dept_code ," + 
     "          p_pers_prize_punish.grade_code ," + 
     "          to_char(p_pers_prize_punish.p_end_date,'yyyy.mm.dd') p_end_date ," + 
     "          p_pers_prize_punish.eval_affect_yn ," + 
     "          p_pers_prize_punish.remark   " +
     "  FROM p_pers_prize_punish  " +
     "   where p_pers_prize_punish.resident_no = '" + arg_resident_no   + "'    " +
     " ORDER BY p_pers_prize_punish.seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>