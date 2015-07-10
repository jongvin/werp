<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_code_etc_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_class_tag = dSet.indexOfColumn("class_tag");
   	int idx_etc_code = dSet.indexOfColumn("etc_code");
   	int idx_detail_name = dSet.indexOfColumn("detail_name");
   	int idx_old_etc_code = dSet.indexOfColumn("old_etc_code");
   	int idx_old_code = dSet.indexOfColumn("old_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_etc_detail ( class_tag," + 
                    "etc_code," + 
                    "detail_name, old_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_etc_code);
      gpstatement.bindColumn(3, idx_detail_name);
      gpstatement.bindColumn(4, idx_old_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_etc_detail set " + 
                            "class_tag=?,  " + 
                            "etc_code=?,  " + 
                            "detail_name=?, old_code=?  where (class_tag=? and etc_code=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_etc_code);
      gpstatement.bindColumn(3, idx_detail_name);
      gpstatement.bindColumn(4, idx_old_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_class_tag);
      gpstatement.bindColumn(6, idx_old_etc_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_etc_detail where (class_tag=? and etc_code=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_old_etc_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>