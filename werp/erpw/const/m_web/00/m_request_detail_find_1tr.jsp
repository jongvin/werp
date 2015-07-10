<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_request_detail_find_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_requestseq = dSet.indexOfColumn("requestseq");
   	int idx_requestdetailseq = dSet.indexOfColumn("requestdetailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_requiredtime = dSet.indexOfColumn("requiredtime");
   	int idx_ho_buy_qty = dSet.indexOfColumn("ho_buy_qty");
   	int idx_site_buy_qty = dSet.indexOfColumn("site_buy_qty");
   	int idx_trans_qty = dSet.indexOfColumn("trans_qty");
   	int idx_trans_dept_code = dSet.indexOfColumn("trans_dept_code");
   	int idx_usage = dSet.indexOfColumn("usage");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_request_unq_num = dSet.indexOfColumn("request_unq_num");
   	int idx_nappr_qty = dSet.indexOfColumn("nappr_qty");
   	int idx_remark1 = dSet.indexOfColumn("remark1");
   	int idx_bud_qty = dSet.indexOfColumn("bud_qty");
   	int idx_bud_price = dSet.indexOfColumn("bud_price");
   	int idx_bud_amt = dSet.indexOfColumn("bud_amt");
   	int idx_pre_request_qty = dSet.indexOfColumn("pre_request_qty");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_REQUEST_DETAIL ( dept_code," + 
                    "requestseq," + 
                    "chg_cnt, " +
                    "request_unq_num," + 
                    "requestdetailseq," + 
                    "mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "qty," + 
                    "unitprice," + 
                    "amt," + 
                    "requiredtime," + 
                    "ho_buy_qty," + 
                    "site_buy_qty," + 
                    "trans_qty," + 
                    "trans_dept_code," + 
                    "usage," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "nappr_qty ,remark1,bud_qty,bud_price,bud_amt,pre_request_qty )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22,:23,:24,:25,:26 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_requestseq);
      gpstatement.bindColumn(3, idx_chg_cnt);
      gpstatement.bindColumn(4, idx_request_unq_num);
      gpstatement.bindColumn(5, idx_requestdetailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_qty);
      gpstatement.bindColumn(11, idx_unitprice);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_requiredtime);
      gpstatement.bindColumn(14, idx_ho_buy_qty);
      gpstatement.bindColumn(15, idx_site_buy_qty);
      gpstatement.bindColumn(16, idx_trans_qty);
      gpstatement.bindColumn(17, idx_trans_dept_code);
      gpstatement.bindColumn(18, idx_usage);
      gpstatement.bindColumn(19, idx_spec_no_seq);
      gpstatement.bindColumn(20, idx_spec_unq_num);
      gpstatement.bindColumn(21, idx_nappr_qty);
      gpstatement.bindColumn(22, idx_remark1);
      gpstatement.bindColumn(23, idx_bud_qty);
      gpstatement.bindColumn(24, idx_bud_price);
      gpstatement.bindColumn(25, idx_bud_amt);
      gpstatement.bindColumn(26, idx_pre_request_qty);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_request_detail set " + 
                            "dept_code=?,  " + 
                            "requestseq=?,  " + 
                            "chg_cnt=?, " +
                            "request_unq_num=?, " +
                            "requestdetailseq=?,  " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?,  " + 
                            "requiredtime=?,  " + 
                            "ho_buy_qty=?,  " + 
                            "site_buy_qty=?,  " + 
                            "trans_qty=?,  " + 
                            "trans_dept_code=?,  " + 
                            "usage=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "nappr_qty=?, remark1=?,bud_qty=?,bud_price=?,bud_amt=?,pre_request_qty=?  where dept_code=? " +
                            " and requestseq=? " +
                            " and chg_cnt=? " +
                            " and request_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_requestseq);
      gpstatement.bindColumn(3, idx_chg_cnt);
      gpstatement.bindColumn(4, idx_request_unq_num);
      gpstatement.bindColumn(5, idx_requestdetailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_qty);
      gpstatement.bindColumn(11, idx_unitprice);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_requiredtime);
      gpstatement.bindColumn(14, idx_ho_buy_qty);
      gpstatement.bindColumn(15, idx_site_buy_qty);
      gpstatement.bindColumn(16, idx_trans_qty);
      gpstatement.bindColumn(17, idx_trans_dept_code);
      gpstatement.bindColumn(18, idx_usage);
      gpstatement.bindColumn(19, idx_spec_no_seq);
      gpstatement.bindColumn(20, idx_spec_unq_num);
      gpstatement.bindColumn(21, idx_nappr_qty);
      gpstatement.bindColumn(22, idx_remark1);
      gpstatement.bindColumn(23, idx_bud_qty);
      gpstatement.bindColumn(24, idx_bud_price);
      gpstatement.bindColumn(25, idx_bud_amt);
      gpstatement.bindColumn(26, idx_pre_request_qty);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(27, idx_dept_code);
      gpstatement.bindColumn(28, idx_requestseq);
      gpstatement.bindColumn(29, idx_chg_cnt);
      gpstatement.bindColumn(30, idx_request_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_request_detail where dept_code=? " + 
                            " and requestseq=? " +
                            " and chg_cnt=?" +
                            " and request_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_requestseq);
      gpstatement.bindColumn(3, idx_chg_cnt);
      gpstatement.bindColumn(4, idx_request_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>