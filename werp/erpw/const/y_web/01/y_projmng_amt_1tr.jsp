<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_projmng_amt_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_work_dt = dSet.indexOfColumn("work_dt");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Y_PROJMNG_AMT_WBS ( dept_code," + 
                    "wbs_code," + 
                    "spec_no_seq," + 
                    "name," + 
                    "amt," + 
                    "work_dt," + 
                    "note," + 
                    "input_dt," + 
                    "input_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_work_dt);
      gpstatement.bindColumn(7, idx_note);
      gpstatement.bindColumn(8, idx_input_dt);
      gpstatement.bindColumn(9, idx_input_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update y_projmng_amt_wbs set " + 
                            "dept_code=?,  " + 
                            "wbs_code=?,  " + 
                            "spec_no_seq=?,  " + 
                            "name=?,  " + 
                            "amt=?,  " + 
                            "work_dt=?,  " + 
                            "note=?,  " + 
                            "input_dt=?,  " + 
                            "input_name=?  where dept_code=? " +
                            " and wbs_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_work_dt);
      gpstatement.bindColumn(7, idx_note);
      gpstatement.bindColumn(8, idx_input_dt);
      gpstatement.bindColumn(9, idx_input_name);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(10, idx_dept_code);
      gpstatement.bindColumn(11, idx_wbs_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from y_projmng_amt_wbs where dept_code=? " +
                                                   " and wbs_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>