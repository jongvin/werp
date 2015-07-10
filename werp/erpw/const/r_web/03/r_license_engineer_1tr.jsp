<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_license_engineer_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_license_class_code = dSet.indexOfColumn("license_class_code");
   	int idx_license_kind_code = dSet.indexOfColumn("license_kind_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_engineer_empno = dSet.indexOfColumn("engineer_empno");
   	int idx_key_engineer_empno = dSet.indexOfColumn("key_engineer_empno");
   	int idx_regist_tag = dSet.indexOfColumn("regist_tag");
   	int idx_license_term = dSet.indexOfColumn("license_term");
   	int idx_engineer_name = dSet.indexOfColumn("engineer_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_GENERAL_LICENSE_ENGINEER ( license_class_code," + 
                    "license_kind_code," + 
                    "seq," + 
                    "engineer_empno," + 
                    "regist_tag," + 
                    "license_term," + 
                    "engineer_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_class_code);
      gpstatement.bindColumn(2, idx_license_kind_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_engineer_empno);
      gpstatement.bindColumn(5, idx_regist_tag);
      gpstatement.bindColumn(6, idx_license_term);
      gpstatement.bindColumn(7, idx_engineer_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_general_license_engineer set " + 
                            "license_class_code=?,  " + 
                            "license_kind_code=?,  " + 
                            "seq=?,  " + 
                            "engineer_empno=?,  " + 
                            "regist_tag=?,  " + 
                            "license_term=?,  " + 
                            "engineer_name=?  where license_class_code=? " +
                            " and license_kind_code=? " +
                            " and seq=? " +
                            " and engineer_empno=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_class_code);
      gpstatement.bindColumn(2, idx_license_kind_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_engineer_empno);
      gpstatement.bindColumn(5, idx_regist_tag);
      gpstatement.bindColumn(6, idx_license_term);
      gpstatement.bindColumn(7, idx_engineer_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_license_class_code);
      gpstatement.bindColumn(9, idx_license_kind_code);
      gpstatement.bindColumn(10, idx_seq);
      gpstatement.bindColumn(11, idx_key_engineer_empno);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_general_license_engineer where license_class_code=? " +
                            " and license_kind_code=? " +
                            " and seq=? " +
                            " and engineer_empno=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_license_class_code);
      gpstatement.bindColumn(2, idx_license_kind_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_key_engineer_empno);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>