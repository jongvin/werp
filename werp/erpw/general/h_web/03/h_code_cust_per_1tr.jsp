<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_cust_per_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_cust_div = dSet.indexOfColumn("cust_div");
   	int idx_represent = dSet.indexOfColumn("represent");
   	int idx_biz_status = dSet.indexOfColumn("biz_status");
   	int idx_biz_type = dSet.indexOfColumn("biz_type");
   	int idx_home_phone = dSet.indexOfColumn("home_phone");
   	int idx_office_phone = dSet.indexOfColumn("office_phone");
   	int idx_cell_phone = dSet.indexOfColumn("cell_phone");
   	int idx_e_mail = dSet.indexOfColumn("e_mail");
   	int idx_dm_demand = dSet.indexOfColumn("dm_demand");
   	int idx_cur_zip_code = dSet.indexOfColumn("cur_zip_code");
   	int idx_cur_addr1 = dSet.indexOfColumn("cur_addr1");
   	int idx_cur_addr2 = dSet.indexOfColumn("cur_addr2");
   	int idx_receipt_name = dSet.indexOfColumn("receipt_name");
   	int idx_receipt_phone = dSet.indexOfColumn("receipt_phone");
   	int idx_receipt_zip_code = dSet.indexOfColumn("receipt_zip_code");
   	int idx_receipt_addr1 = dSet.indexOfColumn("receipt_addr1");
   	int idx_receipt_addr2 = dSet.indexOfColumn("receipt_addr2");
   	int idx_match_jumin_no = dSet.indexOfColumn("match_jumin_no");
   	int idx_match_name = dSet.indexOfColumn("match_name");
   	int idx_match_phone = dSet.indexOfColumn("match_phone");
		int idx_sms_yn = dSet.indexOfColumn("sms_yn");
	int idx_cust_div2 = dSet.indexOfColumn("cust_div2");
	int idx_comp_no = dSet.indexOfColumn("comp_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_code_cust ( cust_code," + 
                    "cust_name," + 
                    "cust_div," + 
                    "represent," + 
                    "biz_status," + 
                    "biz_type," + 
                    "home_phone," + 
                    "office_phone," + 
                    "cell_phone," + 
                    "e_mail," + 
                    "dm_demand," + 
                    "cur_zip_code," + 
                    "cur_addr1," + 
                    "cur_addr2," + 
                    "receipt_name," + 
                    "receipt_phone," + 
                    "receipt_zip_code," + 
                    "receipt_addr1," + 
                    "receipt_addr2," + 
                    "match_jumin_no," + 
                    "match_name," + 
                    "match_phone,"+
			           "sms_yn,"+
			           "cust_div2, "+
			           "comp_no )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_cust_code);
      gpstatement.bindColumn(2, idx_cust_name);
      gpstatement.bindColumn(3, idx_cust_div);
      gpstatement.bindColumn(4, idx_represent);
      gpstatement.bindColumn(5, idx_biz_status);
      gpstatement.bindColumn(6, idx_biz_type);
      gpstatement.bindColumn(7, idx_home_phone);
      gpstatement.bindColumn(8, idx_office_phone);
      gpstatement.bindColumn(9, idx_cell_phone);
      gpstatement.bindColumn(10, idx_e_mail);
      gpstatement.bindColumn(11, idx_dm_demand);
      gpstatement.bindColumn(12, idx_cur_zip_code);
      gpstatement.bindColumn(13, idx_cur_addr1);
      gpstatement.bindColumn(14, idx_cur_addr2);
      gpstatement.bindColumn(15, idx_receipt_name);
      gpstatement.bindColumn(16, idx_receipt_phone);
      gpstatement.bindColumn(17, idx_receipt_zip_code);
      gpstatement.bindColumn(18, idx_receipt_addr1);
      gpstatement.bindColumn(19, idx_receipt_addr2);
      gpstatement.bindColumn(20, idx_match_jumin_no);
      gpstatement.bindColumn(21, idx_match_name);
      gpstatement.bindColumn(22, idx_match_phone);
		gpstatement.bindColumn(23, idx_sms_yn);
	   gpstatement.bindColumn(24, idx_cust_div2);
		gpstatement.bindColumn(25, idx_comp_no);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_code_cust set " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "cust_div=?,  " + 
                            "represent=?,  " + 
                            "biz_status=?,  " + 
                            "biz_type=?,  " + 
                            "home_phone=?,  " + 
                            "office_phone=?,  " + 
                            "cell_phone=?,  " + 
                            "e_mail=?,  " + 
                            "dm_demand=?,  " + 
                            "cur_zip_code=?,  " + 
                            "cur_addr1=?,  " + 
                            "cur_addr2=?,  " + 
                            "receipt_name=?,  " + 
                            "receipt_phone=?,  " + 
                            "receipt_zip_code=?,  " + 
                            "receipt_addr1=?,  " + 
                            "receipt_addr2=?,  " + 
                            "match_jumin_no=?,  " + 
                            "match_name=?,  " + 
                            "match_phone=?, "+
	                        "sms_yn=?, "+
	                         "cust_div2=?, "+
	                         "comp_no=? where cust_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_cust_code);
      gpstatement.bindColumn(2, idx_cust_name);
      gpstatement.bindColumn(3, idx_cust_div);
      gpstatement.bindColumn(4, idx_represent);
      gpstatement.bindColumn(5, idx_biz_status);
      gpstatement.bindColumn(6, idx_biz_type);
      gpstatement.bindColumn(7, idx_home_phone);
      gpstatement.bindColumn(8, idx_office_phone);
      gpstatement.bindColumn(9, idx_cell_phone);
      gpstatement.bindColumn(10, idx_e_mail);
      gpstatement.bindColumn(11, idx_dm_demand);
      gpstatement.bindColumn(12, idx_cur_zip_code);
      gpstatement.bindColumn(13, idx_cur_addr1);
      gpstatement.bindColumn(14, idx_cur_addr2);
      gpstatement.bindColumn(15, idx_receipt_name);
      gpstatement.bindColumn(16, idx_receipt_phone);
      gpstatement.bindColumn(17, idx_receipt_zip_code);
      gpstatement.bindColumn(18, idx_receipt_addr1);
      gpstatement.bindColumn(19, idx_receipt_addr2);
      gpstatement.bindColumn(20, idx_match_jumin_no);
      gpstatement.bindColumn(21, idx_match_name);
      gpstatement.bindColumn(22, idx_match_phone);
		gpstatement.bindColumn(23, idx_sms_yn);
	  gpstatement.bindColumn(24, idx_cust_div2);
	  gpstatement.bindColumn(25, idx_comp_no);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(26, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_code_cust where cust_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>