<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_user_id = req.getParameter("arg_user_id");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("invoice_group_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approval_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("complete_flag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("interface_flag",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("current_approval_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("account_dept_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("secretary_dept_code",GauceDataColumn.TB_STRING,20));
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
     dSet.addDataColumn(new GauceDataColumn("creation_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("created_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("created_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("created_dept_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("last_update_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_update_login",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("last_updated_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("attribute1",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute2",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute3",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute4",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute5",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute6",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute7",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute8",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute9",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("attribute10",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approval_num",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("source",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("batch_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("invoice_amount",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.invoice_group_id,   " + 
     "         a.approval_name,   " + 
     "         a.complete_flag,   " + 
     "         a.interface_flag,   " + 
     "         a.current_approval_id,   " + 
     "         a.account_dept_code,   " + 
     "         a.secretary_dept_code,   " + 
     "         a.approval_id_last,   " + 
     "         a.approval_id_1,   " + 
     "         a.approval_jik_1,   " + 
     "         a.approval_name_1,   " + 
     "         to_char(a.approval_date_1,'yy.mm.dd') approval_date_1,   " + 
     "         a.approval_status_1,   " + 
     "         a.approval_id_2,   " + 
     "         a.approval_jik_2,   " + 
     "         a.approval_name_2,   " + 
     "         to_char(a.approval_date_2,'yy.mm.dd') approval_date_2,   " + 
     "         a.approval_status_2,   " + 
     "         a.approval_id_3,   " + 
     "         a.approval_jik_3,   " + 
     "         a.approval_name_3,   " + 
     "         to_char(a.approval_date_3,'yy.mm.dd') approval_date_3,   " + 
     "         a.approval_status_3,   " + 
     "         a.approval_id_4,   " + 
     "         a.approval_jik_4,   " + 
     "         a.approval_name_4,   " + 
     "         to_char(a.approval_date_4,'yy.mm.dd') approval_date_4,   " + 
     "         a.approval_status_4,   " + 
     "         a.approval_id_5,   " + 
     "         a.approval_jik_5,   " + 
     "         a.approval_name_5,   " + 
     "         to_char(a.approval_date_5,'yy.mm.dd') approval_date_5,   " + 
     "         a.approval_status_5,   " + 
     "         a.approval_id_6,   " + 
     "         a.approval_jik_6,   " + 
     "         a.approval_name_6,   " + 
     "         to_char(a.approval_date_6,'yy.mm.dd') approval_date_6,   " + 
     "         a.approval_status_6,   " + 
     "         a.approval_id_7,   " + 
     "         a.approval_jik_7,   " + 
     "         a.approval_name_7,   " + 
     "         to_char(a.approval_date_7,'yy.mm.dd') approval_date_7,   " + 
     "         a.approval_status_7,   " + 
     "         a.approval_id_8,   " + 
     "         a.approval_jik_8,   " + 
     "         a.approval_name_8,   " + 
     "         to_char(a.approval_date_8,'yy.mm.dd') approval_date_8,   " + 
     "         a.approval_status_8,   " + 
     "         a.approval_id_9,   " + 
     "         a.approval_jik_9,   " + 
     "         a.approval_name_9,   " + 
     "         to_char(a.approval_date_9,'yy.mm.dd') approval_date_9,   " + 
     "         a.approval_status_9,   " + 
     "         a.approval_id_10,   " + 
     "         a.approval_jik_10,   " + 
     "         a.approval_name_10,   " + 
     "         to_char(a.approval_date_10,'yy.mm.dd') approval_date_10,   " + 
     "         a.approval_status_10,   " + 
     "         a.approval_id_11,   " + 
     "         a.approval_jik_11,   " + 
     "         a.approval_name_11,   " + 
     "         to_char(a.approval_date_11,'yy.mm.dd') approval_date_11,   " + 
     "         a.approval_status_11,   " + 
     "         to_char(a.creation_date,'yyyy.mm.dd') creation_date,   " + 
     "         a.created_by,   " + 
     "         to_char(a.last_update_date,'yyyy.mm.dd') last_update_date,   " + 
     "         a.created_dept_code,   " + 
     "         a.created_dept_name,   " + 
     "         a.last_update_login,   " + 
     "         a.last_updated_by,   " + 
     "         a.attribute1,   " + 
     "         a.attribute2,   " + 
     "         a.attribute3,   " + 
     "         a.attribute4,   " + 
     "         a.attribute5,   " + 
     "         a.attribute6,   " + 
     "         a.attribute7,   " + 
     "         a.attribute8,   " + 
     "         a.attribute9,   " + 
     "         a.attribute10,  " + 
     "         a.approval_num,  " + 
     "         a.source,  " + 
     "         to_char(a.batch_date,'yyyy.mm.dd') batch_date,  " + 
     "         'F' chk, " + 
     "         b.invoice_amount  " + 
     "    FROM efin_invoice_header_itf   a," + 
     "         efin_invoice_header_itf_v   b" + 
     "   WHERE a.invoice_group_id =  b.invoice_group_id " + 
     "     and a.current_approval_id = '" + arg_user_id + "' " + 
     "     and a.batch_date >= '" + arg_from_date + "' " + 
     "     and a.batch_date <= '" + arg_to_date + "' " + 
     "   ORDER BY  a.created_dept_name,a.batch_date desc,a.invoice_group_id " + 
     "                 ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>