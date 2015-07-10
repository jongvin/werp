<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_invest_parent_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_acntcode = dSet.indexOfColumn("acntcode");
   	int idx_acntname = dSet.indexOfColumn("acntname");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_process_yn = dSet.indexOfColumn("process_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO C_INVEST_PARENT ( dept_code," + 
                    "yymm," + 
                    "acntcode," + 
                    "acntname," + 
                    "amt," + 
                    "process_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_acntcode);
      gpstatement.bindColumn(4, idx_acntname);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_process_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update c_invest_parent set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "acntcode=?,  " + 
                            "acntname=?,  " + 
                            "amt=?,  " + 
                            "process_yn=?  where dept_code=? and yymm=? and acntcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_acntcode);
      gpstatement.bindColumn(4, idx_acntname);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_process_yn);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_yymm);
      gpstatement.bindColumn(9, idx_acntcode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from c_invest_parent where dept_code=? and yymm=? and acntcode=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_acntcode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>