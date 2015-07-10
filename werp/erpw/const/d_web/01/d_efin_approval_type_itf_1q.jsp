<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_approval_id = req.getParameter("arg_approval_id");
     String arg_approval_type = req.getParameter("arg_approval_type");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("approval_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_type_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("approval_id_last",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_id_1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_1",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_2",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_2",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_3",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_3",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_3",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_3",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_3",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_4",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_4",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_4",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_4",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_4",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_5",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_5",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_5",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_5",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_5",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_6",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_6",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_6",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_6",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_6",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_7",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_7",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_7",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_7",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_7",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_8",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_8",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_8",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_8",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_8",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_9",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_9",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_9",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_9",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_9",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_10",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_10",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_10",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_10",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_10",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_id_11",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_jik_11",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approval_name_11",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_date_11",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approval_status_11",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.approval_id,   " + 
     "         a.approval_type,   " + 
     "         a.approval_type_name,   " + 
     "         a.approval_id_last,   " + 
     "         a.approval_id_1,   " + 
     "         a.approval_jik_1,   " + 
     "         a.approval_name_1,   " + 
     "         to_char(a.approval_date_1,'yyyy.mm.dd')  approval_date_1,  " + 
     "         a.approval_status_1,   " + 
     "         a.approval_id_2,   " + 
     "         a.approval_jik_2,   " + 
     "         a.approval_name_2,   " + 
     "         to_char(a.approval_date_2,'yyyy.mm.dd')  approval_date_2,  " + 
     "         a.approval_status_2,   " + 
     "         a.approval_id_3,   " + 
     "         a.approval_jik_3,   " + 
     "         a.approval_name_3,   " + 
     "         to_char(a.approval_date_3,'yyyy.mm.dd')  approval_date_3,  " + 
     "         a.approval_status_3,   " + 
     "         a.approval_id_4,   " + 
     "         a.approval_jik_4,   " + 
     "         a.approval_name_4,   " + 
     "         to_char(a.approval_date_4,'yyyy.mm.dd')  approval_date_4,  " + 
     "         a.approval_status_4,   " + 
     "         a.approval_id_5,   " + 
     "         a.approval_jik_5,   " + 
     "         a.approval_name_5,   " + 
     "         to_char(a.approval_date_5,'yyyy.mm.dd')  approval_date_5,  " + 
     "         a.approval_status_5,   " + 
     "         a.approval_id_6,   " + 
     "         a.approval_jik_6,   " + 
     "         a.approval_name_6,   " + 
     "         to_char(a.approval_date_6,'yyyy.mm.dd')  approval_date_6,  " + 
     "         a.approval_status_6,   " + 
     "         a.approval_id_7,   " + 
     "         a.approval_jik_7,   " + 
     "         a.approval_name_7,   " + 
     "         to_char(a.approval_date_7,'yyyy.mm.dd')  approval_date_7,  " + 
     "         a.approval_status_7,   " + 
     "         a.approval_id_8,   " + 
     "         a.approval_jik_8,   " + 
     "         a.approval_name_8,   " + 
     "         to_char(a.approval_date_8,'yyyy.mm.dd')  approval_date_8,  " + 
     "         a.approval_status_8,   " + 
     "         a.approval_id_9,   " + 
     "         a.approval_jik_9,   " + 
     "         a.approval_name_9,   " + 
     "         to_char(a.approval_date_9,'yyyy.mm.dd')  approval_date_9,  " + 
     "         a.approval_status_9,   " + 
     "         a.approval_id_10,   " + 
     "         a.approval_jik_10,   " + 
     "         a.approval_name_10,   " + 
     "         to_char(a.approval_date_10,'yyyy.mm.dd')  approval_date_10,  " + 
     "         a.approval_status_10,   " + 
     "         a.approval_id_11,   " + 
     "         a.approval_jik_11,   " + 
     "         a.approval_name_11,   " + 
     "         to_char(a.approval_date_11,'yyyy.mm.dd')  approval_date_11,  " + 
     "         a.approval_status_11  " + 
     "    FROM efin_approval_type_itf   a" + 
     "    WHERE a.approval_id = '" + arg_approval_id + "'      " + 
     "      and a.approval_type = '" + arg_approval_type + "'      " + 
     "    ORDER BY a.approval_type ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>