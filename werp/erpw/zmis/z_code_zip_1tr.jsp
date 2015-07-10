<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_code_zip_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_zipcode = dSet.indexOfColumn("zipcode");
   	int idx_sido = dSet.indexOfColumn("sido");
   	int idx_gugun = dSet.indexOfColumn("gugun");
   	int idx_dong = dSet.indexOfColumn("dong");
   	int idx_bunji = dSet.indexOfColumn("bunji");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_code_zip ( seq," + 
                    "zipcode," + 
                    "sido," + 
                    "gugun," + 
                    "dong," + 
                    "bunji," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_seq);
      gpstatement.bindColumn(2, idx_zipcode);
      gpstatement.bindColumn(3, idx_sido);
      gpstatement.bindColumn(4, idx_gugun);
      gpstatement.bindColumn(5, idx_dong);
      gpstatement.bindColumn(6, idx_bunji);
      gpstatement.bindColumn(7, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_zip set " + 
                            "seq=?,  " + 
                            "zipcode=?,  " + 
                            "sido=?,  " + 
                            "gugun=?,  " + 
                            "dong=?,  " + 
                            "bunji=?,  " + 
                            "remark=?  where seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_seq);
      gpstatement.bindColumn(2, idx_zipcode);
      gpstatement.bindColumn(3, idx_sido);
      gpstatement.bindColumn(4, idx_gugun);
      gpstatement.bindColumn(5, idx_dong);
      gpstatement.bindColumn(6, idx_bunji);
      gpstatement.bindColumn(7, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_zip where seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>