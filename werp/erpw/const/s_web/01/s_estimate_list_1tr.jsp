<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_estimate_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_recommender_department = dSet.indexOfColumn("recommender_department");
   	int idx_recommender_grade = dSet.indexOfColumn("recommender_grade");
   	int idx_recommender_name = dSet.indexOfColumn("recommender_name");
   	int idx_pr_yn = dSet.indexOfColumn("pr_yn");
   	int idx_est_yn = dSet.indexOfColumn("est_yn");
   	int idx_register_chk = dSet.indexOfColumn("register_chk");
   	int idx_noentry_chk = dSet.indexOfColumn("noentry_chk");
   	int idx_noentry_recommen = dSet.indexOfColumn("noentry_recommen");
   	int idx_noentry_merit = dSet.indexOfColumn("noentry_merit");
   	int idx_noentry_defect = dSet.indexOfColumn("noentry_defect");
   	int idx_noentry_recommender_note = dSet.indexOfColumn("noentry_recommender_note");
   	int idx_noentry_note = dSet.indexOfColumn("noentry_note");
   	int idx_noentry_yn_note = dSet.indexOfColumn("noentry_yn_note");
   	int idx_est_amt = dSet.indexOfColumn("est_amt");
   	int idx_ctrl_amt = dSet.indexOfColumn("ctrl_amt");
   	int idx_select_yn = dSet.indexOfColumn("select_yn");
   	int idx_charge_name = dSet.indexOfColumn("charge_name");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_cn_limit_amt = dSet.indexOfColumn("cn_limit_amt");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_re_est_yn = dSet.indexOfColumn("re_est_yn");
   	int idx_est_dt = dSet.indexOfColumn("est_dt");
   	int idx_re_est_dt = dSet.indexOfColumn("re_est_dt");
   	int idx_injung_yn = dSet.indexOfColumn("injung_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_estimate_list ( dept_code," + 
                    "order_number," + 
                    "sbcr_code," + 
                    "recommender_department," + 
                    "recommender_grade," + 
                    "recommender_name," + 
                    "pr_yn," + 
                    "est_yn," + 
                    "register_chk," + 
                    "noentry_chk," + 
                    "noentry_recommen," + 
                    "noentry_merit," + 
                    "noentry_defect," + 
                    "noentry_recommender_note," + 
                    "noentry_note," + 
                    "noentry_yn_note," + 
                    "est_amt," + 
                    "ctrl_amt," + 
                    "select_yn," + 
                    "charge_name," + 
                    "profession_wbs_code," + 
                    "cn_limit_amt," + 
                    "note , re_est_yn,est_dt,re_est_dt,injung_yn)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_recommender_department);
      gpstatement.bindColumn(5, idx_recommender_grade);
      gpstatement.bindColumn(6, idx_recommender_name);
      gpstatement.bindColumn(7, idx_pr_yn);
      gpstatement.bindColumn(8, idx_est_yn);
      gpstatement.bindColumn(9, idx_register_chk);
      gpstatement.bindColumn(10, idx_noentry_chk);
      gpstatement.bindColumn(11, idx_noentry_recommen);
      gpstatement.bindColumn(12, idx_noentry_merit);
      gpstatement.bindColumn(13, idx_noentry_defect);
      gpstatement.bindColumn(14, idx_noentry_recommender_note);
      gpstatement.bindColumn(15, idx_noentry_note);
      gpstatement.bindColumn(16, idx_noentry_yn_note);
      gpstatement.bindColumn(17, idx_est_amt);
      gpstatement.bindColumn(18, idx_ctrl_amt);
      gpstatement.bindColumn(19, idx_select_yn);
      gpstatement.bindColumn(20, idx_charge_name);
      gpstatement.bindColumn(21, idx_profession_wbs_code);
      gpstatement.bindColumn(22, idx_cn_limit_amt);
      gpstatement.bindColumn(23, idx_note);
      gpstatement.bindColumn(24, idx_re_est_yn);
      gpstatement.bindColumn(25, idx_est_dt);
      gpstatement.bindColumn(26, idx_re_est_dt);
      gpstatement.bindColumn(27, idx_injung_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_estimate_list set " + 
                            "dept_code=?,  " + 
                            "order_number=?,  " + 
                            "sbcr_code=?,  " + 
                            "recommender_department=?,  " + 
                            "recommender_grade=?,  " + 
                            "recommender_name=?,  " + 
                            "pr_yn=?,  " + 
                            "est_yn=?,  " + 
                            "register_chk=?,  " + 
                            "noentry_chk=?,  " + 
                            "noentry_recommen=?,  " + 
                            "noentry_merit=?,  " + 
                            "noentry_defect=?,  " + 
                            "noentry_recommender_note=?,  " + 
                            "noentry_note=?,  " + 
                            "noentry_yn_note=?,  " + 
                            "est_amt=?,  " + 
                            "ctrl_amt=?,  " + 
                            "select_yn=?,  " + 
                            "charge_name=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "cn_limit_amt=?,  " + 
                            "note=? ,re_est_yn=?,est_dt=?,re_est_dt=?,injung_yn=? where (dept_code=? and order_number=? and sbcr_code=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_recommender_department);
      gpstatement.bindColumn(5, idx_recommender_grade);
      gpstatement.bindColumn(6, idx_recommender_name);
      gpstatement.bindColumn(7, idx_pr_yn);
      gpstatement.bindColumn(8, idx_est_yn);
      gpstatement.bindColumn(9, idx_register_chk);
      gpstatement.bindColumn(10, idx_noentry_chk);
      gpstatement.bindColumn(11, idx_noentry_recommen);
      gpstatement.bindColumn(12, idx_noentry_merit);
      gpstatement.bindColumn(13, idx_noentry_defect);
      gpstatement.bindColumn(14, idx_noentry_recommender_note);
      gpstatement.bindColumn(15, idx_noentry_note);
      gpstatement.bindColumn(16, idx_noentry_yn_note);
      gpstatement.bindColumn(17, idx_est_amt);
      gpstatement.bindColumn(18, idx_ctrl_amt);
      gpstatement.bindColumn(19, idx_select_yn);
      gpstatement.bindColumn(20, idx_charge_name);
      gpstatement.bindColumn(21, idx_profession_wbs_code);
      gpstatement.bindColumn(22, idx_cn_limit_amt);
      gpstatement.bindColumn(23, idx_note);
      gpstatement.bindColumn(24, idx_re_est_yn);
      gpstatement.bindColumn(25, idx_est_dt);
      gpstatement.bindColumn(26, idx_re_est_dt);
      gpstatement.bindColumn(27, idx_injung_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(28, idx_dept_code);
      gpstatement.bindColumn(29, idx_order_number);
      gpstatement.bindColumn(30, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_estimate_list where (dept_code=? and order_number=? and sbcr_code=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_order_number);
      gpstatement.bindColumn(3, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>