<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_req_sbcr_8tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_unq_num = dSet.indexOfColumn("sbcr_unq_num");
   	int idx_othercompany_seq = dSet.indexOfColumn("othercompany_seq");
   	int idx_key_othercompany_seq = dSet.indexOfColumn("key_othercompany_seq");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_profession_wbs_name = dSet.indexOfColumn("profession_wbs_name");
   	int idx_othercompany_construction = dSet.indexOfColumn("othercompany_construction");
   	int idx_othercompany_start_date = dSet.indexOfColumn("othercompany_start_date");
   	int idx_othercompany_end_date = dSet.indexOfColumn("othercompany_end_date");
   	int idx_othercompany_amt = dSet.indexOfColumn("othercompany_amt");
   	int idx_sale_amt = dSet.indexOfColumn("sale_amt");
   	int idx_bigo = dSet.indexOfColumn("bigo");
   	int idx_year_class = dSet.indexOfColumn("year_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_REQ_CONST ( sbcr_unq_num," + 
                    "othercompany_seq," + 
                    "owner," + 
                    "profession_wbs_name," + 
                    "othercompany_construction," + 
                    "othercompany_start_date," + 
                    "othercompany_end_date," + 
                    "othercompany_amt," + 
                    "sale_amt," + 
                    "bigo ,year_class)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10,:11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_othercompany_seq);
      gpstatement.bindColumn(3, idx_owner);
      gpstatement.bindColumn(4, idx_profession_wbs_name);
      gpstatement.bindColumn(5, idx_othercompany_construction);
      gpstatement.bindColumn(6, idx_othercompany_start_date);
      gpstatement.bindColumn(7, idx_othercompany_end_date);
      gpstatement.bindColumn(8, idx_othercompany_amt);
      gpstatement.bindColumn(9, idx_sale_amt);
      gpstatement.bindColumn(10, idx_bigo);
      gpstatement.bindColumn(11, idx_year_class);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_req_const set " + 
                            "sbcr_unq_num=?,  " + 
                            "othercompany_seq=?,  " + 
                            "owner=?,  " + 
                            "profession_wbs_name=?,  " + 
                            "othercompany_construction=?,  " + 
                            "othercompany_start_date=?,  " + 
                            "othercompany_end_date=?,  " + 
                            "othercompany_amt=?,  " + 
                            "sale_amt=?,  " + 
                            "bigo=?,year_class=?  where sbcr_unq_num=? " +
                            "          and othercompany_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_othercompany_seq);
      gpstatement.bindColumn(3, idx_owner);
      gpstatement.bindColumn(4, idx_profession_wbs_name);
      gpstatement.bindColumn(5, idx_othercompany_construction);
      gpstatement.bindColumn(6, idx_othercompany_start_date);
      gpstatement.bindColumn(7, idx_othercompany_end_date);
      gpstatement.bindColumn(8, idx_othercompany_amt);
      gpstatement.bindColumn(9, idx_sale_amt);
      gpstatement.bindColumn(10, idx_bigo);
      gpstatement.bindColumn(11, idx_year_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_sbcr_unq_num);
      gpstatement.bindColumn(13, idx_key_othercompany_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_req_const where sbcr_unq_num=? " +
      											"       and othercompany_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_key_othercompany_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>