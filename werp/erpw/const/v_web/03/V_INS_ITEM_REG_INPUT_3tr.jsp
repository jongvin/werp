<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_INS_ITEM_REG_INPUT_3tr"); gpstatement.gp_dataset = dSet;
   	int idx_quality_ins_code = dSet.indexOfColumn("quality_ins_code");
   	int idx_quality_section = dSet.indexOfColumn("quality_section");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_point = dSet.indexOfColumn("point");

	 int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_INS_ITEM_REG_DETAIL ( quality_ins_code," + 
                    "quality_section ,  " +
                    "seq  , " +
                    "d_seq  , " +
                    "contents  , " +
						  "point  ) " ; 
		sSql = sSql + " VALUES ( :1, :2 , :3 , :4 , :5, :6) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section);
		gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_d_seq);
		gpstatement.bindColumn(5, idx_contents);
      gpstatement.bindColumn(6, idx_point);
		stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_INS_ITEM_REG_DETAIL set " + 
                            "contents=?,  " + 
									 "point =?   " +
                            "where quality_ins_code=? " + 
                            "and quality_section=? "+ 
                            "and seq=? "+ 
                            "and d_seq=? "; 
		
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_contents);
      gpstatement.bindColumn(2, idx_point);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(3, idx_quality_ins_code);
		gpstatement.bindColumn(4, idx_quality_section);
		gpstatement.bindColumn(5, idx_seq);
		gpstatement.bindColumn(6, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_INS_ITEM_REG_DETAIL " +
                             "where quality_ins_code=? " + 
                            "and quality_section=? "+ 
                            "and seq=? "+ 
                            "and d_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(1, idx_quality_ins_code);
		gpstatement.bindColumn(2, idx_quality_section);
		gpstatement.bindColumn(3, idx_seq);
		gpstatement.bindColumn(4, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>