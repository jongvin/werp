<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("M_CUSTODY_MAT_CHK_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_SEQ = dSet.indexOfColumn("SEQ");
   	int idx_NAME = dSet.indexOfColumn("NAME");
   	int idx_SSIZE = dSet.indexOfColumn("SSIZE");
   	int idx_UNITCODE = dSet.indexOfColumn("UNITCODE");
   	int idx_QTY = dSet.indexOfColumn("QTY");
   	int idx_MAT_CONDITION = dSet.indexOfColumn("MAT_CONDITION");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_CUSTODY_MAT_CHK " +
			           "( DEPT_CODE," + 
                    "yymmdd," + 
                    "SEQ," + 
                    "NAME," + 
                    "SSIZE," + 
                    "UNITCODE," + 
                    "QTY," + 
                    "MAT_CONDITION )" ; 
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 )" ;
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_yymmdd);
      gpstatement.bindColumn(3, idx_SEQ);
      gpstatement.bindColumn(4, idx_NAME);
      gpstatement.bindColumn(5, idx_SSIZE);
      gpstatement.bindColumn(6, idx_UNITCODE);
      gpstatement.bindColumn(7, idx_QTY);
      gpstatement.bindColumn(8, idx_MAT_CONDITION);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update M_CUSTODY_MAT_CHK set " + 
                            "yymmdd=?,  " + 
                            "NAME=?,  " + 
                            "SSIZE=?,  " + 
                            "UNITCODE=?,  " + 
                            "QTY=?,  " + 
                            "MAT_CONDITION=?  " + 
                    "where                   " +
									 "DEPT_CODE=?   and  " +
									 "seq =? " ;
									
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymmdd);
      gpstatement.bindColumn(2, idx_NAME);
      gpstatement.bindColumn(3, idx_SSIZE);
      gpstatement.bindColumn(4, idx_UNITCODE);
      gpstatement.bindColumn(5, idx_QTY);
      gpstatement.bindColumn(6, idx_MAT_CONDITION);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(7, idx_DEPT_CODE);
      gpstatement.bindColumn(8, idx_SEQ);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from M_CUSTODY_MAT_CHK where DEPT_CODE=? and seq =?  "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_SEQ);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>