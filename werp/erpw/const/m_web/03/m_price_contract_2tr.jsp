<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_price_contract_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_seq_num = dSet.indexOfColumn("seq_num");
   	int idx_d_seq_num = dSet.indexOfColumn("d_seq_num");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_rent_section = dSet.indexOfColumn("rent_section");
   	int idx_input_section = dSet.indexOfColumn("input_section");
   	int idx_unitcost = dSet.indexOfColumn("unitcost");
   	int idx_standard_amt = dSet.indexOfColumn("standard_amt");
   	int idx_loss_amt = dSet.indexOfColumn("loss_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_PRICE_CONTRACT_DETAIL ( year," + 
                    "sbcr_code," + 
                    "seq_num," + 
                    "d_seq_num," + 
                    "mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "rent_section," + 
                    "input_section," + 
                    "unitcost," + 
                    "standard_amt," + 
                    "loss_amt," + 
                    "remark" + 
                    " )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 , :9 , :10 , :11 , :12, :13, :14) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_year);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_seq_num);
      gpstatement.bindColumn(4, idx_d_seq_num);
      gpstatement.bindColumn(5, idx_mtrcode);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_ssize);
      gpstatement.bindColumn(8, idx_unitcode);
      gpstatement.bindColumn(9, idx_rent_section);
      gpstatement.bindColumn(10, idx_input_section);
      gpstatement.bindColumn(11, idx_unitcost);
      gpstatement.bindColumn(12, idx_standard_amt);
      gpstatement.bindColumn(13, idx_loss_amt);
      gpstatement.bindColumn(14, idx_remark);
		stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update M_PRICE_CONTRACT_DETAIL set " + 
                    "mtrcode=?," + 
                    "name=?," + 
                    "ssize=?," + 
                    "unitcode=?," + 
                    "rent_section=?," + 
                    "input_section=?," + 
                    "unitcost=?," + 
                    "standard_amt=?," + 
                    "loss_amt=?," + 
                    "remark=?" + 
						 "where  " +
						 "       year=? " +
						 "   and sbcr_code=?" +
						 "   and seq_num=? "+  
						 "   and d_seq_num=? ";  

		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_mtrcode);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_ssize);
      gpstatement.bindColumn(4, idx_unitcode);
      gpstatement.bindColumn(5, idx_rent_section);
      gpstatement.bindColumn(6, idx_input_section);
      gpstatement.bindColumn(7, idx_unitcost);
      gpstatement.bindColumn(8, idx_standard_amt);
      gpstatement.bindColumn(9, idx_loss_amt);
      gpstatement.bindColumn(10, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_year);
      gpstatement.bindColumn(12, idx_sbcr_code);
      gpstatement.bindColumn(13, idx_seq_num);
      gpstatement.bindColumn(14, idx_d_seq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from M_PRICE_CONTRACT_DETAIL " +
						 "where  " +
						 "       year=? " +
						 "   and sbcr_code=?" +
						 "   and seq_num=? "+  
						 "   and d_seq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_year);
      gpstatement.bindColumn(2, idx_sbcr_code);
      gpstatement.bindColumn(3, idx_seq_num);
      gpstatement.bindColumn(4, idx_d_seq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>