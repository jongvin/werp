<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_license_register_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_license_class_code = dSet.indexOfColumn("license_class_code");
   	int idx_license_kind_code = dSet.indexOfColumn("license_kind_code");
   	int idx_license_no = dSet.indexOfColumn("license_no");
   	int idx_cont_limit_amt = dSet.indexOfColumn("cont_limit_amt");
   	int idx_eng_limit_amt = dSet.indexOfColumn("eng_limit_amt");
   	int idx_const_limit_amt = dSet.indexOfColumn("const_limit_amt");
   	int idx_fund_amt = dSet.indexOfColumn("fund_amt");
   	int idx_finance_qty = dSet.indexOfColumn("finance_qty");
   	int idx_accept_date = dSet.indexOfColumn("accept_date");
   	int idx_renovation_date = dSet.indexOfColumn("renovation_date");
   	int idx_report_limit = dSet.indexOfColumn("report_limit");
   	int idx_license_company = dSet.indexOfColumn("license_company");
   	int idx_equipment_retention = dSet.indexOfColumn("equipment_retention");
   	int idx_office_remark = dSet.indexOfColumn("office_remark");
	int idx_license_basic = dSet.indexOfColumn("license_basic");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_GENERAL_LICENSE_REGISTER ( license_class_code," + 
                    "license_kind_code," + 
                    "license_no," + 
                    "cont_limit_amt," + 
                    "eng_limit_amt," + 
                    "const_limit_amt," + 
                    "fund_amt," + 
                    "finance_qty," + 
                    "accept_date," + 
                    "renovation_date," + 
                    "report_limit," + 
                    "license_company," + 
                    "equipment_retention," + 
                    "office_remark, "+
			        "license_basic)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_class_code);
      gpstatement.bindColumn(2, idx_license_kind_code);
      gpstatement.bindColumn(3, idx_license_no);
      gpstatement.bindColumn(4, idx_cont_limit_amt);
      gpstatement.bindColumn(5, idx_eng_limit_amt);
      gpstatement.bindColumn(6, idx_const_limit_amt);
      gpstatement.bindColumn(7, idx_fund_amt);
      gpstatement.bindColumn(8, idx_finance_qty);
      gpstatement.bindColumn(9, idx_accept_date);
      gpstatement.bindColumn(10, idx_renovation_date);
      gpstatement.bindColumn(11, idx_report_limit);
      gpstatement.bindColumn(12, idx_license_company);
      gpstatement.bindColumn(13, idx_equipment_retention);
      gpstatement.bindColumn(14, idx_office_remark);
	  gpstatement.bindColumn(15, idx_license_basic);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_general_license_register set " + 
                            "license_class_code=?,  " + 
                            "license_kind_code=?,  " + 
                            "license_no=?,  " + 
                            "cont_limit_amt=?,  " + 
                            "eng_limit_amt=?,  " + 
                            "const_limit_amt=?,  " + 
                            "fund_amt=?,  " + 
                            "finance_qty=?,  " + 
                            "accept_date=?,  " + 
                            "renovation_date=?,  " + 
                            "report_limit=?,  " + 
                            "license_company=?,  " + 
                            "equipment_retention=?,  " + 
                            "office_remark=?, "+
							"license_basic=?  where license_class_code=? " +
                            "  and license_kind_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_class_code);
      gpstatement.bindColumn(2, idx_license_kind_code);
      gpstatement.bindColumn(3, idx_license_no);
      gpstatement.bindColumn(4, idx_cont_limit_amt);
      gpstatement.bindColumn(5, idx_eng_limit_amt);
      gpstatement.bindColumn(6, idx_const_limit_amt);
      gpstatement.bindColumn(7, idx_fund_amt);
      gpstatement.bindColumn(8, idx_finance_qty);
      gpstatement.bindColumn(9, idx_accept_date);
      gpstatement.bindColumn(10, idx_renovation_date);
      gpstatement.bindColumn(11, idx_report_limit);
      gpstatement.bindColumn(12, idx_license_company);
      gpstatement.bindColumn(13, idx_equipment_retention);
      gpstatement.bindColumn(14, idx_office_remark);
	  gpstatement.bindColumn(15, idx_license_basic);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_license_class_code);
      gpstatement.bindColumn(17, idx_license_kind_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_general_license_register where license_class_code=? " + 
                            "  and license_kind_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_license_class_code);
      gpstatement.bindColumn(2, idx_license_kind_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>