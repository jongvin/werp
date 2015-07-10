<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_where = req.getParameter("arg_where");
     arg_where = arg_where.replace('!','+'); 
     String arg_name = req.getParameter("arg_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("weather_1",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("weather_2",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("heat_1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("heat_2",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("master_confirm",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bigo",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("next_bigo",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,1000));
    String query = "  SELECT b.dept_code,   " +
     "        to_char(a.yymmdd,'yyyy.mm.dd')  yymmdd,  " +
     "        a.weather_1,   " +
     "        a.weather_2,   " +
     "        a.heat_1,   " +
     "        a.heat_2,   " +
     "        nvl(a.master_confirm,'X') master_confirm,   " +
     "        a.bigo,   " +
     "        a.next_bigo,  " +
     "        b.long_name,  " +
     "        a.remark  " +
     "    FROM c_daily_parent a , " +
     "         z_code_dept b, " + 
     "           (select dept_code,max(chg_no_seq) chg_no_seq from c_chg_progress group by dept_code) c " + 
     "      WHERE b.long_name like '%" + arg_name + "%' and " + 
     "  " + arg_where + " " + 
     "        and b.dept_code  = c.dept_code(+) " + 
     "    ORDER BY b.long_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>