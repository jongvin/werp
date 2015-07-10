<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_license_info_cj_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_company = dSet.indexOfColumn("company");
   	int idx_empno = dSet.indexOfColumn("empno");
   	int idx_lic_cd = dSet.indexOfColumn("lic_cd");
   	int idx_lic_grd = dSet.indexOfColumn("lic_grd");
   	int idx_pre_person = dSet.indexOfColumn("pre_person");
   	int idx_remark = dSet.indexOfColumn("remark1");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_LICENSE_INFO_CJ_DETAIL ( company," + 
                    "empno," + 					
						  "lic_cd," + 			
						  "lic_grd," + 			
						  "pre_person," + 
						  "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_company);
      gpstatement.bindColumn(2, idx_empno);
      gpstatement.bindColumn(3, idx_lic_cd);
      gpstatement.bindColumn(4, idx_lic_grd);
      gpstatement.bindColumn(5, idx_pre_person);
      gpstatement.bindColumn(6, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update R_LICENSE_INFO_CJ_DETAIL set " + 
                    "company=?," + 
                    "empno=?," + 					
						  "lic_cd=?," + 			
						  "lic_grd=?," + 			
						  "pre_person=?," +
						  "remark=?  where company=? and empno=? and lic_cd=? and lic_grd=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_company);
      gpstatement.bindColumn(2, idx_empno);
      gpstatement.bindColumn(3, idx_lic_cd);
      gpstatement.bindColumn(4, idx_lic_grd);
      gpstatement.bindColumn(5, idx_pre_person);
      gpstatement.bindColumn(6, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_company);
      gpstatement.bindColumn(8, idx_empno);
      gpstatement.bindColumn(9, idx_lic_cd);
      gpstatement.bindColumn(10, idx_lic_grd);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from R_LICENSE_INFO_CJ_DETAIL where company=? and empno=? and lic_cd=? and lic_grd=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_company);
      gpstatement.bindColumn(2, idx_empno);
      gpstatement.bindColumn(3, idx_lic_cd);
      gpstatement.bindColumn(4, idx_lic_grd);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>