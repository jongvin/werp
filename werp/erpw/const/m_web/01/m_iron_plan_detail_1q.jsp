<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code= req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_matcode = req.getParameter("arg_matcode");
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
     dSet.addDataColumn(new GauceDataColumn("sbcr_code1",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name1",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code2",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name2",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code3",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name3",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code4",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name4",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("proj_tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  dept_code ," + 
     					 "          to_char(month,'YYYY.MM.DD') month ," + 
     					 "          mtrcode ," + 
     					 "          seq ," + 
     					 "          meta ," + 
     					 "          remaind_qty ," + 
     					 "          week1 ," + 
     					 "          week2 ," + 
     					 "          week3 ," + 
     					 "          week4 ," + 
     					 "          week_tot ," + 
     					 "          mon_qty1 ," + 
     					 "          mon_qty2 ," + 
     					 "          sbcr_code1 ," + 
     					 "          sbcr_name1 ," + 
     					 "          sbcr_code2 ," + 
     					 "          sbcr_name2 ," + 
     					 "          sbcr_code3 ," + 
     					 "          sbcr_name3 ," + 
     					 "          sbcr_code4 ," + 
     					 "          sbcr_name4 ," + 
     					 "          proj_tel ," + 
     					 "          bigo  " +
     					 "     FROM m_iron_plan_detail " +
     					 "    WHERE DEPT_CODE = '" + arg_dept_code  + "'" + 
     					 "      and MONTH = '" + arg_yymm + "'" +
     					 "      And MTRCODE = '" +  arg_matcode + "'" +
     					 " ORDER BY seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>