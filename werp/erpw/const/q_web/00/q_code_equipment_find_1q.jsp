<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_name = req.getParameter("arg_name") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("equp_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("eqp_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("eqp_size",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("eqp_vender_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("comp_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE, " + 
     "         a.EQUP_CODE, " + 
     "         a.EQP_NAME, " + 
     "         a.EQP_SIZE, " + 
     "         b.eqp_vender_name ," +
     "         DECODE(a.PRICE_METHOD,'1',a.unit_price,decode(a.price_method,'2',trunc(a.unit_price /10,0),trunc(a.unit_price/250,0))) comp_price " + 
     "    FROM q_code_equipment a," + 
     "         q_code_eqp_vender b " +
     "   WHERE a.regist_no = b.regist_no " +
     "     and ( a.DEPT_CODE = " + "'" + arg_dept + "'" + " )      " +
     "     and a.eqp_name like " + "'" + arg_name + "'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>