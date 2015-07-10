<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_code_material_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_rentrate = dSet.indexOfColumn("rentrate");
   	int idx_unitcost = dSet.indexOfColumn("unitcost");
   	int idx_kindtag = dSet.indexOfColumn("kindtag");
   	int idx_mtrgrand = dSet.indexOfColumn("mtrgrand");
   	int idx_mtrmiddle = dSet.indexOfColumn("mtrmiddle");
   	int idx_account_code = dSet.indexOfColumn("account_code");
   	int idx_chk = dSet.indexOfColumn("chk");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_years = dSet.indexOfColumn("years");
   	int idx_remainyear = dSet.indexOfColumn("remainyear");
   	int idx_repay_tag = dSet.indexOfColumn("repay_tag");
   	int idx_acctag = dSet.indexOfColumn("acctag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO m_code_material ( mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "ditag," + 
                    "rentrate," + 
                    "unitcost," + 
                    "kindtag," + 
                    "mtrgrand," + 
                    "mtrmiddle," + 
                    "account_code," + 
                    "chk," + 
                    "seq," + 
                    "years," + 
                    "remainyear," + 
                    "repay_tag," + 
                    "acctag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_mtrcode);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_ssize);
      gpstatement.bindColumn(4, idx_unitcode);
      gpstatement.bindColumn(5, idx_ditag);
      gpstatement.bindColumn(6, idx_rentrate);
      gpstatement.bindColumn(7, idx_unitcost);
      gpstatement.bindColumn(8, idx_kindtag);
      gpstatement.bindColumn(9, idx_mtrgrand);
      gpstatement.bindColumn(10, idx_mtrmiddle);
      gpstatement.bindColumn(11, idx_account_code);
      gpstatement.bindColumn(12, idx_chk);
      gpstatement.bindColumn(13, idx_seq);
      gpstatement.bindColumn(14, idx_years);
      gpstatement.bindColumn(15, idx_remainyear);
      gpstatement.bindColumn(16, idx_repay_tag);
      gpstatement.bindColumn(17, idx_acctag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update m_code_material set " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "ditag=?,  " + 
                            "rentrate=?,  " + 
                            "unitcost=?,  " + 
                            "kindtag=?,  " + 
                            "mtrgrand=?,  " + 
                            "mtrmiddle=?,  " + 
                            "account_code=?,  " + 
                            "chk=?,  " + 
                            "seq=?,  " + 
                            "years=?,  " + 
                            "remainyear=?,  " + 
                            "repay_tag=?,  " + 
                            "acctag=?  where mtrcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_mtrcode);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_ssize);
      gpstatement.bindColumn(4, idx_unitcode);
      gpstatement.bindColumn(5, idx_ditag);
      gpstatement.bindColumn(6, idx_rentrate);
      gpstatement.bindColumn(7, idx_unitcost);
      gpstatement.bindColumn(8, idx_kindtag);
      gpstatement.bindColumn(9, idx_mtrgrand);
      gpstatement.bindColumn(10, idx_mtrmiddle);
      gpstatement.bindColumn(11, idx_account_code);
      gpstatement.bindColumn(12, idx_chk);
      gpstatement.bindColumn(13, idx_seq);
      gpstatement.bindColumn(14, idx_years);
      gpstatement.bindColumn(15, idx_remainyear);
      gpstatement.bindColumn(16, idx_repay_tag);
      gpstatement.bindColumn(17, idx_acctag);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(18, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from m_code_material where mtrcode=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>