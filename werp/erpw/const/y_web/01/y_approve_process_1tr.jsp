<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_approve_process_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_chg_title = dSet.indexOfColumn("chg_title");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_work_dt = dSet.indexOfColumn("work_dt");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_charge_name = dSet.indexOfColumn("charge_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Y_CHG_DEGREE ( dept_code," + 
                    "chg_no_seq," + 
                    "chg_title," + 
                    "approve_class," + 
                    "work_dt," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "cnt_amt," + 
                    "amt," + 
                    "remark," + 
                    "charge_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, TO_DATE(:5,'YYYY.MM.DD'), TO_DATE(:6,'YYYY.MM.DD'), TO_DATE(:7,'YYYY.MM.DD'), :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_chg_title);
      gpstatement.bindColumn(4, idx_approve_class);
      gpstatement.bindColumn(5, idx_work_dt);
      gpstatement.bindColumn(6, idx_request_dt);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_cnt_amt);
      gpstatement.bindColumn(9, idx_amt);
      gpstatement.bindColumn(10, idx_remark);
      gpstatement.bindColumn(11, idx_charge_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_chg_degree set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "chg_title=?,  " + 
                            "approve_class=?,  " + 
                            "work_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "request_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "approve_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "cnt_amt=?,  " + 
                            "amt=?,  " + 
                            "remark=?,  " + 
                            "charge_name=?  where dept_code=? " +
                            " and chg_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_chg_title);
      gpstatement.bindColumn(4, idx_approve_class);
      gpstatement.bindColumn(5, idx_work_dt);
      gpstatement.bindColumn(6, idx_request_dt);
      gpstatement.bindColumn(7, idx_approve_dt);
      gpstatement.bindColumn(8, idx_cnt_amt);
      gpstatement.bindColumn(9, idx_amt);
      gpstatement.bindColumn(10, idx_remark);
      gpstatement.bindColumn(11, idx_charge_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_chg_degree where dept_code=? " +
                    " and chg_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>