<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_gauce_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_authority_user_input_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_empno = dSet.indexOfColumn("empno");
   	int idx_user_id = dSet.indexOfColumn("user_id");
   	int idx_password = dSet.indexOfColumn("password");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_english_name = dSet.indexOfColumn("english_name");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_querytag = dSet.indexOfColumn("querytag");
   	int idx_using_tag = dSet.indexOfColumn("using_tag");
   	int idx_g_ipaddress = dSet.indexOfColumn("g_ipaddress");
   	int idx_g_sign_tag = dSet.indexOfColumn("g_sign_tag");
   	int idx_comp_code = dSet.indexOfColumn("compcode");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_authority_user ( empno," + 
                    "user_id," + 
                    "password," + 
                    "name," + 
                    "english_name," + 
                    "dept_code," + 
                    "querytag," + 
                    "using_tag," + 
                    "g_ipaddress," + 
                    "g_sign_tag ,compcode)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10,:11) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_user_id);
      gpstatement.bindColumn(3, idx_password);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_english_name);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_querytag);
      gpstatement.bindColumn(8, idx_using_tag);
      gpstatement.bindColumn(9, idx_g_ipaddress);
      gpstatement.bindColumn(10, idx_g_sign_tag);
      gpstatement.bindColumn(11, idx_comp_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update z_authority_user set " + 
                            "empno=?,  " + 
                            "user_id=?,  " + 
                            "password=?,  " + 
                            "name=?,  " + 
                            "english_name=?,  " + 
                            "dept_code=?,  " + 
                            "querytag=?,  " + 
                            "using_tag=?,  " + 
                            "g_ipaddress=?,  " + 
                            "g_sign_tag=?,compcode=?  where empno=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_user_id);
      gpstatement.bindColumn(3, idx_password);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_english_name);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_querytag);
      gpstatement.bindColumn(8, idx_using_tag);
      gpstatement.bindColumn(9, idx_g_ipaddress);
      gpstatement.bindColumn(10, idx_g_sign_tag);
       gpstatement.bindColumn(11, idx_comp_code);
/* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(12, idx_empno);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from z_authority_user where empno=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_empno);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>