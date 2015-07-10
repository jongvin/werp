<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_dept = '%' + req.getParameter("arg_dept") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("budget_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("input_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("remaind_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("send_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("week_tot",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("remaind_tot",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.month,'YYYY.MM.DD') month ," + 
     					 "          a.mtrcode ," + 
     					 "          b.name, " +
     					 "          b.ssize, " +
     					 "          b.unitcode, " +
     					 "          decode(a.budget_qty,0,'',a.budget_qty) budget_qty ," + 
     					 "          a.input_qty ," + 
     					 "          a.budget_qty - a.input_qty remaind_qty ," + 
     					 "          a.send_yn ,  " +
     					 "          c.week_tot, " +
     					 "          a.budget_qty - a.input_qty - nvl(c.week_tot,0) remaind_tot, " +
     					 "          d.long_name " +
     					 "     FROM m_iron_plan a, " +
     					 "          m_code_material b, " +
     					 "          z_code_dept d, " +
     					 "          ( select max(dept_code) dept_code,max(mtrcode) mtrcode,nvl(sum(week_tot),0) week_tot" +
     					 "              from m_iron_plan_detail " +
     					 "             where to_char(month,'yyyy.mm.dd') = '" + arg_yymm + "'" +
     					 "          group by dept_code,mtrcode ) c " +
     					 "    WHERE a.mtrcode = b.mtrcode(+) " +
     					 "      and a.dept_code = c.dept_code(+) " +
     					 "      and a.mtrcode = c.mtrcode(+) " +
     					 "      and a.dept_code = d.dept_code (+)" +
					    "      AND d.long_name like '" + arg_dept + "'  " + 
     					 "      and to_char(a.MONTH,'yyyy.mm.dd') = '" + arg_yymm + "'" +
     					 "      and a.send_yn = 'Y'" +
     					 " ORDER BY a.dept_code asc, a.mtrcode          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>