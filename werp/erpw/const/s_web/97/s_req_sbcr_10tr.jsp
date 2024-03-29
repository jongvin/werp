<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_req_sbcr_10tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_unq_num = dSet.indexOfColumn("sbcr_unq_num");
   	int idx_year_class = dSet.indexOfColumn("year_class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_sale_amt = dSet.indexOfColumn("sale_amt");
   	int idx_sale_rt = dSet.indexOfColumn("sale_rt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_REQ_SALE ( sbcr_unq_num," + 
                    "year_class," + 
                    "seq," + 
                    "sbcr_name," + 
                    "sale_amt," + 
                    "sale_rt," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_year_class);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_sale_amt);
      gpstatement.bindColumn(6, idx_sale_rt);
      gpstatement.bindColumn(7, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_req_sale set " + 
                            "sbcr_unq_num=?,  " + 
                            "year_class=?,  " + 
                            "seq=?,  " + 
                            "sbcr_name=?,  " + 
                            "sale_amt=?,  " + 
                            "sale_rt=?,  " + 
                            "remark=?  where sbcr_unq_num=? " +
                            "            and year_class=? " +
                            "            and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_year_class);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_sale_amt);
      gpstatement.bindColumn(6, idx_sale_rt);
      gpstatement.bindColumn(7, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_sbcr_unq_num);
      gpstatement.bindColumn(9, idx_year_class);
      gpstatement.bindColumn(10, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_req_sale where sbcr_unq_num=? " +
                            "            and year_class=? " +
                            "            and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_year_class);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
  %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>
