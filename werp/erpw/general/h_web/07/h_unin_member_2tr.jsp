<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_unin_member_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_union_id = dSet.indexOfColumn("union_id");
   	int idx_union_seq = dSet.indexOfColumn("union_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr1 = dSet.indexOfColumn("addr1");
   	int idx_addr2 = dSet.indexOfColumn("addr2");
   	int idx_build_no = dSet.indexOfColumn("build_no");
   	int idx_build_square = dSet.indexOfColumn("build_square");
   	int idx_grand_square = dSet.indexOfColumn("grand_square");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_UNIN_MEMBER_CONSTRUCT ( dept_code," + 
                    "sell_code," + 
                    "union_code," + 
                    "union_id," + 
                    "union_seq," + 
                    "seq," + 
                    "zip_code," + 
                    "addr1," + 
                    "addr2," + 
                    "build_no," + 
                    "build_square," + 
                    "grand_square )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_zip_code);
      gpstatement.bindColumn(8, idx_addr1);
      gpstatement.bindColumn(9, idx_addr2);
      gpstatement.bindColumn(10, idx_build_no);
      gpstatement.bindColumn(11, idx_build_square);
      gpstatement.bindColumn(12, idx_grand_square);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_member_construct set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " + 
                            "union_id=?,  " + 
                            "union_seq=?,  " + 
                            "seq=?,  " + 
                            "zip_code=?,  " + 
                            "addr1=?,  " + 
                            "addr2=?,  " + 
                            "build_no=?,  " + 
                            "build_square=?,  " + 
                            "grand_square=?  where dept_code=? " +
                            "                  and sell_code=? " +
                            "                  and union_code=? " +
                            "                  and union_id=? " +
                            "                  and union_seq=? " +
                            "                  and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_zip_code);
      gpstatement.bindColumn(8, idx_addr1);
      gpstatement.bindColumn(9, idx_addr2);
      gpstatement.bindColumn(10, idx_build_no);
      gpstatement.bindColumn(11, idx_build_square);
      gpstatement.bindColumn(12, idx_grand_square);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_sell_code);
      gpstatement.bindColumn(15, idx_union_code);
      gpstatement.bindColumn(16, idx_union_id);
      gpstatement.bindColumn(17, idx_union_seq);
      gpstatement.bindColumn(18, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_unin_member_construct where dept_code=? " + 
                            "                  and sell_code=? " +
                            "                  and union_code=? " +
                            "                  and union_id=? " +
                            "                  and union_seq=? " +
                            "                  and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>