<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("group_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cp_r_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_r_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_r_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_r_operating_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_r_net_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_r_net_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_r_net_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_r_net_income_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_n_asset_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_n_asset_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_n_asset_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_n_asset_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_n_liability_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_n_liability_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_n_liability_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_n_liability_total_ratio",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT  a.group_id , 														" +
			"		             a.cp_r_operating_income_ratio ,                         " +
			"		             a.pp_r_operating_income_ratio ,                         " +
			"		             a.cy_r_operating_income_ratio ,                         " +
			"		             a.py_r_operating_income_ratio ,                         " +
			"		             a.cp_r_net_income_ratio ,                               " +
			"		             a.pp_r_net_income_ratio ,                               " +
			"		             a.cy_r_net_income_ratio ,                               " +
			"		             a.py_r_net_income_ratio ,                               " +
			"		             a.cp_n_asset_total_ratio ,                              " +
			"		             a.pp_n_asset_total_ratio ,                              " +
			"		             a.cy_n_asset_total_ratio ,                              " +
			"		             a.py_n_asset_total_ratio ,                              " +
			"		             a.cp_n_liability_total_ratio ,                          " +
			"		             a.pp_n_liability_total_ratio ,                          " +
			"		             a.cy_n_liability_total_ratio ,                          " +
			"		             a.py_n_liability_total_ratio                            " +
			"		      FROM efin_eis_earning  a                                       " +
			"			where a.group_id = " + arg_group_id + "                           " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>