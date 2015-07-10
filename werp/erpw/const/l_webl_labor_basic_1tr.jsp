<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("l_labor_basic_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_spec_no = dSet.indexOfColumn("spec_no");
   	int idx_foreigner_chk = dSet.indexOfColumn("foreigner_chk");
   	int idx_civil_register_number = dSet.indexOfColumn("civil_register_number");
   	int idx_passport_no = dSet.indexOfColumn("passport_no");
   	int idx_labor_name = dSet.indexOfColumn("labor_name");
   	int idx_zip_number = dSet.indexOfColumn("zip_number");
   	int idx_address = dSet.indexOfColumn("address");
   	int idx_job_code = dSet.indexOfColumn("job_code");
   	int idx_civil_number_error_check = dSet.indexOfColumn("civil_number_error_check");
   	int idx_unitcost = dSet.indexOfColumn("unitcost");
   	int idx_military = dSet.indexOfColumn("military");
   	int idx_tel_number = dSet.indexOfColumn("tel_number");
   	int idx_entrance_date = dSet.indexOfColumn("entrance_date");
   	int idx_resign_date = dSet.indexOfColumn("resign_date");
   	int idx_transcript = dSet.indexOfColumn("transcript");
   	int idx_labor_class = dSet.indexOfColumn("labor_class");
   	int idx_insurance_get_day = dSet.indexOfColumn("insurance_get_day");
   	int idx_time_amt = dSet.indexOfColumn("time_amt");
   	int idx_blacklist = dSet.indexOfColumn("blacklist");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_lastapplydate = dSet.indexOfColumn("lastapplydate");
   	int idx_cost_tag = dSet.indexOfColumn("cost_tag");
   	int idx_month_amt = dSet.indexOfColumn("month_amt");
   	int idx_account_no = dSet.indexOfColumn("account_no");
   	int idx_depositor = dSet.indexOfColumn("depositor");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO L_LABOR_BASIC ( dept_code," + 
                    "spec_no," + 
                    "foreigner_chk," + 
                    "civil_register_number," + 
                    "passport_no," + 
                    "labor_name," + 
                    "zip_number," + 
                    "address," + 
                    "job_code," + 
                    "civil_number_error_check," + 
                    "unitcost," + 
                    "military," + 
                    "tel_number," + 
                    "entrance_date," + 
                    "resign_date," + 
                    "transcript," + 
                    "labor_class," + 
                    "insurance_get_day," + 
                    "time_amt," + 
                    "blacklist," + 
                    "contract_date," + 
                    "lastapplydate," + 
                    "cost_tag," + 
                    "month_amt," + 
                    "account_no," + 
                    "depositor )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_spec_no);
      gpstatement.bindColumn(3, idx_foreigner_chk);
      gpstatement.bindColumn(4, idx_civil_register_number);
      gpstatement.bindColumn(5, idx_passport_no);
      gpstatement.bindColumn(6, idx_labor_name);
      gpstatement.bindColumn(7, idx_zip_number);
      gpstatement.bindColumn(8, idx_address);
      gpstatement.bindColumn(9, idx_job_code);
      gpstatement.bindColumn(10, idx_civil_number_error_check);
      gpstatement.bindColumn(11, idx_unitcost);
      gpstatement.bindColumn(12, idx_military);
      gpstatement.bindColumn(13, idx_tel_number);
      gpstatement.bindColumn(14, idx_entrance_date);
      gpstatement.bindColumn(15, idx_resign_date);
      gpstatement.bindColumn(16, idx_transcript);
      gpstatement.bindColumn(17, idx_labor_class);
      gpstatement.bindColumn(18, idx_insurance_get_day);
      gpstatement.bindColumn(19, idx_time_amt);
      gpstatement.bindColumn(20, idx_blacklist);
      gpstatement.bindColumn(21, idx_contract_date);
      gpstatement.bindColumn(22, idx_lastapplydate);
      gpstatement.bindColumn(23, idx_cost_tag);
      gpstatement.bindColumn(24, idx_month_amt);
      gpstatement.bindColumn(25, idx_account_no);
      gpstatement.bindColumn(26, idx_depositor);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update l_labor_basic set " + 
                            "dept_code=?,  " + 
                            "spec_no=?,  " + 
                            "foreigner_chk=?,  " + 
                            "civil_register_number=?,  " + 
                            "passport_no=?,  " + 
                            "labor_name=?,  " + 
                            "zip_number=?,  " + 
                            "address=?,  " + 
                            "job_code=?,  " + 
                            "civil_number_error_check=?,  " + 
                            "unitcost=?,  " + 
                            "military=?,  " + 
                            "tel_number=?,  " + 
                            "entrance_date=?,  " + 
                            "resign_date=?,  " + 
                            "transcript=?,  " + 
                            "labor_class=?,  " + 
                            "insurance_get_day=?,  " + 
                            "time_amt=?,  " + 
                            "blacklist=?,  " + 
                            "contract_date=?,  " + 
                            "lastapplydate=?,  " + 
                            "cost_tag=?,  " + 
                            "month_amt=?,  " + 
                            "account_no=?,  " + 
                            "depositor=?  where dept_code=? and spec_no=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_spec_no);
      gpstatement.bindColumn(3, idx_foreigner_chk);
      gpstatement.bindColumn(4, idx_civil_register_number);
      gpstatement.bindColumn(5, idx_passport_no);
      gpstatement.bindColumn(6, idx_labor_name);
      gpstatement.bindColumn(7, idx_zip_number);
      gpstatement.bindColumn(8, idx_address);
      gpstatement.bindColumn(9, idx_job_code);
      gpstatement.bindColumn(10, idx_civil_number_error_check);
      gpstatement.bindColumn(11, idx_unitcost);
      gpstatement.bindColumn(12, idx_military);
      gpstatement.bindColumn(13, idx_tel_number);
      gpstatement.bindColumn(14, idx_entrance_date);
      gpstatement.bindColumn(15, idx_resign_date);
      gpstatement.bindColumn(16, idx_transcript);
      gpstatement.bindColumn(17, idx_labor_class);
      gpstatement.bindColumn(18, idx_insurance_get_day);
      gpstatement.bindColumn(19, idx_time_amt);
      gpstatement.bindColumn(20, idx_blacklist);
      gpstatement.bindColumn(21, idx_contract_date);
      gpstatement.bindColumn(22, idx_lastapplydate);
      gpstatement.bindColumn(23, idx_cost_tag);
      gpstatement.bindColumn(24, idx_month_amt);
      gpstatement.bindColumn(25, idx_account_no);
      gpstatement.bindColumn(26, idx_depositor);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(27, idx_dept_code);
      gpstatement.bindColumn(28, idx_spec_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from l_labor_basic where dept_code=? and spec_no=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_spec_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>