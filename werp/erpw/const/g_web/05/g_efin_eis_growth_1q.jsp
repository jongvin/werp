<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("group_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cp_rev_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_rev_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_rev_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_rev_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_oi_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_oi_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_oi_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_oi_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_ni_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_ni_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_ni_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_ni_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_asset_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_asset_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_asset_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_asset_increase_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cp_asset_turn_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("pp_asset_turn_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cy_asset_turn_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("py_asset_turn_ratio",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT a.GROUP_ID, 														" +
		"		               a.CP_REV_INCREASE_RATIO,                              " +
		"		               a.PP_REV_INCREASE_RATIO,                              " +
		"		               a.CY_REV_INCREASE_RATIO,                              " +
		"		               a.PY_REV_INCREASE_RATIO,                              " +
		"		               a.CP_OI_INCREASE_RATIO,                               " +
		"		               a.PP_OI_INCREASE_RATIO,                               " +
		"		               a.CY_OI_INCREASE_RATIO,                               " +
		"		               a.PY_OI_INCREASE_RATIO,                               " +
		"		               a.CP_NI_INCREASE_RATIO,                               " +
		"		               a.PP_NI_INCREASE_RATIO,                               " +
		"		               a.CY_NI_INCREASE_RATIO,                               " +
		"		               a.PY_NI_INCREASE_RATIO,                               " +
		"		               a.CP_ASSET_INCREASE_RATIO,                            " +
		"		               a.PP_ASSET_INCREASE_RATIO,                            " +
		"		               a.CY_ASSET_INCREASE_RATIO,                            " +
		"		               a.PY_ASSET_INCREASE_RATIO,                            " +
		"		               a.CP_ASSET_TURN_RATIO,                                " +
		"		               a.PP_ASSET_TURN_RATIO,                                " +
		"		               a.CY_ASSET_TURN_RATIO,                                " +
		"		               a.PY_ASSET_TURN_RATIO                                 " +
		"		      FROM EFIN_EIS_GROWTH  a                                        " +
		"		where a.group_id = " + arg_group_id + "                              " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>