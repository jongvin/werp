<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_reform_plan_inspect_total_1tr"); 
	  gpstatement.gp_dataset = dSet;
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_CODE = dSet.indexOfColumn("CODE");
		int idx_ORDER_DT = dSet.indexOfColumn("ORDER_DT");
   	int idx_REPORT_DT = dSet.indexOfColumn("REPORT_DT");
   	int idx_COMPLETE_DT = dSet.indexOfColumn("COMPLETE_DT");
   	int idx_INS_CHIEF = dSet.indexOfColumn("INS_CHIEF");
   	int idx_DEPT_CHIEF = dSet.indexOfColumn("DEPT_CHIEF");
   	int idx_INSPECTOR = dSet.indexOfColumn("INSPECTOR");
   	int idx_YN = dSet.indexOfColumn("YN");
   	int idx_REMARK = dSet.indexOfColumn("REMARK");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_REFORM_ORDER_INSPECT_MASTER ( DEPT_CODE," + 
                    "YEAR, " +
                    "QUARTER_YEAR, " +
                    "ORDER_DT, " +
                    "REPORT_DT, " +
                    "COMPLETE_DT, " +
						  "INS_CHIEF, " +
                    "DEPT_CHIEF, " +
                    "INSPECTOR ) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7, :8 , :9) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_ORDER_DT);
      gpstatement.bindColumn(5, idx_REPORT_DT);
      gpstatement.bindColumn(6, idx_COMPLETE_DT);
      gpstatement.bindColumn(7, idx_INS_CHIEF);
		gpstatement.bindColumn(8, idx_DEPT_CHIEF);
		gpstatement.bindColumn(9, idx_INSPECTOR);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update V_REFORM_ORDER_INSPECT_MASTER set " + 
						  "   CODE =? , " +
                    "	COMPLETE_DT=?, " +
						  "   YN=?, " +
	                 "   REMARK=? " + 
						  " where DEPT_CODE=? " + 
						  " and to_char(year,'yyyy')=? " +
						  " and QUARTER_YEAR=? " ;

      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_CODE);
      gpstatement.bindColumn(2, idx_COMPLETE_DT);
		gpstatement.bindColumn(3, idx_YN);
		gpstatement.bindColumn(4, idx_REMARK); 
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
		gpstatement.bindColumn(5, idx_DEPT_CODE);
      gpstatement.bindColumn(6, idx_YEAR);
      gpstatement.bindColumn(7, idx_QUARTER_YEAR);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from V_REFORM_ORDER_INSPECT_MASTER  " +
	 					  " where DEPT_CODE=? " + 
						  " and to_char(year,'yyyy')=? " +
						  " and QUARTER_YEAR=? " ; 
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
		stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>