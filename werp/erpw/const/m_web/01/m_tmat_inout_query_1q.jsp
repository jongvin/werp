<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = '%' + req.getParameter("arg_dept") + '%';
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_name = '%' + req.getParameter("arg_name") + '%';
     String arg_ssize = '%' + req.getParameter("arg_ssize") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmat_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("remaind_qty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("in1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in5",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in6",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in7",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in8",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in9",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in11",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in12",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("in_next",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("send_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  a.dept_code ," + 
                   "          a.long_name, " +
     					 "          to_char(a.month,'YYYY.MM.DD') month ," + 
     					 "          a.tmat_code ," + 
     					 "          a.remaind_qty ," + 
     					 "          a.in_class, " +
     					 "          a.in1 ," + 
     					 "          a.in2 ," + 
     					 "          a.in3 ," + 
     					 "          a.in4 ," + 
     					 "          a.in5 ," + 
     					 "          a.in6 ," + 
     					 "          a.in7 ," + 
     					 "          a.in8 ," + 
     					 "          a.in9 ," + 
     					 "          a.in10 ," + 
     					 "          a.in11 ," + 
     					 "          a.in12 ," + 
     					 "          a.in_next ," + 
     					 "          a.send_yn, " + 
     					 "          b.name , " +
     					 "          b.ssize, " +
     					 "          b.unitcode " +
     					 "     FROM m_tmat_code  b , " +
     					 "          ( select a.dept_code,b.long_name,a.month,a.tmat_code,a.remaind_qty,'1' in_class,a.in1,a.in2,a.in3," +
     					 "                   a.in4,a.in5,a.in6,a.in7,a.in8,a.in9,a.in10,a.in11,a.in12,a.in_next,a.send_yn " +
     					 "              from m_tmat_plan a, " +
     					 "                   z_code_dept b " +
     					 "             where a.dept_code = b.dept_code " +
     					 "               and a.month = '" + arg_yymm + "'" +
     					 "               and nvl(b.long_name,' ') like '" + arg_dept + "'" +
     					 "            union all " +
     					 "            select a.dept_code,b.long_name,a.month,a.tmat_code,a.remaind_qty,'2' in_class,a.out1 in1,a.out2 in2, " +
     					 "                   a.out3 in3,a.out4 in4,a.out5 in5,a.out6 in6,a.out7 in7,a.out8 in8,a.out9 in9," +
     					 "                   a.out10 in10,a.out11 in11,a.out12 in12,a.out_next in_next,a.send_yn " +
     					 "              from m_tmat_plan a, " +
     					 "                   z_code_dept b " +
     					 "             where a.dept_code = b.dept_code " +
     					 "               and a.month = '" + arg_yymm + "'" +
     					 "               and nvl(b.long_name,' ') like '" + arg_dept + "' ) a" +
     					 "    WHERE a.tmat_code = b.tmat_code(+) "  +
     					 "      and nvl(b.name,' ') like '" + arg_name + "'" +
     					 "      and nvl(b.ssize,' ') like '" + arg_ssize + "'" +
     					 " order by a.long_name,a.tmat_code,a.in_class " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>