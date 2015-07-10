<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_price_contract_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_seq_num = dSet.indexOfColumn("seq_num");
   	int idx_from_dt = dSet.indexOfColumn("from_dt");
   	int idx_to_dt = dSet.indexOfColumn("to_dt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_PRICE_CONTRACT ( year," + 
                    "sbcr_code," + 
                    "seq_num," + 
                    "from_dt," + 
                    "to_dt," + 
                    "remark" + 
						  " )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_year);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_seq_num);
      gpstatement.bindColumn(4, idx_from_dt);
      gpstatement.bindColumn(5, idx_to_dt);
      gpstatement.bindColumn(6, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update M_PRICE_CONTRACT set " + 
                            "sbcr_code=?,  " + 
                            "seq_num=?,  " + 
                            "from_dt=?,  " + 
                            "to_dt=?,  " + 
                            "remark=?  " + 
									 " where year=? " +
                            "                and sbcr_code=?" +
                            "                and seq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_seq_num);
      gpstatement.bindColumn(3, idx_from_dt);
      gpstatement.bindColumn(4, idx_to_dt);
      gpstatement.bindColumn(5, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_year);
      gpstatement.bindColumn(7, idx_sbcr_code);
      gpstatement.bindColumn(8, idx_seq_num);

      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from M_PRICE_CONTRACT  " +
									 " where year=? " +
                            "                and sbcr_code=?" +
                            "                and seq_num=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_year);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_seq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>