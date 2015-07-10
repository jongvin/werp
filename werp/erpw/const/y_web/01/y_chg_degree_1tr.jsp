<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_chg_degree_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_chg_title = dSet.indexOfColumn("chg_title");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_process_yn = dSet.indexOfColumn("process_yn");
   	int idx_work_dt = dSet.indexOfColumn("work_dt");
   	int idx_request_dt = dSet.indexOfColumn("request_dt");
   	int idx_approve_dt = dSet.indexOfColumn("approve_dt");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_charge_name = dSet.indexOfColumn("charge_name");
   	int idx_input_dt = dSet.indexOfColumn("input_dt");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_chg_class = dSet.indexOfColumn("chg_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_chg_degree ( dept_code," + 
                    "chg_no_seq," + 
                    "chg_degree," + 
                    "chg_title," + 
                    "approve_class," + 
                    "process_yn," + 
                    "work_dt," + 
                    "request_dt," + 
                    "approve_dt," + 
                    "cnt_amt," + 
                    "remark," + 
                    "charge_name," + 
                    "input_dt," + 
                    "input_name, " + 
                    "amt,chg_class )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, TO_DATE(:7,'YYYY.MM.DD'), TO_DATE(:8,'YYYY.MM.DD'), TO_DATE(:9,'YYYY.MM.DD'), :10, :11, :12, TO_DATE(:13,'YYYY.MM.DD'), :14 ,:15, :16) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_chg_title);
      gpstatement.bindColumn(5, idx_approve_class);
      gpstatement.bindColumn(6, idx_process_yn);
      gpstatement.bindColumn(7, idx_work_dt);
      gpstatement.bindColumn(8, idx_request_dt);
      gpstatement.bindColumn(9, idx_approve_dt);
      gpstatement.bindColumn(10, idx_cnt_amt);
      gpstatement.bindColumn(11, idx_remark);
      gpstatement.bindColumn(12, idx_charge_name);
      gpstatement.bindColumn(13, idx_input_dt);
      gpstatement.bindColumn(14, idx_input_name);
      gpstatement.bindColumn(15, idx_amt);
      gpstatement.bindColumn(16, idx_chg_class);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update y_chg_degree set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "chg_degree=?,  " + 
                            "chg_title=?,  " + 
                            "approve_class=?,  " + 
                            "process_yn=?,  " + 
                            "work_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "request_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "approve_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "cnt_amt=?,  " + 
                            "remark=?,  " + 
                            "charge_name=?,  " + 
                            "input_dt=TO_DATE(?,'YYYY.MM.DD'),  " + 
                            "input_name=?, " + 
                            "amt=?,chg_class=? " + 
                            "  where (dept_code=? and chg_no_seq=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_chg_title);
      gpstatement.bindColumn(5, idx_approve_class);
      gpstatement.bindColumn(6, idx_process_yn);
      gpstatement.bindColumn(7, idx_work_dt);
      gpstatement.bindColumn(8, idx_request_dt);
      gpstatement.bindColumn(9, idx_approve_dt);
      gpstatement.bindColumn(10, idx_cnt_amt);
      gpstatement.bindColumn(11, idx_remark);
      gpstatement.bindColumn(12, idx_charge_name);
      gpstatement.bindColumn(13, idx_input_dt);
      gpstatement.bindColumn(14, idx_input_name);
      gpstatement.bindColumn(15, idx_amt);
      gpstatement.bindColumn(16, idx_chg_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(17, idx_dept_code);
      gpstatement.bindColumn(18, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from y_chg_degree where (dept_code=? and chg_no_seq=?)"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>