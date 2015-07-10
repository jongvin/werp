<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("meta",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remaind_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("week1",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("week2",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("week3",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("week4",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("week_tot",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mon_qty1",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mon_qty2",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("proj_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_week",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.month,'YYYY.MM.DD') month ," + 
     					 "          a.mtrcode ," + 
     					 "          a.seq ," + 
     					 "          a.meta ," + 
     					 "          a.remaind_qty ," + 
     					 "          a.week1 ," + 
     					 "          a.week2 ," + 
     					 "          a.week3 ," + 
     					 "          a.week4 ," + 
     					 "          a.week_tot ," + 
     					 "          a.mon_qty1 ," + 
     					 "          a.mon_qty2 ," + 
     					 "          a.sbcr_code ," + 
     					 "          a.sbcr_name ," + 
     					 "          b.proj_tel ," + 
     					 "          a.bigo, " +
     					 "          decode(sign(a.week1),1,to_char(a.month,'MM') || '월 1주',decode(sign(a.week2),1,to_char(a.month,'MM') || '월 2주',decode(sign(a.week3),1,to_char(a.month,'MM') || '월 3주',to_char(a.month,'MM') || '월 4주'))) comp_week, " +
     					 "          b.long_name, " + 
     					 "          c.ssize " +
     					 "     FROM m_iron_plan_detail a, " +
     					 "          z_code_dept b, " +
     					 "          m_code_material c ," +
     					 "          m_iron_plan d " +
     					 "    WHERE a.dept_code = b.dept_code " +
     					 "      and a.mtrcode  = c.mtrcode " +
     					 "      and a.dept_code = d.dept_code " +
     					 "      and a.month = d.month " +
     					 "      and a.mtrcode = d.mtrcode " +
     					 "      and d.send_yn = 'Y' " +
     					 "      and a.week_tot > 0 " +
     					 "      and a.MONTH = '" + arg_yymm + "'" +
     					 " ORDER BY a.seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>