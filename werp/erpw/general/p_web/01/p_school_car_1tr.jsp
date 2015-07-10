<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_school_car_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_school_car_code = dSet.indexOfColumn("school_car_code");
   	int idx_school_car_name = dSet.indexOfColumn("school_car_name");
   	int idx_old_school_car_code = dSet.indexOfColumn("old_school_car_code");
   	int idx_school_div_code = dSet.indexOfColumn("school_div_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_school_car ( school_car_code," + 
                    "school_car_name," + 
                    "old_school_car_code," + 
                    "school_div_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_school_car_code);
      gpstatement.bindColumn(2, idx_school_car_name);
      gpstatement.bindColumn(3, idx_old_school_car_code);
      gpstatement.bindColumn(4, idx_school_div_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update p_code_school_car set " + 
                            "school_car_code=?,  " + 
                            "school_car_name=?,  " + 
                            "old_school_car_code=?,  " + 
                            "school_div_code=?  where school_car_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_school_car_code);
      gpstatement.bindColumn(2, idx_school_car_name);
      gpstatement.bindColumn(3, idx_old_school_car_code);
      gpstatement.bindColumn(4, idx_school_div_code);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(5, idx_school_car_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from p_code_school_car where school_car_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_school_car_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>