<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_ins_person_basic_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_join_dt = dSet.indexOfColumn("join_dt");
   	int idx_charge_business = dSet.indexOfColumn("charge_business");
   	int idx_work_range = dSet.indexOfColumn("work_range");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_effect_dt = dSet.indexOfColumn("effect_dt");
   	int idx_approve_item = dSet.indexOfColumn("approve_item");
   	int idx_position = dSet.indexOfColumn("position");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_ins_person ( emp_no," + 
                    "name," + 
                    "dept_code," + 
                    "join_dt," + 
                    "charge_business," + 
                    "work_range," + 
                    "approve_dt," + 
                    "effect_dt," + 
                    "approve_item," + 
                    "position," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_join_dt);
      gpstatement.bindColumn(5, idx_charge_business);
      gpstatement.bindColumn(6, idx_work_range);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_effect_dt);
      gpstatement.bindColumn(9, idx_approve_item);
      gpstatement.bindColumn(10, idx_position);
      gpstatement.bindColumn(11, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_ins_person set " + 
                            "emp_no=?,  " + 
                            "name=?,  " + 
                            "dept_code=?,  " + 
                            "join_dt=?,  " + 
                            "charge_business=?,  " + 
                            "work_range=?,  " + 
                            "approve_dt=?,  " + 
                            "effect_dt=?,  " + 
                            "approve_item=?,  " + 
                            "position=?,  " + 
                            "remark=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_join_dt);
      gpstatement.bindColumn(5, idx_charge_business);
      gpstatement.bindColumn(6, idx_work_range);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_effect_dt);
      gpstatement.bindColumn(9, idx_approve_item);
      gpstatement.bindColumn(10, idx_position);
      gpstatement.bindColumn(11, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_ins_person where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>