<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("l_labor_daily_work_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_civil_register_number = dSet.indexOfColumn("civil_register_number");
   	int idx_key_civil_register_number = dSet.indexOfColumn("key_civil_register_number");
   	int idx_work_date = dSet.indexOfColumn("work_date");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_dailywork = dSet.indexOfColumn("dailywork");
   	int idx_unitcost = dSet.indexOfColumn("unitcost");
   	int idx_inv_section = dSet.indexOfColumn("inv_section");
   	int idx_jibul_tag = dSet.indexOfColumn("jibul_tag");
   	int idx_jibul_date = dSet.indexOfColumn("jibul_date");
   	int idx_pay_amt = dSet.indexOfColumn("pay_amt");
   	int idx_income_tax = dSet.indexOfColumn("income_tax");
   	int idx_civil_tax = dSet.indexOfColumn("civil_tax");
   	int idx_item_code = dSet.indexOfColumn("item_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO L_LABOR_DAILYWORK ( dept_code," + 
                    "civil_register_number," + 
                    "work_date," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "dailywork," + 
                    "unitcost," + 
                    "inv_section," + 
                    "jibul_tag," + 
                    "jibul_date," + 
                    "pay_amt," + 
                    "income_tax," + 
                    "civil_tax, "+
						  "item_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ,:14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_civil_register_number);
      gpstatement.bindColumn(3, idx_work_date);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_spec_unq_num);
      gpstatement.bindColumn(6, idx_dailywork);
      gpstatement.bindColumn(7, idx_unitcost);
      gpstatement.bindColumn(8, idx_inv_section);
      gpstatement.bindColumn(9, idx_jibul_tag);
      gpstatement.bindColumn(10, idx_jibul_date);
      gpstatement.bindColumn(11, idx_pay_amt);
      gpstatement.bindColumn(12, idx_income_tax);
      gpstatement.bindColumn(13, idx_civil_tax);
      gpstatement.bindColumn(14, idx_item_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update l_labor_dailywork set " + 
                            "dept_code=?,  " + 
                            "civil_register_number=?,  " + 
                            "work_date=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "dailywork=?,  " + 
                            "unitcost=?,  " + 
                            "inv_section=?,  " + 
                            "jibul_tag=?,  " + 
                            "jibul_date=?,  " + 
                            "pay_amt=?,  " + 
                            "income_tax=?,  " + 
                            "civil_tax=?, " + 
									 "item_code=? "+ 
									 "where dept_code=? " +
                            "and civil_register_number=?  " + 
                            "and work_date=?  " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_civil_register_number);
      gpstatement.bindColumn(3, idx_work_date);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_spec_unq_num);
      gpstatement.bindColumn(6, idx_dailywork);
      gpstatement.bindColumn(7, idx_unitcost);
      gpstatement.bindColumn(8, idx_inv_section);
      gpstatement.bindColumn(9, idx_jibul_tag);
      gpstatement.bindColumn(10, idx_jibul_date);
      gpstatement.bindColumn(11, idx_pay_amt);
      gpstatement.bindColumn(12, idx_income_tax);
      gpstatement.bindColumn(13, idx_civil_tax);
      gpstatement.bindColumn(14, idx_item_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_key_civil_register_number);
      gpstatement.bindColumn(17, idx_work_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from l_labor_dailywork where dept_code=? " +
                            "and civil_register_number=?  " + 
                            "and work_date=?  " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_civil_register_number);
      gpstatement.bindColumn(3, idx_work_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>