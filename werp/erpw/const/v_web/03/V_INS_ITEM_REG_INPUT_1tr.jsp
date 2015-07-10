<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_INS_ITEM_REG_INPUT_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_quality_ins_code = dSet.indexOfColumn("quality_ins_code");
   	int idx_quality_section = dSet.indexOfColumn("quality_section");
   	int idx_quality_ins_name = dSet.indexOfColumn("quality_ins_name");
   	int idx_weight_point1 = dSet.indexOfColumn("weight_point1");
   	int idx_weight_point2 = dSet.indexOfColumn("weight_point2");
   	int idx_weight_point = dSet.indexOfColumn("weight_point");
   	int idx_COLUMN_SIZE = dSet.indexOfColumn("COLUMN_SIZE");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_INS_ITEM_REG_MASTER ( quality_ins_code," + 
                    "quality_section, " +
                    "quality_ins_name, " +
                    "weight_point1, " +
                    "weight_point2, " +
                    "weight_point, " +
                    "COLUMN_SIZE ) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section);
      gpstatement.bindColumn(3, idx_quality_ins_name);
      gpstatement.bindColumn(4, idx_weight_point1);
      gpstatement.bindColumn(5, idx_weight_point2);
      gpstatement.bindColumn(6, idx_weight_point);
		gpstatement.bindColumn(7, idx_COLUMN_SIZE);

      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_INS_ITEM_REG_MASTER set " + 
						  "   quality_ins_name=?,  " + 
						  "   weight_point1=?, " +
						  "   weight_point2=?, " +
						  "   weight_point=?, " +
						  "   COLUMN_SIZE=? " +
						  " where quality_ins_code=? " + 
						  " and quality_section=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_quality_ins_name);
      gpstatement.bindColumn(2, idx_weight_point1);
      gpstatement.bindColumn(3, idx_weight_point2);
      gpstatement.bindColumn(4, idx_weight_point);
		gpstatement.bindColumn(5, idx_COLUMN_SIZE);

 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_quality_ins_code);
      gpstatement.bindColumn(7, idx_quality_section);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_INS_ITEM_REG_MASTER where quality_ins_code=? " + 
							" and quality_section=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section);
		stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>