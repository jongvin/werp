<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_sa_eval_monthly_pop_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_item_code = dSet.indexOfColumn("item_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_b_point = dSet.indexOfColumn("b_point");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_n_a = dSet.indexOfColumn("n_a");
   	int idx_point_2 = dSet.indexOfColumn("point_2");
   	int idx_point_1 = dSet.indexOfColumn("point_1");
   	int idx_point_0 = dSet.indexOfColumn("point_0");
   	int idx_p_count = dSet.indexOfColumn("p_count");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_ol_point = dSet.indexOfColumn("ol_point");
   	int idx_or_item = dSet.indexOfColumn("or_item");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_opinion_detail ( dept_code," + 
                    "yymm," + 
                    "part_code," + 
                    "item_code," + 
                    "seq," +
                    "d_seq," +
                    "contents,"+
                    "or_point," + 
                    "remark," +
                    "n_a," +
                    "point_2," +
                    "point_1, " +
                    "point_0, " +
                    "p_count )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_part_code);
      gpstatement.bindColumn(4, idx_item_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_d_seq);
      gpstatement.bindColumn(7, idx_contents);
      gpstatement.bindColumn(8, idx_b_point);
      gpstatement.bindColumn(9, idx_remark);
      gpstatement.bindColumn(10, idx_n_a);
      gpstatement.bindColumn(11, idx_point_2);
      gpstatement.bindColumn(12, idx_point_1);
      gpstatement.bindColumn(13, idx_point_0);
      gpstatement.bindColumn(14, idx_p_count);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
   	String ls_calss = rows.getString(idx_class);
		if(ls_calss.equals("1")) 
		{
			 String sSql = "update e_opinion_detail set " +                             
									  "or_point=?," + 
									  "n_a=?," +
									  "point_2=?," +
									  "point_1=?, " +
									  "point_0=?, " +
									  "p_count=?, " +
									  "remark=?  where dept_code=? and yymm=? and item_code=? and seq=? and d_seq=? "; 
			stmt = conn.prepareStatement(sSql); 
			gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_b_point);
			gpstatement.bindColumn(2, idx_n_a);
			gpstatement.bindColumn(3, idx_point_2);
			gpstatement.bindColumn(4, idx_point_1);
			gpstatement.bindColumn(5, idx_point_0);
			gpstatement.bindColumn(6, idx_p_count);
			gpstatement.bindColumn(7, idx_remark);
	 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
			gpstatement.bindColumn(8, idx_dept_code);
			gpstatement.bindColumn(9, idx_yymm);
			gpstatement.bindColumn(10, idx_item_code);
			gpstatement.bindColumn(11, idx_seq);
			gpstatement.bindColumn(12, idx_d_seq);
			stmt.executeUpdate();
			stmt.close();
		}
		else if(ls_calss.equals("2")) 
		{
		//�������� ������Ʈ
			String sSql = "update e_opinion_minus_detail set " +                             
									  "or_point=?," + 
								     "contents=?," +
									  "remark=?  where dept_code=? and yymm=? and seq=?";  
			stmt = conn.prepareStatement(sSql); 
			gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_ol_point);
			gpstatement.bindColumn(2, idx_or_item);
			gpstatement.bindColumn(3, idx_remark);
	 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
			gpstatement.bindColumn(4, idx_dept_code);
			gpstatement.bindColumn(5, idx_yymm);
			gpstatement.bindColumn(6, idx_seq);
			stmt.executeUpdate();
			stmt.close();
		}

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from e_opinion_detail  where dept_code=? and yymm=? and item_code=? and seq=? and d_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_item_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_d_seq);   
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>