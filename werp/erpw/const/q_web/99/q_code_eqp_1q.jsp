<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("equp_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("regist_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("temp_regist_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("eqp_vender_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("eqp_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("eqp_size",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("own_hire_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("price_method",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unit_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ," + 
     "          a.equp_code ," + 
     "          a.regist_no," +
     "         decode(b.cust_type,'1',substrb(a.regist_no,1,3) || '-' || substrb(a.regist_no,4,2) || '-' || substrb(a.regist_no,6,5),decode(b.cust_type,'2',substrb(a.regist_no,1,6) || '-' || substrb(a.regist_no,7,7),a.regist_no)) temp_regist_no,   " + 
     "          b.eqp_vender_name ," + 
     "          a.eqp_name ," + 
     "          a.eqp_size ," + 
     "          a.own_hire_tag ," + 
     "          a.price_method ," + 
     "          a.unit_price     FROM q_code_equipment a, " +
     " q_code_eqp_vender b     WHERE ( a.regist_no = b.regist_no (+) " +
     " and a.DEPT_CODE = " + "'" + arg_dept + "'" + " )       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>