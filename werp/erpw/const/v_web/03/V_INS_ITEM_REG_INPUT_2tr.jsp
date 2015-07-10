<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_INS_ITEM_REG_INPUT_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_quality_ins_code = dSet.indexOfColumn("quality_ins_code");
   	int idx_quality_section = dSet.indexOfColumn("quality_section");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_section = dSet.indexOfColumn("section");
   	int idx_ins_item = dSet.indexOfColumn("ins_item");
   	int idx_place = dSet.indexOfColumn("place");
   	int idx_remark = dSet.indexOfColumn("remark");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO  V_INS_ITEM_REG ( quality_ins_code," + 
                    "quality_section," + 
                    "seq," + 
                    "part_code," + 
                    "wbs_code," + 
                    "section," + 
                    "ins_item," + 
                    "place," + 
                    "remark	) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section );
		gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_part_code);
      gpstatement.bindColumn(5, idx_wbs_code);
      gpstatement.bindColumn(6, idx_section);
      gpstatement.bindColumn(7, idx_ins_item);
      gpstatement.bindColumn(8, idx_place);
      gpstatement.bindColumn(9, idx_remark);

		stmt.executeUpdate();
      stmt.close();

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 String sSql = "update  V_INS_ITEM_REG set " + 
                            "part_code=?,  " + 
                            "wbs_code=?,  " + 
                            "section=?,  " + 
                            "ins_item=?,  " + 
                            "place=?,  " + 
                            "remark=?  " + 
                            "where quality_ins_code=? " +
                            " and quality_section=? "+ 
                            " and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_part_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_section);
      gpstatement.bindColumn(4, idx_ins_item);
      gpstatement.bindColumn(5, idx_place);
      gpstatement.bindColumn(6, idx_remark);
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_quality_ins_code);
      gpstatement.bindColumn(8, idx_quality_section );
		gpstatement.bindColumn(9, idx_seq);		
		stmt.executeUpdate();
      stmt.close();

	}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
		String sSql = "delete from  V_INS_ITEM_REG  where quality_ins_code=? " +
                            " and quality_section=? "+ 
                            " and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section );
		gpstatement.bindColumn(3, idx_seq);		
      stmt.executeUpdate();
      stmt.close();
	 }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>