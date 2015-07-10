<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_approval_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_approym = dSet.indexOfColumn("approym");
   	int idx_approseq = dSet.indexOfColumn("approseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_approval_unq_num = dSet.indexOfColumn("approval_unq_num");
   	int idx_approdetailseq = dSet.indexOfColumn("approdetailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_conf_amt = dSet.indexOfColumn("conf_amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_request_unq_num = dSet.indexOfColumn("request_unq_num");
   	int idx_est_unq_num = dSet.indexOfColumn("est_unq_num");
   	int idx_request_chg_cnt = dSet.indexOfColumn("request_chg_cnt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_APPROVAL_DETAIL ( dept_code," + 
                    "approym," + 
                    "approseq," + 
                    "chg_cnt," + 
                    "approval_unq_num," + 
                    "approdetailseq," + 
                    "mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "qty," + 
                    "unitprice," + 
                    "amt," + 
                    "conf_amt," + 
                    "vatamt," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "request_unq_num," + 
                    "est_unq_num,request_chg_cnt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19,:20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_approval_unq_num);
      gpstatement.bindColumn(6, idx_approdetailseq);
      gpstatement.bindColumn(7, idx_mtrcode);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unitcode);
      gpstatement.bindColumn(11, idx_qty);
      gpstatement.bindColumn(12, idx_unitprice);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_conf_amt);
      gpstatement.bindColumn(15, idx_vatamt);
      gpstatement.bindColumn(16, idx_spec_no_seq);
      gpstatement.bindColumn(17, idx_spec_unq_num);
      gpstatement.bindColumn(18, idx_request_unq_num);
      gpstatement.bindColumn(19, idx_est_unq_num);
      gpstatement.bindColumn(20, idx_request_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_approval_detail set " + 
                            "dept_code=?,  " + 
                            "approym=?,  " + 
                            "approseq=?,  " + 
                            "chg_cnt=?,  " + 
                            "approval_unq_num=?,  " + 
                            "approdetailseq=?,  " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?,  " + 
                            "conf_amt=?,  " + 
                            "vatamt=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "request_unq_num=?,  " + 
                            "est_unq_num=?, request_chg_cnt=?  where dept_code=? " +
                            " and approym=?  " + 
                            " and approseq=?  " + 
                            " and chg_cnt=?  " + 
                            " and approval_unq_num=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_approval_unq_num);
      gpstatement.bindColumn(6, idx_approdetailseq);
      gpstatement.bindColumn(7, idx_mtrcode);
      gpstatement.bindColumn(8, idx_name);
      gpstatement.bindColumn(9, idx_ssize);
      gpstatement.bindColumn(10, idx_unitcode);
      gpstatement.bindColumn(11, idx_qty);
      gpstatement.bindColumn(12, idx_unitprice);
      gpstatement.bindColumn(13, idx_amt);
      gpstatement.bindColumn(14, idx_conf_amt);
      gpstatement.bindColumn(15, idx_vatamt);
      gpstatement.bindColumn(16, idx_spec_no_seq);
      gpstatement.bindColumn(17, idx_spec_unq_num);
      gpstatement.bindColumn(18, idx_request_unq_num);
      gpstatement.bindColumn(19, idx_est_unq_num);
      gpstatement.bindColumn(20, idx_request_chg_cnt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_dept_code);
      gpstatement.bindColumn(22, idx_approym);
      gpstatement.bindColumn(23, idx_approseq);
      gpstatement.bindColumn(24, idx_chg_cnt);
      gpstatement.bindColumn(25, idx_approval_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_approval_detail where dept_code=? " +
                            " and approym=?  " + 
                            " and approseq=?  " + 
                            " and chg_cnt=?  " + 
                            " and approval_unq_num=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_approym);
      gpstatement.bindColumn(3, idx_approseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      gpstatement.bindColumn(5, idx_approval_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>