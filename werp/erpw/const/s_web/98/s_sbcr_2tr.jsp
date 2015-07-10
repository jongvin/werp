<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_treatkind_code = dSet.indexOfColumn("treatkind_code");
   	int idx_selection_tag = dSet.indexOfColumn("selection_tag");
   	int idx_key_profession_wbs_code = dSet.indexOfColumn("key_profession_wbs_code");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_profession_wbs_name = dSet.indexOfColumn("profession_wbs_name");
   	int idx_treatkind_license_number = dSet.indexOfColumn("treatkind_license_number");
   	int idx_license_issue_date = dSet.indexOfColumn("license_issue_date");
   	int idx_region_code = dSet.indexOfColumn("region_code");
   	int idx_cn_grade1 = dSet.indexOfColumn("cn_grade1");
   	int idx_cn_grade_total1 = dSet.indexOfColumn("cn_grade_total1");
   	int idx_cn_limit_amt1 = dSet.indexOfColumn("cn_limit_amt1");
   	int idx_cn_grade2 = dSet.indexOfColumn("cn_grade2");
   	int idx_cn_grade_total2 = dSet.indexOfColumn("cn_grade_total2");
   	int idx_cn_limit_amt2 = dSet.indexOfColumn("cn_limit_amt2");
   	int idx_cn_grade3 = dSet.indexOfColumn("cn_grade3");
   	int idx_cn_grade_total3 = dSet.indexOfColumn("cn_grade_total3");
   	int idx_cn_limit_amt3 = dSet.indexOfColumn("cn_limit_amt3");
   	int idx_seq = dSet.indexOfColumn("seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_LICENSE_STATUS ( sbcr_code," + 
                    "treatkind_code," + 
                    "selection_tag," + 
                    "profession_wbs_code," + 
                    "profession_wbs_name," + 
                    "treatkind_license_number," + 
                    "license_issue_date," + 
                    "region_code," + 
                    "cn_grade1," + 
                    "cn_grade_total1," + 
                    "cn_limit_amt1," + 
                    "cn_grade2," + 
                    "cn_grade_total2," + 
                    "cn_limit_amt2," + 
                    "cn_grade3," + 
                    "cn_grade_total3," + 
                    "cn_limit_amt3,seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ,:18) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_treatkind_code);
      gpstatement.bindColumn(3, idx_selection_tag);
      gpstatement.bindColumn(4, idx_profession_wbs_code);
      gpstatement.bindColumn(5, idx_profession_wbs_name);
      gpstatement.bindColumn(6, idx_treatkind_license_number);
      gpstatement.bindColumn(7, idx_license_issue_date);
      gpstatement.bindColumn(8, idx_region_code);
      gpstatement.bindColumn(9, idx_cn_grade1);
      gpstatement.bindColumn(10, idx_cn_grade_total1);
      gpstatement.bindColumn(11, idx_cn_limit_amt1);
      gpstatement.bindColumn(12, idx_cn_grade2);
      gpstatement.bindColumn(13, idx_cn_grade_total2);
      gpstatement.bindColumn(14, idx_cn_limit_amt2);
      gpstatement.bindColumn(15, idx_cn_grade3);
      gpstatement.bindColumn(16, idx_cn_grade_total3);
      gpstatement.bindColumn(17, idx_cn_limit_amt3);
      gpstatement.bindColumn(18, idx_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update S_LICENSE_STATUS set " + 
                            "sbcr_code=?,  " + 
                            "treatkind_code=?,  " + 
                            "selection_tag=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "profession_wbs_name=?,  " + 
                            "treatkind_license_number=?,  " + 
                            "license_issue_date=?,  " + 
                            "region_code=?,  " + 
                            "cn_grade1=?,  " + 
                            "cn_grade_total1=?,  " + 
                            "cn_limit_amt1=?,  " + 
                            "cn_grade2=?,  " + 
                            "cn_grade_total2=?,  " + 
                            "cn_limit_amt2=?,  " + 
                            "cn_grade3=?,  " + 
                            "cn_grade_total3=?,  " + 
                            "cn_limit_amt3=?,seq=?  where sbcr_code=? " +
                            "                   and profession_wbs_code=? " +
                            "                   and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_treatkind_code);
      gpstatement.bindColumn(3, idx_selection_tag);
      gpstatement.bindColumn(4, idx_profession_wbs_code);
      gpstatement.bindColumn(5, idx_profession_wbs_name);
      gpstatement.bindColumn(6, idx_treatkind_license_number);
      gpstatement.bindColumn(7, idx_license_issue_date);
      gpstatement.bindColumn(8, idx_region_code);
      gpstatement.bindColumn(9, idx_cn_grade1);
      gpstatement.bindColumn(10, idx_cn_grade_total1);
      gpstatement.bindColumn(11, idx_cn_limit_amt1);
      gpstatement.bindColumn(12, idx_cn_grade2);
      gpstatement.bindColumn(13, idx_cn_grade_total2);
      gpstatement.bindColumn(14, idx_cn_limit_amt2);
      gpstatement.bindColumn(15, idx_cn_grade3);
      gpstatement.bindColumn(16, idx_cn_grade_total3);
      gpstatement.bindColumn(17, idx_cn_limit_amt3);
      gpstatement.bindColumn(18, idx_seq);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(19, idx_sbcr_code);
      gpstatement.bindColumn(20, idx_key_profession_wbs_code);
      gpstatement.bindColumn(21, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from S_LICENSE_STATUS where sbcr_code=? " +
                                              "         and profession_wbs_code=? " +
                                              "         and seq=? " ; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_key_profession_wbs_code);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>