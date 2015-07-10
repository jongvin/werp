<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_waste_matter_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_waste_matter_code = dSet.indexOfColumn("waste_matter_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_gen_dt = dSet.indexOfColumn("gen_dt");
   	int idx_mat_status = dSet.indexOfColumn("mat_status");
   	int idx_gen_amt = dSet.indexOfColumn("gen_amt");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
   	int idx_self_disp_dt = dSet.indexOfColumn("self_disp_dt");
   	int idx_self_disp_amt = dSet.indexOfColumn("self_disp_amt");
   	int idx_mid_disp_method = dSet.indexOfColumn("mid_disp_method");
   	int idx_mid_disp_amt = dSet.indexOfColumn("mid_disp_amt");
   	int idx_fin_disp_method = dSet.indexOfColumn("fin_disp_method");
   	int idx_fin_disp_amt = dSet.indexOfColumn("fin_disp_amt");
   	int idx_self_tot_amt = dSet.indexOfColumn("self_tot_amt");
   	int idx_commit_dt = dSet.indexOfColumn("commit_dt");
   	int idx_commit_amt = dSet.indexOfColumn("commit_amt");
   	int idx_commit_carrier = dSet.indexOfColumn("commit_carrier");
   	int idx_commit_disp = dSet.indexOfColumn("commit_disp");
   	int idx_commit_method = dSet.indexOfColumn("commit_method");
   	int idx_commit_tot = dSet.indexOfColumn("commit_tot");
   	int idx_keep_amt = dSet.indexOfColumn("keep_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_waste_matter ( dept_code," + 
                    "waste_matter_code," + 
                    "seq," + 
                    "gen_dt," + 
                    "mat_status," + 
                    "gen_amt," + 
                    "tot_amt," + 
                    "self_disp_dt," + 
                    "self_disp_amt," + 
                    "mid_disp_method," + 
                    "mid_disp_amt," + 
                    "fin_disp_method," + 
                    "fin_disp_amt," + 
                    "self_tot_amt," + 
                    "commit_dt," + 
                    "commit_amt," + 
                    "commit_carrier," + 
                    "commit_disp," + 
                    "commit_method," + 
                    "commit_tot," + 
                    "keep_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_waste_matter_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_gen_dt);
      gpstatement.bindColumn(5, idx_mat_status);
      gpstatement.bindColumn(6, idx_gen_amt);
      gpstatement.bindColumn(7, idx_tot_amt);
      gpstatement.bindColumn(8, idx_self_disp_dt);
      gpstatement.bindColumn(9, idx_self_disp_amt);
      gpstatement.bindColumn(10, idx_mid_disp_method);
      gpstatement.bindColumn(11, idx_mid_disp_amt);
      gpstatement.bindColumn(12, idx_fin_disp_method);
      gpstatement.bindColumn(13, idx_fin_disp_amt);
      gpstatement.bindColumn(14, idx_self_tot_amt);
      gpstatement.bindColumn(15, idx_commit_dt);
      gpstatement.bindColumn(16, idx_commit_amt);
      gpstatement.bindColumn(17, idx_commit_carrier);
      gpstatement.bindColumn(18, idx_commit_disp);
      gpstatement.bindColumn(19, idx_commit_method);
      gpstatement.bindColumn(20, idx_commit_tot);
      gpstatement.bindColumn(21, idx_keep_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_waste_matter set " + 
                            "dept_code=?,  " + 
                            "waste_matter_code=?,  " + 
                            "seq=?,  " + 
                            "gen_dt=?,  " + 
                            "mat_status=?,  " + 
                            "gen_amt=?,  " + 
                            "tot_amt=?,  " + 
                            "self_disp_dt=?,  " + 
                            "self_disp_amt=?,  " + 
                            "mid_disp_method=?,  " + 
                            "mid_disp_amt=?,  " + 
                            "fin_disp_method=?,  " + 
                            "fin_disp_amt=?,  " + 
                            "self_tot_amt=?,  " + 
                            "commit_dt=?,  " + 
                            "commit_amt=?,  " + 
                            "commit_carrier=?,  " + 
                            "commit_disp=?,  " + 
                            "commit_method=?,  " + 
                            "commit_tot=?,  " + 
                            "keep_amt=?  where dept_code=? and waste_matter_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_waste_matter_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_gen_dt);
      gpstatement.bindColumn(5, idx_mat_status);
      gpstatement.bindColumn(6, idx_gen_amt);
      gpstatement.bindColumn(7, idx_tot_amt);
      gpstatement.bindColumn(8, idx_self_disp_dt);
      gpstatement.bindColumn(9, idx_self_disp_amt);
      gpstatement.bindColumn(10, idx_mid_disp_method);
      gpstatement.bindColumn(11, idx_mid_disp_amt);
      gpstatement.bindColumn(12, idx_fin_disp_method);
      gpstatement.bindColumn(13, idx_fin_disp_amt);
      gpstatement.bindColumn(14, idx_self_tot_amt);
      gpstatement.bindColumn(15, idx_commit_dt);
      gpstatement.bindColumn(16, idx_commit_amt);
      gpstatement.bindColumn(17, idx_commit_carrier);
      gpstatement.bindColumn(18, idx_commit_disp);
      gpstatement.bindColumn(19, idx_commit_method);
      gpstatement.bindColumn(20, idx_commit_tot);
      gpstatement.bindColumn(21, idx_keep_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(22, idx_dept_code);
      gpstatement.bindColumn(23, idx_waste_matter_code);
      gpstatement.bindColumn(24, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_waste_matter where dept_code=? and waste_matter_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);      
      gpstatement.bindColumn(2, idx_waste_matter_code);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>