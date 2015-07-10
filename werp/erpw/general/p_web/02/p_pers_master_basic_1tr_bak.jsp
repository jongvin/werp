<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_basic_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_empname_chi = dSet.indexOfColumn("empname_chi");
   	int idx_empname_eng = dSet.indexOfColumn("empname_eng");
   	int idx_employ_code = dSet.indexOfColumn("employ_code");
   	int idx_newface_div = dSet.indexOfColumn("newface_div");
   	int idx_employ_div_code = dSet.indexOfColumn("employ_div_code");
   	int idx_recom_er_name = dSet.indexOfColumn("recom_er_name");
   	int idx_recom_er_relation = dSet.indexOfColumn("recom_er_relation");
   	int idx_recom_er_job = dSet.indexOfColumn("recom_er_job");
   	int idx_recom_er_title = dSet.indexOfColumn("recom_er_title");
   	int idx_contract_sdate = dSet.indexOfColumn("contract_sdate");
   	int idx_contract_edate = dSet.indexOfColumn("contract_edate");
   	int idx_contract_div = dSet.indexOfColumn("contract_div");
   	int idx_mid_settle_date = dSet.indexOfColumn("mid_settle_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_master ( emp_no," + 
                    "empname_chi," + 
                    "empname_eng," + 
                    "employ_code," + 
                    "newface_div," + 
                    "employ_div_code," + 
                    "recom_er_name," + 
                    "recom_er_relation," + 
                    "recom_er_job," + 
                    "recom_er_title," + 
                    "contract_sdate," + 
                    "contract_edate," + 
                    "contract_div," + 
                    "mid_settle_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_empname_chi);
      gpstatement.bindColumn(3, idx_empname_eng);
      gpstatement.bindColumn(4, idx_employ_code);
      gpstatement.bindColumn(5, idx_newface_div);
      gpstatement.bindColumn(6, idx_employ_div_code);
      gpstatement.bindColumn(7, idx_recom_er_name);
      gpstatement.bindColumn(8, idx_recom_er_relation);
      gpstatement.bindColumn(9, idx_recom_er_job);
      gpstatement.bindColumn(10, idx_recom_er_title);
      gpstatement.bindColumn(11, idx_contract_sdate);
      gpstatement.bindColumn(12, idx_contract_edate);
      gpstatement.bindColumn(13, idx_contract_div);
      gpstatement.bindColumn(14, idx_mid_settle_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_master set " + 
                            "emp_no=?,  " + 
                            "empname_chi=?,  " + 
                            "empname_eng=?,  " + 
                            "employ_code=?,  " + 
			                "newface_div=?,  " + 
			                "employ_div_code=?,  " + 
			                "recom_er_name=?,  " + 
			                "recom_er_relation=?,  " + 
                            "recom_er_job=?,  " + 
                            "recom_er_title=?,  " + 
                            "contract_sdate=?,  " + 
                            "contract_edate=?,  " + 
                            "contract_div=?,  " + 
                            "mid_settle_date=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_empname_chi);
      gpstatement.bindColumn(3, idx_empname_eng);
      gpstatement.bindColumn(4, idx_employ_code);
      gpstatement.bindColumn(5, idx_newface_div);
      gpstatement.bindColumn(6, idx_employ_div_code);
      gpstatement.bindColumn(7, idx_recom_er_name);
      gpstatement.bindColumn(8, idx_recom_er_relation);
      gpstatement.bindColumn(9, idx_recom_er_job);
      gpstatement.bindColumn(10, idx_recom_er_title);      
      gpstatement.bindColumn(11, idx_contract_sdate);
      gpstatement.bindColumn(12, idx_contract_edate);
      gpstatement.bindColumn(13, idx_contract_div);
      gpstatement.bindColumn(14, idx_mid_settle_date);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_master where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>