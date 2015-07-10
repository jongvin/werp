<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%>
<%
    GauceDataSet dSet = req.getGauceDataSet("E_sa_amt_input_1tr"); 
	 gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_safety_man = dSet.indexOfColumn("safety_man");
   	int idx_real_safety_cost = dSet.indexOfColumn("real_safety_cost");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	 String sSql = " INSERT INTO  e_safty_budget_master	" +
				   "	 (dept_code,									" + 
				   "	  safety_man,									" + 
					"    real_safety_cost)							" ; 
      sSql = sSql + "  VALUES ( :1 ,:2 ,:3 )					" ;
	   stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_safety_man );
      gpstatement.bindColumn(3, idx_real_safety_cost );
	   stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
    String ls_safety_man = rows.getString(idx_safety_man);
    String ls_real_safety_cost = rows.getString(idx_real_safety_cost);
    String ls_dept_code = rows.getString(idx_dept_code);

	 String sSql = " update e_safty_budget_master set						" + 
						"       safety_man='"+ls_safety_man+"'	,				" +
						"       real_safety_cost='"+ls_real_safety_cost+"'	" +
						" where dept_code ='"+ls_dept_code+"' 					" ;
		stmt = conn.prepareStatement(sSql); 
		gpstatement.gp_stmt = stmt;
//		gpstatement.bindColumn(1, idx_safety_man );
	 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
//		gpstatement.bindColumn(2, idx_dept_code);
		stmt.executeUpdate();
		stmt.close();		
  } else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
     String sSql = "delete from e_safty_budget_master where dept_code =? "; 
     stmt = conn.prepareStatement(sSql); 
     gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ)  */
     gpstatement.bindColumn(1, idx_dept_code);
     stmt.executeUpdate();
     stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>