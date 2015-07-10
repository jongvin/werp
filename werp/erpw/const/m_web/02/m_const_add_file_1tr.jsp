<%@ page session="true"  import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
String dir = (String) session.getAttribute("dir");
     GauceDataSet dSet = req.getGauceDataSet("m_const_add_file_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_con_add_doc_id = dSet.indexOfColumn("con_add_doc_id");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cst_doc_no = dSet.indexOfColumn("cst_doc_no");
   	int idx_mod_no = dSet.indexOfColumn("mod_no");
   	int idx_file_map_id = dSet.indexOfColumn("file_map_id");
   	int idx_unique_file_name = dSet.indexOfColumn("unique_file_name");
   	int idx_file_path = dSet.indexOfColumn("file_path");
   	int idx_file_ext = dSet.indexOfColumn("file_ext");
   	int idx_file_size = dSet.indexOfColumn("file_size");
   	int idx_file_name = dSet.indexOfColumn("file_name");
   	int idx_mine_type = dSet.indexOfColumn("mine_type");
   	int idx_contents_type = dSet.indexOfColumn("contents_type");
   	int idx_contents_disp = dSet.indexOfColumn("contents_disp");
   	int idx_sub_mine_type = dSet.indexOfColumn("sub_mine_type");
   	int idx_hash_val = dSet.indexOfColumn("hash_val");
   	int idx_auto_cre_yn = dSet.indexOfColumn("auto_cre_yn");
   	int idx_cst_info_id = dSet.indexOfColumn("cst_info_id");
   	int idx_cre_by = dSet.indexOfColumn("cre_by");
   	int idx_cre_date = dSet.indexOfColumn("cre_date");
   	int idx_upd_by = dSet.indexOfColumn("upd_by");
   	int idx_upd_date = dSet.indexOfColumn("upd_date");
   	int idx_cdir = dSet.indexOfColumn("cdir");
   	int idx_bonsa_sign_val = dSet.indexOfColumn("bonsa_sign_val");
   	int idx_corp_sign_val = dSet.indexOfColumn("corp_sign_val");
   	int idx_temp1 = dSet.indexOfColumn("temp1");
   	int idx_temp2 = dSet.indexOfColumn("temp2");
      GauceDataRow[] rowx = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CONST_ADD_FILE ( con_add_doc_id," + 
                    "dept_code," + 
                    "cst_doc_no," + 
                    "mod_no," + 
                    "file_map_id," + 
                    "unique_file_name," + 
                    "file_path," + 
                    "file_ext," + 
                    "file_size," + 
                    "file_name," + 
                    "mine_type," + 
                    "contents_type," + 
                    "contents_disp," + 
                    "sub_mine_type," + 
                    "hash_val," + 
                    "bonsa_sign_val," +
                    "corp_sign_val," +
                    "auto_cre_yn," + 
                    "cst_info_id," + 
                    "cre_by," + 
                    "cre_date," + 
                    "upd_by," + 
                    "upd_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22,:23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_con_add_doc_id);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_cst_doc_no);
      gpstatement.bindColumn(4, idx_mod_no);
      gpstatement.bindColumn(5, idx_file_map_id);
      gpstatement.bindColumn(6, idx_unique_file_name);
      gpstatement.bindColumn(7, idx_file_path);
      gpstatement.bindColumn(8, idx_file_ext);
      gpstatement.bindColumn(9, idx_file_size);
      gpstatement.bindColumn(10, idx_file_name);
      gpstatement.bindColumn(11, idx_mine_type);
      gpstatement.bindColumn(12, idx_contents_type);
      gpstatement.bindColumn(13, idx_contents_disp);
      gpstatement.bindColumn(14, idx_sub_mine_type);
      gpstatement.bindColumn(15, idx_hash_val);
      gpstatement.bindColumn(16, idx_bonsa_sign_val);
      gpstatement.bindColumn(17, idx_corp_sign_val);
      gpstatement.bindColumn(18, idx_auto_cre_yn);
      gpstatement.bindColumn(19, idx_cst_info_id);
      gpstatement.bindColumn(20, idx_cre_by);
      gpstatement.bindColumn(21, idx_cre_date);
      gpstatement.bindColumn(22, idx_upd_by);
      gpstatement.bindColumn(23, idx_upd_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_const_add_file set " + 
                            "con_add_doc_id=?,  " + 
                            "dept_code=?,  " + 
                            "cst_doc_no=?,  " + 
                            "mod_no=?,  " + 
                            "file_map_id=?,  " + 
                            "unique_file_name=?,  " + 
                            "file_path=?,  " + 
                            "file_ext=?,  " + 
                            "file_size=?,  " + 
                            "file_name=?,  " + 
                            "mine_type=?,  " + 
                            "contents_type=?,  " + 
                            "contents_disp=?,  " + 
                            "sub_mine_type=?,  " + 
                            "hash_val=?,  " + 
                            "bonsa_sign_val=? || ?," +
                            "corp_sign_val=?," +
                            "auto_cre_yn=?,  " + 
                            "cst_info_id=?,  " + 
                            "cre_by=?,  " + 
                            "cre_date=?,  " + 
                            "upd_by=?,  " + 
                            "upd_date=?  where con_add_doc_id=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_con_add_doc_id);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_cst_doc_no);
      gpstatement.bindColumn(4, idx_mod_no);
      gpstatement.bindColumn(5, idx_file_map_id);
      gpstatement.bindColumn(6, idx_unique_file_name);
      gpstatement.bindColumn(7, idx_file_path);
      gpstatement.bindColumn(8, idx_file_ext);
      gpstatement.bindColumn(9, idx_file_size);
      gpstatement.bindColumn(10, idx_file_name);
      gpstatement.bindColumn(11, idx_mine_type);
      gpstatement.bindColumn(12, idx_contents_type);
      gpstatement.bindColumn(13, idx_contents_disp);
      gpstatement.bindColumn(14, idx_sub_mine_type);
      gpstatement.bindColumn(15, idx_hash_val);
      gpstatement.bindColumn(16, idx_temp1);
      gpstatement.bindColumn(17, idx_temp2);
      gpstatement.bindColumn(18, idx_corp_sign_val);
      gpstatement.bindColumn(19, idx_auto_cre_yn);
      gpstatement.bindColumn(20, idx_cst_info_id);
      gpstatement.bindColumn(21, idx_cre_by);
      gpstatement.bindColumn(22, idx_cre_date);
      gpstatement.bindColumn(23, idx_upd_by);
      gpstatement.bindColumn(24, idx_upd_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(25, idx_con_add_doc_id);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_const_add_file where con_add_doc_id=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_con_add_doc_id);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>