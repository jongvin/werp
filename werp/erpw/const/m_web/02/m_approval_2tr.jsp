<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_approval_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_owner = dSet.indexOfColumn("sbcr_owner");
   	int idx_tel_fax = dSet.indexOfColumn("tel_fax");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_APPROVAL_SBCR ( dept_code," + 
                    "approym," + 
                    "approseq," + 
                    "chg_cnt," + 
                    "sbcr_code," + 
                    "sbcr_owner," + 
                    "tel_fax )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_sbcr_owner);
      gpstatement.bindColumn(7, idx_tel_fax);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_approval_sbcr set " + 
                            "dept_code=?,  " + 
                            "approym=?,  " + 
                            "approseq=?,  " + 
                            "chg_cnt=?,  " + 
                            "sbcr_code=?,  " + 
                            "sbcr_owner=?,  " + 
                            "tel_fax=?  where dept_code=? " +
                            "             and approym=? " +
                            "             and approseq=? " +
                            "             and chg_cnt=? " + 
                            "             and sbcr_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_sbcr_code);
      gpstatement.bindColumn(6, idx_sbcr_owner);
      gpstatement.bindColumn(7, idx_tel_fax);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_approym);
      gpstatement.bindColumn(10, idx_approseq);
      gpstatement.bindColumn(11, idx_chg_cnt);
      gpstatement.bindColumn(12, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_approval_sbcr where dept_code=? " + 
                            "             and approym=? " +
                            "             and approseq=? " +
                            "             and chg_cnt=? " + 
                            "             and sbcr_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>