<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_dept_degree_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_code = dSet.indexOfColumn("code");
   	int idx_key_code = dSet.indexOfColumn("key_code");
   	int idx_code_name = dSet.indexOfColumn("code_name");
   	int idx_class = dSet.indexOfColumn("class");
	int idx_agree_date = dSet.indexOfColumn("agree_date");
	int idx_degree_amt_rate = dSet.indexOfColumn("degree_amt_rate");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_DEPT_DEGREE ( dept_code," + 
                    "sell_code," + 
                    "code," + 
                    "code_name," + 
                    "class , agree_date, degree_amt_rate)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_code);
      gpstatement.bindColumn(4, idx_code_name);
      gpstatement.bindColumn(5, idx_class);
	  gpstatement.bindColumn(6, idx_agree_date);
	  gpstatement.bindColumn(7, idx_degree_amt_rate);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_dept_degree set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "code=?,  " + 
                            "code_name=?,  " + 
                            "class=?, agree_date=?, degree_amt_rate=?  where dept_code=? " +
                            "           and sell_code=? " +
                            "           and code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_code);
      gpstatement.bindColumn(4, idx_code_name);
      gpstatement.bindColumn(5, idx_class);
		gpstatement.bindColumn(6, idx_agree_date);
	   gpstatement.bindColumn(7, idx_degree_amt_rate);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_sell_code);
      gpstatement.bindColumn(10, idx_key_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_dept_degree where dept_code=? " +
                            "           and sell_code=? " +
                            "           and code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_key_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>