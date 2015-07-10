<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_slip_acc_code_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_key					= dSet.indexOfColumn("key");
	int idx_old_key					= dSet.indexOfColumn("old_key");
	int idx_전표구분			= dSet.indexOfColumn("전표구분");
	int idx_전표단위			= dSet.indexOfColumn("전표단위");
	int idx_차변_계정명칭 = dSet.indexOfColumn("차변_계정명칭");
	int idx_차변_계정코드 = dSet.indexOfColumn("차변_계정코드");
	int idx_대변_계정명칭 = dSet.indexOfColumn("대변_계정명칭");
	int idx_대변_계정코드 = dSet.indexOfColumn("대변_계정코드");
   	
	int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_slip_acc_code_table "+
			        "				( key," + 
					"				 전표구분," + 
					"				 전표단위," + 
					"				 차변_계정명칭," + 
					"				 차변_계정코드," + 
					"				 대변_계정명칭,"+
			        "				   대변_계정코드)"      ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_key					);
      gpstatement.bindColumn(2, idx_전표구분			);
	  gpstatement.bindColumn(3, idx_전표단위			);
	  gpstatement.bindColumn(4, idx_차변_계정명칭);
	  gpstatement.bindColumn(5, idx_차변_계정코드);
	  gpstatement.bindColumn(6, idx_대변_계정명칭);
	  gpstatement.bindColumn(7, idx_대변_계정코드);
      stmt.executeUpdate();			
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_slip_acc_code_table set " + 
	                        " KEY                   =?,"+
							" 전표구분          =?,"+
							" 전표단위          =?,"+
	 						" 차변_계정명칭 =?,"+
	 						" 차변_계정코드 =?,"+
	 						" 대변_계정명칭 =?,"+
	 						" 대변_계정코드 =?"+
                            " where key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_key					 );
      gpstatement.bindColumn(2, idx_전표구분			 );
	  gpstatement.bindColumn(3, idx_전표단위			 );
	  gpstatement.bindColumn(4, idx_차변_계정명칭 );
	  gpstatement.bindColumn(5, idx_차변_계정코드 );
	  gpstatement.bindColumn(6, idx_대변_계정명칭 );
	  gpstatement.bindColumn(7, idx_대변_계정코드 );
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_old_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_slip_acc_code_table where key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key					 );
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>