<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("proj_bus_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_prog_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("bus_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bus_gen_mng",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bus_ent_gain",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bus_hos_gen",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bus_hos_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("py_price_sale",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("py_price_const",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sta_const_tot_m2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sta_sale_m2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("con_sale_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("con_const_mon",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_risk",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("sale_rate_d1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_rate_d3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_rate_now",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_sale_hos",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("con_sale_yymm_disp",GauceDataColumn.TB_STRING,7));
    String query = "  SELECT  to_char(a.work_yymm,'yyyy.mm.dd') work_yymm ," + 
				       "          a.proj_bus_type ," + 
				       "          a.proj_prog_type ," + 
				       "          a.proj_unq_key ," + 
				       "          a.proj_name ," + 
				       "          a.bus_sell_amt ," + 
				       "          a.bus_gen_mng ," + 
				       "          a.bus_ent_gain ," + 
				       "          a.bus_hos_gen ," + 
				       "          a.bus_hos_tot ," + 
				       "          a.py_price_sale ," + 
				       "          a.py_price_const ," + 
				       "          a.sta_const_tot_m2 ," + 
				       "          a.sta_sale_m2 ," + 
				       "          to_char(a.con_sale_yymm,'yyyy.mm.dd') con_sale_yymm ," + 
				       "          a.con_const_mon ," + 
				       "          a.proj_risk ," + 
				       "          a.sale_rate_d1 ," + 
				       "          a.sale_rate_d3 ," + 
				       "          a.sale_rate_now ," + 
				       "          a.no_sale_hos ," + 
				       "          a.proj_remark,  " + 
				       "          a.no_seq,  " + 
				       "          to_char(a.con_sale_yymm,'yyyy.mm') con_sale_yymm_disp" + 
				       "		 FROM g_mis_decision_sp    a    " + 
				       "     where to_char(a.work_yymm,'yyyy.mm') = to_char(to_date('" + arg_work_yymm + "'),'yyyy.mm') " +
				       " order by a.proj_bus_type asc ," + 
				       "          a.proj_prog_type desc ," + 
				       "          a.no_seq,a.proj_name asc	" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>