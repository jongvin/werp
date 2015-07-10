<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_sbcr_code_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_key_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_businessman_number = dSet.indexOfColumn("businessman_number");
   	int idx_tmp_businessman_number = dSet.indexOfColumn("tmp_businessman_number");
   	int idx_addr = dSet.indexOfColumn("addr");
   	int idx_reg_no = dSet.indexOfColumn("reg_no");
   	int idx_corp_no = dSet.indexOfColumn("corp_no");
   	int idx_chargename = dSet.indexOfColumn("chargename");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_ownerid = dSet.indexOfColumn("ownerid");
   	int idx_mail_name = dSet.indexOfColumn("mail_name");
   	int idx_mail_address = dSet.indexOfColumn("mail_address");
   	int idx_zip = dSet.indexOfColumn("zip");
   	int idx_tel = dSet.indexOfColumn("tel");
   	int idx_fax = dSet.indexOfColumn("fax");
   	int idx_capital = dSet.indexOfColumn("capital");
   	int idx_sellingamt = dSet.indexOfColumn("sellingamt");
   	int idx_debtamt = dSet.indexOfColumn("debtamt");
   	int idx_items = dSet.indexOfColumn("items");
   	int idx_dealingitem = dSet.indexOfColumn("dealingitem");
   	int idx_isomemo = dSet.indexOfColumn("isomemo");
   	int idx_plantmemo = dSet.indexOfColumn("plantmemo");
   	int idx_remarks = dSet.indexOfColumn("remarks");
   	int idx_orderresult = dSet.indexOfColumn("orderresult");
   	int idx_giyeodo = dSet.indexOfColumn("giyeodo");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_sbcr ( sbcr_code," + 
                    "sbcr_name," + 
                    "businessman_number," + 
                    "addr," + 
                    "reg_no," + 
                    "corp_no," + 
                    "chargename," + 
                    "owner," + 
                    "ownerid," + 
                    "mail_name," + 
                    "mail_address," + 
                    "zip," + 
                    "tel," + 
                    "fax," + 
                    "capital," + 
                    "sellingamt," + 
                    "debtamt," + 
                    "items," + 
                    "dealingitem," + 
                    "isomemo," + 
                    "plantmemo," + 
                    "remarks," + 
                    "orderresult," + 
                    "giyeodo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_sbcr_name);
      gpstatement.bindColumn(3, idx_tmp_businessman_number);
      gpstatement.bindColumn(4, idx_addr);
      gpstatement.bindColumn(5, idx_reg_no);
      gpstatement.bindColumn(6, idx_corp_no);
      gpstatement.bindColumn(7, idx_chargename);
      gpstatement.bindColumn(8, idx_owner);
      gpstatement.bindColumn(9, idx_ownerid);
      gpstatement.bindColumn(10, idx_mail_name);
      gpstatement.bindColumn(11, idx_mail_address);
      gpstatement.bindColumn(12, idx_zip);
      gpstatement.bindColumn(13, idx_tel);
      gpstatement.bindColumn(14, idx_fax);
      gpstatement.bindColumn(15, idx_capital);
      gpstatement.bindColumn(16, idx_sellingamt);
      gpstatement.bindColumn(17, idx_debtamt);
      gpstatement.bindColumn(18, idx_items);
      gpstatement.bindColumn(19, idx_dealingitem);
      gpstatement.bindColumn(20, idx_isomemo);
      gpstatement.bindColumn(21, idx_plantmemo);
      gpstatement.bindColumn(22, idx_remarks);
      gpstatement.bindColumn(23, idx_orderresult);
      gpstatement.bindColumn(24, idx_giyeodo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_sbcr set " + 
                            "sbcr_code=?,  " + 
                            "sbcr_name=?,  " + 
                            "businessman_number=?,  " + 
                            "addr=?,  " + 
                            "reg_no=?,  " + 
                            "corp_no=?,  " + 
                            "chargename=?,  " + 
                            "owner=?,  " + 
                            "ownerid=?,  " + 
                            "mail_name=?,  " + 
                            "mail_address=?,  " + 
                            "zip=?,  " + 
                            "tel=?,  " + 
                            "fax=?,  " + 
                            "capital=?,  " + 
                            "sellingamt=?,  " + 
                            "debtamt=?,  " + 
                            "items=?,  " + 
                            "dealingitem=?,  " + 
                            "isomemo=?,  " + 
                            "plantmemo=?,  " + 
                            "remarks=?,  " + 
                            "orderresult=?,  " + 
                            "giyeodo=?  where sbcr_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_sbcr_name);
      gpstatement.bindColumn(3, idx_tmp_businessman_number);
      gpstatement.bindColumn(4, idx_addr);
      gpstatement.bindColumn(5, idx_reg_no);
      gpstatement.bindColumn(6, idx_corp_no);
      gpstatement.bindColumn(7, idx_chargename);
      gpstatement.bindColumn(8, idx_owner);
      gpstatement.bindColumn(9, idx_ownerid);
      gpstatement.bindColumn(10, idx_mail_name);
      gpstatement.bindColumn(11, idx_mail_address);
      gpstatement.bindColumn(12, idx_zip);
      gpstatement.bindColumn(13, idx_tel);
      gpstatement.bindColumn(14, idx_fax);
      gpstatement.bindColumn(15, idx_capital);
      gpstatement.bindColumn(16, idx_sellingamt);
      gpstatement.bindColumn(17, idx_debtamt);
      gpstatement.bindColumn(18, idx_items);
      gpstatement.bindColumn(19, idx_dealingitem);
      gpstatement.bindColumn(20, idx_isomemo);
      gpstatement.bindColumn(21, idx_plantmemo);
      gpstatement.bindColumn(22, idx_remarks);
      gpstatement.bindColumn(23, idx_orderresult);
      gpstatement.bindColumn(24, idx_giyeodo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(25, idx_key_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_sbcr where sbcr_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>