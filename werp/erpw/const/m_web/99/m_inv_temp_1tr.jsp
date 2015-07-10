<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
	GauceDataSet dSet = req.getGauceDataSet("m_inv_temp_1tr");
	gpstatement.gp_dataset = dSet;
	int idx_asst_numb = dSet.indexOfColumn("asst_numb");
	int idx_newx_code = dSet.indexOfColumn("newx_code");
	int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
		GauceDataRow rows = dSet.getDataRow(i);
		gpstatement.gp_row = i;
		if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
			String sSql = "update m_inv_temp set newx_code = '" + rows.getString(idx_newx_code) + "' where asst_numb = '" + rows.getString(idx_asst_numb) + "'";
			stmt = conn.prepareStatement(sSql);
			stmt.executeUpdate();
			stmt.close();
		}
	}
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>