<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_REFORM_ORDER_INPUT_2h_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_SEQ = dSet.indexOfColumn("SEQ");
		int idx_WBS_CODE = dSet.indexOfColumn("WBS_CODE");
   	int idx_REFORM_DT = dSet.indexOfColumn("REFORM_DT");
   	int idx_REFORM_ORDER = dSet.indexOfColumn("REFORM_ORDER");
		int idx_BEFOR_REFORM = dSet.indexOfColumn("BEFOR_REFORM");
   	int idx_AFTER_REFORM = dSet.indexOfColumn("AFTER_REFORM");
   	int idx_PIC_INFO = dSet.indexOfColumn("PIC_INFO");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_REFORM_ORDER ( DEPT_CODE," + 
                    "YEAR, " +
                    "QUARTER_YEAR, " +
                    "SEQ, " +
                    "WBS_CODE, " +
						  "REFORM_DT, " +
                    "REFORM_ORDER ," +
						  "BEFOR_REFORM, " + 
						  "AFTER_REFORM, " +
						  "PIC_INFO ) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7,:8,:9,:10  ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_SEQ);
      gpstatement.bindColumn(5, idx_WBS_CODE);
      gpstatement.bindColumn(6, idx_REFORM_DT);
		gpstatement.bindColumn(7, idx_REFORM_ORDER);
		gpstatement.bindColumn(8, idx_BEFOR_REFORM);
		gpstatement.bindColumn(9, idx_AFTER_REFORM);
		gpstatement.bindColumn(10, idx_PIC_INFO);		
		stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update V_REFORM_ORDER set " + 
                    "	WBS_CODE =?, " +
						  "	REFORM_DT=?, " +
                    "	REFORM_ORDER=?, " + 
                    "	BEFOR_REFORM=?, " + 
                    "	AFTER_REFORM=?, " + 
                    "	PIC_INFO=? " + 
						  " where DEPT_CODE=? " + 
						  "	and TO_CHAR(YEAR,'YYYY')=? " + 
						  "	and QUARTER_YEAR=? " + 
						  "	and SEQ=? "	 ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_WBS_CODE);
      gpstatement.bindColumn(2, idx_REFORM_DT);
		gpstatement.bindColumn(3, idx_REFORM_ORDER);
		gpstatement.bindColumn(4, idx_BEFOR_REFORM);
		gpstatement.bindColumn(5, idx_AFTER_REFORM);
		gpstatement.bindColumn(6, idx_PIC_INFO);		
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(7, idx_DEPT_CODE);
      gpstatement.bindColumn(8, idx_YEAR);
      gpstatement.bindColumn(9, idx_QUARTER_YEAR);
      gpstatement.bindColumn(10, idx_SEQ);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from V_REFORM_ORDER  " +
						  " where DEPT_CODE=? " + 
						  " and TO_CHAR(YEAR,'YYYY')=? " + 
						  " and QUARTER_YEAR=? " + 
						  " and SEQ=? "	 ;  
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_SEQ);
		stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>