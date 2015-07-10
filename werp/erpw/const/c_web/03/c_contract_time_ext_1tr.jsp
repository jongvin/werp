<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_contract_time_ext_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cont_no = dSet.indexOfColumn("cont_no");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_extablish_time = dSet.indexOfColumn("extablish_time");
   	int idx_extablish_tag = dSet.indexOfColumn("extablish_tag");
   	int idx_issue_date = dSet.indexOfColumn("issue_date");
   	int idx_reservation_amt = dSet.indexOfColumn("reservation_amt");
   	int idx_supply_amt = dSet.indexOfColumn("supply_amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_sum_amt = dSet.indexOfColumn("sum_amt");
   	int idx_prepay_amt = dSet.indexOfColumn("prepay_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_membership_no = dSet.indexOfColumn("membership_no");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_CONTRACT_TIME_EXTABLISHED ( dept_code,		" + 
                    "        cont_no,														" + 
                    "        chg_degree,													" + 
                    "        extablish_time,												" + 
                    "        extablish_tag,												" + 
                    "        issue_date,													" + 
                    "        reservation_amt,											" + 
                    "        supply_amt,													" + 
                    "        vat_amt,														" + 
                    "        sum_amt,														" + 
                    "        prepay_amt,													" + 
                    "        remark, 														" + 
                    "        membership_no,request_dt )      										";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14)  ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_extablish_time);
      gpstatement.bindColumn(5, idx_extablish_tag);
      gpstatement.bindColumn(6, idx_issue_date);
      gpstatement.bindColumn(7, idx_reservation_amt);
      gpstatement.bindColumn(8, idx_supply_amt);
      gpstatement.bindColumn(9, idx_vat_amt);
      gpstatement.bindColumn(10, idx_sum_amt);
      gpstatement.bindColumn(11, idx_prepay_amt);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_membership_no);
      gpstatement.bindColumn(14, idx_request_dt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update r_contract_time_extablished set 									" + 								
                    "       dept_code=?,  															" + 								
                    "       cont_no=?, 	 															" + 								
                    "       chg_degree=?,  															" + 								
                    "       extablish_time=?,  														" + 								
                    "       extablish_tag=?,  														" + 								
                    "       issue_date=?,  															" + 								
                    "       reservation_amt=?,  													" + 								
                    "       supply_amt=?,  															" + 								
                    "       vat_amt=?,  																" + 								
                    "       sum_amt=?,  																" + 								
                    "       prepay_amt=?,  															" + 								
                    "       remark=?,  																" + 										
                    "       membership_no=?,request_dt=? where (dept_code=? and cont_no=? and chg_degree=? and extablish_time=? )";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_extablish_time);
      gpstatement.bindColumn(5, idx_extablish_tag);
      gpstatement.bindColumn(6, idx_issue_date);
      gpstatement.bindColumn(7, idx_reservation_amt);
      gpstatement.bindColumn(8, idx_supply_amt);
      gpstatement.bindColumn(9, idx_vat_amt);
      gpstatement.bindColumn(10, idx_sum_amt);
      gpstatement.bindColumn(11, idx_prepay_amt);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_membership_no);
      gpstatement.bindColumn(14, idx_request_dt);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_cont_no);
      gpstatement.bindColumn(17, idx_chg_degree);
      gpstatement.bindColumn(18, idx_extablish_time);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from r_contract_time_extablished where (dept_code=? and cont_no=? and chg_degree=? and extablish_time=? )"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_extablish_time);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ include file="../../../comm_function/conn_tr_end.jsp"%>