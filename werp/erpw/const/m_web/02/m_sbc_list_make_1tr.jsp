<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_sbc_list_make_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
	  	int idx_const_no = dSet.indexOfColumn("const_no");
   	int idx_const_date = dSet.indexOfColumn("const_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_approval_sbcr set " + 
                            "const_no=?, const_date=? where dept_code=? " +
                            "             and approym=? " +
                            "             and approseq=? " +
                            "             and chg_cnt=? " + 
                            "             and sbcr_code=? " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_const_no);
      gpstatement.bindColumn(2, idx_const_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_approym);
      gpstatement.bindColumn(5, idx_approseq);
      gpstatement.bindColumn(6, idx_chg_cnt);
      gpstatement.bindColumn(7, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>