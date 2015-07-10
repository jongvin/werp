<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_school_expense_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_relation_code = dSet.indexOfColumn("relation_code");
   	int idx_family_name = dSet.indexOfColumn("family_name");
   	int idx_rrn_pre = dSet.indexOfColumn("rrn_pre");
   	int idx_rrn_post = dSet.indexOfColumn("rrn_post");
   	int idx_school_name = dSet.indexOfColumn("school_name");
   	int idx_school_year = dSet.indexOfColumn("school_year");
   	int idx_division = dSet.indexOfColumn("division");
   	int idx_school_amt = dSet.indexOfColumn("school_amt");
   	int idx_school_pay_date = dSet.indexOfColumn("school_pay_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_school_expenses ( emp_no," + 
                    "seq," + 
                    "relation_code," + 
                    "family_name," + 
                    "rrn_pre," + 
                    "rrn_post," + 
                    "school_name," + 
                    "school_year," + 
                    "division," + 
                    "school_amt," + 
                    "school_pay_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_relation_code);
      gpstatement.bindColumn(4, idx_family_name);
      gpstatement.bindColumn(5, idx_rrn_pre);
      gpstatement.bindColumn(6, idx_rrn_post);
      gpstatement.bindColumn(7, idx_school_name);
      gpstatement.bindColumn(8, idx_school_year);
      gpstatement.bindColumn(9, idx_division);
      gpstatement.bindColumn(10, idx_school_amt);
      gpstatement.bindColumn(11, idx_school_pay_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update p_pers_school_expenses set " + 
                            "emp_no=?,  " + 
                            "seq=?,  " + 
                            "relation_code=?,  " + 
                            "family_name=?,  " + 
                            "rrn_pre=?,  " + 
                            "rrn_post=?,  " + 
                            "school_name=?,  " + 
                            "school_year=?,  " + 
                            "division=?,  " + 
                            "school_amt=?,  " + 
                            "school_pay_date=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_relation_code);
      gpstatement.bindColumn(4, idx_family_name);
      gpstatement.bindColumn(5, idx_rrn_pre);
      gpstatement.bindColumn(6, idx_rrn_post);
      gpstatement.bindColumn(7, idx_school_name);
      gpstatement.bindColumn(8, idx_school_year);
      gpstatement.bindColumn(9, idx_division);
      gpstatement.bindColumn(10, idx_school_amt);
      gpstatement.bindColumn(11, idx_school_pay_date);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(12, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from p_pers_school_expenses where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>