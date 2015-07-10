<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
	GauceDataSet dSet = req.getGauceDataSet("s_sbcr_risk_1tr");
	gpstatement.gp_dataset = dSet;
	int idx_SBCR_CODE = dSet.indexOfColumn("SBCR_CODE");
	int idx_PROFESSION_WBS_CODE = dSet.indexOfColumn("PROFESSION_WBS_CODE");
	int idx_WATCH_NOTE = dSet.indexOfColumn("WATCH_NOTE");
	int idx_NOTE = dSet.indexOfColumn("NOTE");
	int idx_DECISION_NOTE = dSet.indexOfColumn("DECISION_NOTE");

    int  rowCnt = dSet.getDataRowCnt();
	for(int i=0; i< rowCnt; i++){
		GauceDataRow rows = dSet.getDataRow(i);
		gpstatement.gp_row = i;
		if(rows.getJobType() == GauceDataRow.TB_JOB_UPDATE){
			/* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
			String sSql = "delete from s_wbs_request_etc " + 
							"where " +
							"    sbcr_code=? " +
                            "AND PROFESSION_WBS_CODE=? ";
			stmt = conn.prepareStatement(sSql); 
			gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_SBCR_CODE);
			gpstatement.bindColumn(2, idx_PROFESSION_WBS_CODE);
			stmt.executeUpdate();
			stmt.close();

			sSql = "INSERT INTO s_wbs_request_etc (SBCR_CODE,PROFESSION_WBS_CODE,WATCH_NOTE,NOTE,DECISION) " + 
                            "VALUES (:1, :2, :3, :4, :5)";
			stmt = conn.prepareStatement(sSql); 
			gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_SBCR_CODE);
			gpstatement.bindColumn(2, idx_PROFESSION_WBS_CODE);
			gpstatement.bindColumn(3, idx_WATCH_NOTE);
			gpstatement.bindColumn(4, idx_NOTE);
			gpstatement.bindColumn(5, idx_DECISION_NOTE);
			stmt.executeUpdate();
			stmt.close();
		}
	}
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>