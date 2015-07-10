<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("asst_numb",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("resc_name",GauceDataColumn.TB_STRING,150));
	dSet.addDataColumn(new GauceDataColumn("resc_unit",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("resc_spec",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("newx_code",GauceDataColumn.TB_STRING,15));
	dSet.addDataColumn(new GauceDataColumn("newx_name",GauceDataColumn.TB_STRING,150));
	dSet.addDataColumn(new GauceDataColumn("newx_unit",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("newx_spec",GauceDataColumn.TB_STRING,50));

    String query = " select a.asst_numb, a.resc_name, a.resc_unit, a.resc_spec, a.newx_code, b.name newx_name, " +
	               " b.unitcode newx_unit, b.ssize newx_spec " +
	               " from m_inv_temp a left join m_code_material b on a.newx_code = b.mtrcode " +
	               " ORDER BY a.resc_name, a.resc_unit, a.resc_spec";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>