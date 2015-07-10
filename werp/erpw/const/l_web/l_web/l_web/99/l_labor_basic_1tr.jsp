<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("l_labor_basic_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_civil_register_number = dSet.indexOfColumn("civil_register_number");
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
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_key_civil_register_number = dSet.indexOfColumn("key_civil_register_number");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO L_LABOR_BASIC ( dept_code," + 
                    "civil_register_number," + 
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
                    "spec_no_seq," + 
                    "spec_unq_num )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_civil_register_number);
      gpstatement.bindColumn(3, idx_labor_name);
      gpstatement.bindColumn(4, idx_zip_number);
      gpstatement.bindColumn(5, idx_address);
      gpstatement.bindColumn(6, idx_job_code);
      gpstatement.bindColumn(7, idx_civil_number_error_check);
      gpstatement.bindColumn(8, idx_unitcost);
      gpstatement.bindColumn(9, idx_military);
      gpstatement.bindColumn(10, idx_tel_number);
      gpstatement.bindColumn(11, idx_entrance_date);
      gpstatement.bindColumn(12, idx_resign_date);
      gpstatement.bindColumn(13, idx_transcript);
      gpstatement.bindColumn(14, idx_labor_class);
      gpstatement.bindColumn(15, idx_insurance_get_day);
      gpstatement.bindColumn(16, idx_time_amt);
      gpstatement.bindColumn(17, idx_blacklist);
      gpstatement.bindColumn(18, idx_contract_date);
      gpstatement.bindColumn(19, idx_lastapplydate);
      gpstatement.bindColumn(20, idx_cost_tag);
      gpstatement.bindColumn(21, idx_month_amt);
      gpstatement.bindColumn(22, idx_spec_no_seq);
      gpstatement.bindColumn(23, idx_spec_unq_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update l_labor_basic set " + 
                            "dept_code=?,  " + 
                            "civil_register_number=?,  " + 
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
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?  where dept_code=? " +
                            " and civil_register_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_civil_register_number);
      gpstatement.bindColumn(3, idx_labor_name);
      gpstatement.bindColumn(4, idx_zip_number);
      gpstatement.bindColumn(5, idx_address);
      gpstatement.bindColumn(6, idx_job_code);
      gpstatement.bindColumn(7, idx_civil_number_error_check);
      gpstatement.bindColumn(8, idx_unitcost);
      gpstatement.bindColumn(9, idx_military);
      gpstatement.bindColumn(10, idx_tel_number);
      gpstatement.bindColumn(11, idx_entrance_date);
      gpstatement.bindColumn(12, idx_resign_date);
      gpstatement.bindColumn(13, idx_transcript);
      gpstatement.bindColumn(14, idx_labor_class);
      gpstatement.bindColumn(15, idx_insurance_get_day);
      gpstatement.bindColumn(16, idx_time_amt);
      gpstatement.bindColumn(17, idx_blacklist);
      gpstatement.bindColumn(18, idx_contract_date);
      gpstatement.bindColumn(19, idx_lastapplydate);
      gpstatement.bindColumn(20, idx_cost_tag);
      gpstatement.bindColumn(21, idx_month_amt);
      gpstatement.bindColumn(22, idx_spec_no_seq);
      gpstatement.bindColumn(23, idx_spec_unq_num);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(24, idx_dept_code);
      gpstatement.bindColumn(25, idx_key_civil_register_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from l_labor_basic where dept_code=? and civil_register_number=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_civil_register_number);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>