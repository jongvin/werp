<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("loc_useq",GauceDataColumn.TB_DECIMAL,25,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("res_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("res_reg_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("res_phone",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("res_cell",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("res_mvin_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("attrib1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("attrib2",GauceDataColumn.TB_STRING,20));
     
    String query = "  select loc_useq, " +
             "               dept_code, " +
             "               dong, " +
             "               ho, " +
             "               floor, " +
             "               res_name, " +
             "               res_reg_no, " +
             "               res_phone, " +
             "               res_cell, " +
             "               to_char(res_mvin_date,'yyyy-mm-dd') res_mvin_date, " +
             "               note, " +
             "               attrib1, " +
             "               attrib2 " +
             "             from a_as_location " +
             "             where dept_code = '" + arg_dept_code + "' " +
             "             order by dong, ho, floor ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>