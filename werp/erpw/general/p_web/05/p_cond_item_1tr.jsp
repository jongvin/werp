<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_cond_item_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_item_code = dSet.indexOfColumn("item_code");
   	int idx_item_name = dSet.indexOfColumn("item_name");
   	int idx_table_name = dSet.indexOfColumn("table_name");
   	int idx_col_name = dSet.indexOfColumn("col_name");
   	int idx_item_div = dSet.indexOfColumn("item_div");
   	int idx_item_type = dSet.indexOfColumn("item_type");
   	int idx_code_table_name = dSet.indexOfColumn("code_table_name");
   	int idx_code_name = dSet.indexOfColumn("code_name");
   	int idx_attr_name = dSet.indexOfColumn("attr_name");
   	int idx_width = dSet.indexOfColumn("width");
   	int idx_sort = dSet.indexOfColumn("sort");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_cond_item ( item_code," + 
                    "item_name," + 
                    "table_name," + 
                    "col_name," + 
                    "item_div," + 
                    "item_type," + 
                    "code_table_name," + 
                    "code_name," + 
                    "attr_name,width,sort )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ,:11) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_item_code);
      gpstatement.bindColumn(2, idx_item_name);
      gpstatement.bindColumn(3, idx_table_name);
      gpstatement.bindColumn(4, idx_col_name);
      gpstatement.bindColumn(5, idx_item_div);
      gpstatement.bindColumn(6, idx_item_type);
      gpstatement.bindColumn(7, idx_code_table_name);
      gpstatement.bindColumn(8, idx_code_name);
      gpstatement.bindColumn(9, idx_attr_name);
      gpstatement.bindColumn(10, idx_width);
      gpstatement.bindColumn(11, idx_sort);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_cond_item set " + 
                            "item_code=?,  " + 
                            "item_name=?,  " + 
                            "table_name=?,  " + 
                            "col_name=?,  " + 
                            "item_div=?,  " + 
                            "item_type=?,  " + 
                            "code_table_name=?,  " + 
                            "code_name=?,  " + 
                            "attr_name=?,width=?,sort=?  where item_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_item_code);
      gpstatement.bindColumn(2, idx_item_name);
      gpstatement.bindColumn(3, idx_table_name);
      gpstatement.bindColumn(4, idx_col_name);
      gpstatement.bindColumn(5, idx_item_div);
      gpstatement.bindColumn(6, idx_item_type);
      gpstatement.bindColumn(7, idx_code_table_name);
      gpstatement.bindColumn(8, idx_code_name);
      gpstatement.bindColumn(9, idx_attr_name);
      gpstatement.bindColumn(10, idx_width);
      gpstatement.bindColumn(11, idx_sort);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_item_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_cond_item where item_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_item_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>