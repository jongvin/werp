<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("proj_prog_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("splan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("p_1",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_2",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_3",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_4",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_5",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_6",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_7",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_8",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_9",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_10",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_11",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_12",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_13",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_14",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_15",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_16",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_17",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_18",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_19",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_20",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_21",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_22",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_23",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_24",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_25",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_26",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_27",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_28",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_29",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_30",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_31",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_32",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_33",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_34",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_35",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_36",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_37",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_38",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_39",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_40",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_41",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_42",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_43",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_44",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_45",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_46",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_47",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("p_48",GauceDataColumn.TB_DECIMAL,5,0));
    String query = "  SELECT  to_char(a.work_year,'yyyy.mm.dd') work_year ," + 
				       "          a.spec_no_seq ," + 
				       "          a.no_seq ," + 
				       "          a.proj_prog_type ," + 
				       "          a.proj_name ," + 
				       "          to_char(a.splan_date,'yyyy.mm.dd') splan_date ," + 
				       "          a.p_1 ," + 
					    "          a.p_2 ," + 
					    "          a.p_3 ," + 
					    "          a.p_4 ," + 
					    "          a.p_5 ," + 
					    "          a.p_6 ," + 
					    "          a.p_7 ," + 
					    "          a.p_8 ," + 
					    "          a.p_9 ," + 
					    "          a.p_10 ," + 
					    "          a.p_11 ," + 
					    "          a.p_12 ," + 
					    "          a.p_13 ," + 
					    "          a.p_14 ," + 
					    "          a.p_15 ," + 
					    "          a.p_16 ," + 
					    "          a.p_17 ," + 
					    "          a.p_18 ," + 
					    "          a.p_19 ," + 
					    "          a.p_20 ," + 
					    "          a.p_21 ," + 
					    "          a.p_22 ," + 
					    "          a.p_23 ," + 
					    "          a.p_24 ," + 
					    "          a.p_25 ," + 
					    "          a.p_26 ," + 
					    "          a.p_27 ," + 
					    "          a.p_28 ," + 
					    "          a.p_29 ," + 
					    "          a.p_30 ," + 
					    "          a.p_31 ," + 
					    "          a.p_32 ," + 
					    "          a.p_33 ," + 
					    "          a.p_34 ," + 
					    "          a.p_35 ," + 
					    "          a.p_36 ," + 
					    "          a.p_37 ," + 
					    "          a.p_38 ," + 
					    "          a.p_39 ," + 
					    "          a.p_40 ," + 
					    "          a.p_41 ," + 
					    "          a.p_42 ," + 
					    "          a.p_43 ," + 
					    "          a.p_44 ," + 
					    "          a.p_45 ," + 
					    "          a.p_46 ," + 
					    "          a.p_47 ," + 
					    "          a.p_48  " +
				       "     FROM g_mis_person a     " +
				       "    where to_char(a.work_year,'yyyy') = to_char(to_date('"+arg_work_year+"'),'yyyy') " +
				       " order by  a.no_seq  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>