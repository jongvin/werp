<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_output_slip_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
   	int idx_work_dt = dSet.indexOfColumn("work_dt");
   	int idx_acnt_code = dSet.indexOfColumn("acnt_code");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_yyyymmdd = dSet.indexOfColumn("yyyymmdd");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_cont = dSet.indexOfColumn("cont");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_work_process = dSet.indexOfColumn("work_process");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_OUTPUT_SLIP ( dept_code," + 
                    "vat_unq_num," + 
                    "work_dt," + 
                    "acnt_code," + 
                    "vattag," + 
                    "yyyymmdd," + 
                    "amt," + 
                    "vat_amt," + 
                    "cont," + 
                    "invoice_num," + 
                    "work_process )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_vat_unq_num);
      gpstatement.bindColumn(3, idx_work_dt);
      gpstatement.bindColumn(4, idx_acnt_code);
      gpstatement.bindColumn(5, idx_vattag);
      gpstatement.bindColumn(6, idx_yyyymmdd);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_vat_amt);
      gpstatement.bindColumn(9, idx_cont);
      gpstatement.bindColumn(10, idx_invoice_num);
      gpstatement.bindColumn(11, idx_work_process);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_output_slip set " + 
                            "dept_code=?,  " + 
                            "vat_unq_num=?,  " + 
                            "work_dt=?,  " + 
                            "acnt_code=?,  " + 
                            "vattag=?,  " + 
                            "yyyymmdd=?,  " + 
                            "amt=?,  " + 
                            "vat_amt=?,  " + 
                            "cont=?,  " + 
                            "invoice_num=?,  " + 
                            "work_process=?  where dept_code=? " +
                            "                  and vat_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_vat_unq_num);
      gpstatement.bindColumn(3, idx_work_dt);
      gpstatement.bindColumn(4, idx_acnt_code);
      gpstatement.bindColumn(5, idx_vattag);
      gpstatement.bindColumn(6, idx_yyyymmdd);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_vat_amt);
      gpstatement.bindColumn(9, idx_cont);
      gpstatement.bindColumn(10, idx_invoice_num);
      gpstatement.bindColumn(11, idx_work_process);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_vat_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_output_slip where dept_code=? " +
                            "                  and vat_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_vat_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>