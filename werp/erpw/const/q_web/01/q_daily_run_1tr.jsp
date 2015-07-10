<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("q_daily_run_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_run_date = dSet.indexOfColumn("run_date");
   	int idx_equp_code = dSet.indexOfColumn("equp_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_run_time = dSet.indexOfColumn("run_time");
   	int idx_suspension_time = dSet.indexOfColumn("suspension_time");
   	int idx_extra_time = dSet.indexOfColumn("extra_time");
   	int idx_settle_time = dSet.indexOfColumn("settle_time");
   	int idx_unitcost = dSet.indexOfColumn("unitcost");
   	int idx_settle_amt = dSet.indexOfColumn("settle_amt");
   	int idx_inv_tag = dSet.indexOfColumn("inv_tag");
   	int idx_fuel_qty = dSet.indexOfColumn("fuel_qty");
   	int idx_fuel_amt = dSet.indexOfColumn("fuel_amt");
   	int idx_oil_qty = dSet.indexOfColumn("oil_qty");
   	int idx_oil_amt = dSet.indexOfColumn("oil_amt");
   	int idx_repair_remark = dSet.indexOfColumn("repair_remark");
   	int idx_repair_amt = dSet.indexOfColumn("repair_amt");
   	int idx_move_remark = dSet.indexOfColumn("move_remark");
   	int idx_move_amt = dSet.indexOfColumn("move_amt");
   	int idx_run_remark = dSet.indexOfColumn("run_remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Q_DAILY_RUN ( dept_code," + 
                    "run_date," + 
                    "equp_code," + 
                    "seq," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "run_time," + 
                    "suspension_time," + 
                    "extra_time," + 
                    "settle_time," + 
                    "unitcost," + 
                    "settle_amt," + 
                    "inv_tag," + 
                    "fuel_qty," + 
                    "fuel_amt," + 
                    "oil_qty," + 
                    "oil_amt," + 
                    "repair_remark," + 
                    "repair_amt," + 
                    "move_remark," + 
                    "move_amt," + 
                    "run_remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21 , :22) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_run_date);
      gpstatement.bindColumn(3, idx_equp_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_spec_unq_num);
      gpstatement.bindColumn(7, idx_run_time);
      gpstatement.bindColumn(8, idx_suspension_time);
      gpstatement.bindColumn(9, idx_extra_time);
      gpstatement.bindColumn(10, idx_settle_time);
      gpstatement.bindColumn(11, idx_unitcost);
      gpstatement.bindColumn(12, idx_settle_amt);
      gpstatement.bindColumn(13, idx_inv_tag);
      gpstatement.bindColumn(14, idx_fuel_qty);
      gpstatement.bindColumn(15, idx_fuel_amt);
      gpstatement.bindColumn(16, idx_oil_qty);
      gpstatement.bindColumn(17, idx_oil_amt);
      gpstatement.bindColumn(18, idx_repair_remark);
      gpstatement.bindColumn(19, idx_repair_amt);
      gpstatement.bindColumn(20, idx_move_remark);
      gpstatement.bindColumn(21, idx_move_amt);
      gpstatement.bindColumn(22, idx_run_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update q_daily_run set " + 
                            "dept_code=?,  " + 
                            "run_date=?,  " + 
                            "equp_code=?,  " + 
                            "seq=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "run_time=?,  " + 
                            "suspension_time=?,  " + 
                            "extra_time=?,  " + 
                            "settle_time=?,  " + 
                            "unitcost=?,  " + 
                            "settle_amt=?,  " + 
                            "inv_tag=?,  " + 
                            "fuel_qty=?,  " + 
                            "fuel_amt=?,  " + 
                            "oil_qty=?,  " + 
                            "oil_amt=?,  " + 
                            "repair_remark=?,  " + 
                            "repair_amt=?,  " + 
                            "move_remark=?,  " + 
                            "move_amt=?,  " + 
                            "run_remark=?  where dept_code=? " +
                            " and run_date=?  " + 
                            " and equp_code=?  " +
                            " and seq=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_run_date);
      gpstatement.bindColumn(3, idx_equp_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_spec_unq_num);
      gpstatement.bindColumn(7, idx_run_time);
      gpstatement.bindColumn(8, idx_suspension_time);
      gpstatement.bindColumn(9, idx_extra_time);
      gpstatement.bindColumn(10, idx_settle_time);
      gpstatement.bindColumn(11, idx_unitcost);
      gpstatement.bindColumn(12, idx_settle_amt);
      gpstatement.bindColumn(13, idx_inv_tag);
      gpstatement.bindColumn(14, idx_fuel_qty);
      gpstatement.bindColumn(15, idx_fuel_amt);
      gpstatement.bindColumn(16, idx_oil_qty);
      gpstatement.bindColumn(17, idx_oil_amt);
      gpstatement.bindColumn(18, idx_repair_remark);
      gpstatement.bindColumn(19, idx_repair_amt);
      gpstatement.bindColumn(20, idx_move_remark);
      gpstatement.bindColumn(21, idx_move_amt);
      gpstatement.bindColumn(22, idx_run_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(23, idx_dept_code);
      gpstatement.bindColumn(24, idx_run_date);
      gpstatement.bindColumn(25, idx_equp_code);
      gpstatement.bindColumn(26, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from q_daily_run where dept_code=? " +
                            "and run_date=?  " + 
                            "and equp_code=?  " +
                            " and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_run_date);
      gpstatement.bindColumn(3, idx_equp_code);
      gpstatement.bindColumn(4, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>