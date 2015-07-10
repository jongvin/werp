<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_code_order_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_key_order_no = dSet.indexOfColumn("key_order_no");
   	int idx_customer_tag = dSet.indexOfColumn("customer_tag");
   	int idx_order_name = dSet.indexOfColumn("order_name");
   	int idx_customer_no = dSet.indexOfColumn("customer_no");
   	int idx_corp_no = dSet.indexOfColumn("corp_no");
   	int idx_order_name_long = dSet.indexOfColumn("order_name_long");
   	int idx_order_name_eng = dSet.indexOfColumn("order_name_eng");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_category = dSet.indexOfColumn("category");
   	int idx_condition = dSet.indexOfColumn("condition");
   	int idx_order_class = dSet.indexOfColumn("order_class");
   	int idx_tel = dSet.indexOfColumn("tel");
   	int idx_fax = dSet.indexOfColumn("fax");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr1 = dSet.indexOfColumn("addr1");
   	int idx_addr2 = dSet.indexOfColumn("addr2");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_CODE_ORDER ( order_no," + 
                    "customer_tag," + 
                    "order_name," + 
                    "customer_no," + 
                    "corp_no," + 
                    "order_name_long," + 
                    "order_name_eng," + 
                    "owner," + 
                    "category," + 
                    "condition," + 
                    "order_class," + 
                    "tel," + 
                    "fax," + 
                    "zip_code," + 
                    "addr1," + 
                    "addr2," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_no);
      gpstatement.bindColumn(2, idx_customer_tag);
      gpstatement.bindColumn(3, idx_order_name);
      gpstatement.bindColumn(4, idx_customer_no);
      gpstatement.bindColumn(5, idx_corp_no);
      gpstatement.bindColumn(6, idx_order_name_long);
      gpstatement.bindColumn(7, idx_order_name_eng);
      gpstatement.bindColumn(8, idx_owner);
      gpstatement.bindColumn(9, idx_category);
      gpstatement.bindColumn(10, idx_condition);
      gpstatement.bindColumn(11, idx_order_class);
      gpstatement.bindColumn(12, idx_tel);
      gpstatement.bindColumn(13, idx_fax);
      gpstatement.bindColumn(14, idx_zip_code);
      gpstatement.bindColumn(15, idx_addr1);
      gpstatement.bindColumn(16, idx_addr2);
      gpstatement.bindColumn(17, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_code_order set " + 
                            "order_no=?,  " + 
                            "customer_tag=?,  " + 
                            "order_name=?,  " + 
                            "customer_no=?,  " + 
                            "corp_no=?,  " + 
                            "order_name_long=?,  " + 
                            "order_name_eng=?,  " + 
                            "owner=?,  " + 
                            "category=?,  " + 
                            "condition=?,  " + 
                            "order_class=?,  " + 
                            "tel=?,  " + 
                            "fax=?,  " + 
                            "zip_code=?,  " + 
                            "addr1=?,  " + 
                            "addr2=?,  " + 
                            "remark=?  where order_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_no);
      gpstatement.bindColumn(2, idx_customer_tag);
      gpstatement.bindColumn(3, idx_order_name);
      gpstatement.bindColumn(4, idx_customer_no);
      gpstatement.bindColumn(5, idx_corp_no);
      gpstatement.bindColumn(6, idx_order_name_long);
      gpstatement.bindColumn(7, idx_order_name_eng);
      gpstatement.bindColumn(8, idx_owner);
      gpstatement.bindColumn(9, idx_category);
      gpstatement.bindColumn(10, idx_condition);
      gpstatement.bindColumn(11, idx_order_class);
      gpstatement.bindColumn(12, idx_tel);
      gpstatement.bindColumn(13, idx_fax);
      gpstatement.bindColumn(14, idx_zip_code);
      gpstatement.bindColumn(15, idx_addr1);
      gpstatement.bindColumn(16, idx_addr2);
      gpstatement.bindColumn(17, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_key_order_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_code_order where order_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_order_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>