<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_person_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_proj_prog_type = dSet.indexOfColumn("proj_prog_type");
   	int idx_proj_name = dSet.indexOfColumn("proj_name");
   	int idx_splan_date = dSet.indexOfColumn("splan_date");
   	int idx_p_1 = dSet.indexOfColumn("p_1");
   	int idx_p_2 = dSet.indexOfColumn("p_2");
   	int idx_p_3 = dSet.indexOfColumn("p_3");
   	int idx_p_4 = dSet.indexOfColumn("p_4");
   	int idx_p_5 = dSet.indexOfColumn("p_5");
   	int idx_p_6 = dSet.indexOfColumn("p_6");
   	int idx_p_7 = dSet.indexOfColumn("p_7");
   	int idx_p_8 = dSet.indexOfColumn("p_8");
   	int idx_p_9 = dSet.indexOfColumn("p_9");
   	int idx_p_10 = dSet.indexOfColumn("p_10");
   	int idx_p_11 = dSet.indexOfColumn("p_11");
   	int idx_p_12 = dSet.indexOfColumn("p_12");
   	int idx_p_13 = dSet.indexOfColumn("p_13");
   	int idx_p_14 = dSet.indexOfColumn("p_14");
   	int idx_p_15 = dSet.indexOfColumn("p_15");
   	int idx_p_16 = dSet.indexOfColumn("p_16");
   	int idx_p_17 = dSet.indexOfColumn("p_17");
   	int idx_p_18 = dSet.indexOfColumn("p_18");
   	int idx_p_19 = dSet.indexOfColumn("p_19");
   	int idx_p_20 = dSet.indexOfColumn("p_20");
   	int idx_p_21 = dSet.indexOfColumn("p_21");
   	int idx_p_22 = dSet.indexOfColumn("p_22");
   	int idx_p_23 = dSet.indexOfColumn("p_23");
   	int idx_p_24 = dSet.indexOfColumn("p_24");
   	int idx_p_25 = dSet.indexOfColumn("p_25");
   	int idx_p_26 = dSet.indexOfColumn("p_26");
   	int idx_p_27 = dSet.indexOfColumn("p_27");
   	int idx_p_28 = dSet.indexOfColumn("p_28");
   	int idx_p_29 = dSet.indexOfColumn("p_29");
   	int idx_p_30 = dSet.indexOfColumn("p_30");
   	int idx_p_31 = dSet.indexOfColumn("p_31");
   	int idx_p_32 = dSet.indexOfColumn("p_32");
   	int idx_p_33 = dSet.indexOfColumn("p_33");
   	int idx_p_34 = dSet.indexOfColumn("p_34");
   	int idx_p_35 = dSet.indexOfColumn("p_35");
   	int idx_p_36 = dSet.indexOfColumn("p_36");
   	int idx_p_37 = dSet.indexOfColumn("p_37");
   	int idx_p_38 = dSet.indexOfColumn("p_38");
   	int idx_p_39 = dSet.indexOfColumn("p_39");
   	int idx_p_40 = dSet.indexOfColumn("p_40");
   	int idx_p_41 = dSet.indexOfColumn("p_41");
   	int idx_p_42 = dSet.indexOfColumn("p_42");
   	int idx_p_43 = dSet.indexOfColumn("p_43");
   	int idx_p_44 = dSet.indexOfColumn("p_44");
   	int idx_p_45 = dSet.indexOfColumn("p_45");
   	int idx_p_46 = dSet.indexOfColumn("p_46");
   	int idx_p_47 = dSet.indexOfColumn("p_47");
   	int idx_p_48 = dSet.indexOfColumn("p_48");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO g_mis_person ( work_year," + 
                    "spec_no_seq," + 
                    "no_seq," + 
                    "proj_prog_type," + 
                    "proj_name," + 
                    "splan_date," + 
                    "p_1," + 
                    "p_2," + 
                    "p_3," + 
                    "p_4," + 
                    "p_5," + 
                    "p_6," + 
                    "p_7," + 
                    "p_8," + 
                    "p_9," + 
                    "p_10," + 
                    "p_11," + 
                    "p_12," + 
                    "p_13," + 
                    "p_14," + 
                    "p_15," + 
                    "p_16," + 
                    "p_17," + 
                    "p_18," + 
                    "p_19," + 
                    "p_20," + 
                    "p_21," + 
                    "p_22," + 
                    "p_23," + 
                    "p_24," + 
                    "p_25," + 
                    "p_26," + 
                    "p_27," + 
                    "p_28," + 
                    "p_29," + 
                    "p_30," + 
                    "p_31," + 
                    "p_32," + 
                    "p_33," + 
                    "p_34," + 
                    "p_35," + 
                    "p_36," + 
                    "p_37," + 
                    "p_38," + 
                    "p_39," + 
                    "p_40," + 
                    "p_41," + 
                    "p_42," + 
                    "p_43," + 
                    "p_44," + 
                    "p_45," + 
                    "p_46," + 
                    "p_47," + 
                    "p_48 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_proj_prog_type);
      gpstatement.bindColumn(5, idx_proj_name);
      gpstatement.bindColumn(6, idx_splan_date);
      gpstatement.bindColumn(7, idx_p_1);
      gpstatement.bindColumn(8, idx_p_2);
      gpstatement.bindColumn(9, idx_p_3);
      gpstatement.bindColumn(10, idx_p_4);
      gpstatement.bindColumn(11, idx_p_5);
      gpstatement.bindColumn(12, idx_p_6);
      gpstatement.bindColumn(13, idx_p_7);
      gpstatement.bindColumn(14, idx_p_8);
      gpstatement.bindColumn(15, idx_p_9);
      gpstatement.bindColumn(16, idx_p_10);
      gpstatement.bindColumn(17, idx_p_11);
      gpstatement.bindColumn(18, idx_p_12);
      gpstatement.bindColumn(19, idx_p_13);
      gpstatement.bindColumn(20, idx_p_14);
      gpstatement.bindColumn(21, idx_p_15);
      gpstatement.bindColumn(22, idx_p_16);
      gpstatement.bindColumn(23, idx_p_17);
      gpstatement.bindColumn(24, idx_p_18);
      gpstatement.bindColumn(25, idx_p_19);
      gpstatement.bindColumn(26, idx_p_20);
      gpstatement.bindColumn(27, idx_p_21);
      gpstatement.bindColumn(28, idx_p_22);
      gpstatement.bindColumn(29, idx_p_23);
      gpstatement.bindColumn(30, idx_p_24);
      gpstatement.bindColumn(31, idx_p_25);
      gpstatement.bindColumn(32, idx_p_26);
      gpstatement.bindColumn(33, idx_p_27);
      gpstatement.bindColumn(34, idx_p_28);
      gpstatement.bindColumn(35, idx_p_29);
      gpstatement.bindColumn(36, idx_p_30);
      gpstatement.bindColumn(37, idx_p_31);
      gpstatement.bindColumn(38, idx_p_32);
      gpstatement.bindColumn(39, idx_p_33);
      gpstatement.bindColumn(40, idx_p_34);
      gpstatement.bindColumn(41, idx_p_35);
      gpstatement.bindColumn(42, idx_p_36);
      gpstatement.bindColumn(43, idx_p_37);
      gpstatement.bindColumn(44, idx_p_38);
      gpstatement.bindColumn(45, idx_p_39);
      gpstatement.bindColumn(46, idx_p_40);
      gpstatement.bindColumn(47, idx_p_41);
      gpstatement.bindColumn(48, idx_p_42);
      gpstatement.bindColumn(49, idx_p_43);
      gpstatement.bindColumn(50, idx_p_44);
      gpstatement.bindColumn(51, idx_p_45);
      gpstatement.bindColumn(52, idx_p_46);
      gpstatement.bindColumn(53, idx_p_47);
      gpstatement.bindColumn(54, idx_p_48);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_person set " + 
                            "work_year=?,  " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "proj_prog_type=?,  " + 
                            "proj_name=?,  " + 
                            "splan_date=?,  " + 
                            "p_1=?,  " + 
                            "p_2=?,  " + 
                            "p_3=?,  " + 
                            "p_4=?,  " + 
                            "p_5=?,  " + 
                            "p_6=?,  " + 
                            "p_7=?,  " + 
                            "p_8=?,  " + 
                            "p_9=?,  " + 
                            "p_10=?,  " + 
                            "p_11=?,  " + 
                            "p_12=?,  " + 
                            "p_13=?,  " + 
                            "p_14=?,  " + 
                            "p_15=?,  " + 
                            "p_16=?,  " + 
                            "p_17=?,  " + 
                            "p_18=?,  " + 
                            "p_19=?,  " + 
                            "p_20=?,  " + 
                            "p_21=?,  " + 
                            "p_22=?,  " + 
                            "p_23=?,  " + 
                            "p_24=?,  " + 
                            "p_25=?,  " + 
                            "p_26=?,  " + 
                            "p_27=?,  " + 
                            "p_28=?,  " + 
                            "p_29=?,  " + 
                            "p_30=?,  " + 
                            "p_31=?,  " + 
                            "p_32=?,  " + 
                            "p_33=?,  " + 
                            "p_34=?,  " + 
                            "p_35=?,  " + 
                            "p_36=?,  " + 
                            "p_37=?,  " + 
                            "p_38=?,  " + 
                            "p_39=?,  " + 
                            "p_40=?,  " + 
                            "p_41=?,  " + 
                            "p_42=?,  " + 
                            "p_43=?,  " + 
                            "p_44=?,  " + 
                            "p_45=?,  " + 
                            "p_46=?,  " + 
                            "p_47=?,  " + 
                            "p_48=?  where work_year=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_proj_prog_type);
      gpstatement.bindColumn(5, idx_proj_name);
      gpstatement.bindColumn(6, idx_splan_date);
      gpstatement.bindColumn(7, idx_p_1);
      gpstatement.bindColumn(8, idx_p_2);
      gpstatement.bindColumn(9, idx_p_3);
      gpstatement.bindColumn(10, idx_p_4);
      gpstatement.bindColumn(11, idx_p_5);
      gpstatement.bindColumn(12, idx_p_6);
      gpstatement.bindColumn(13, idx_p_7);
      gpstatement.bindColumn(14, idx_p_8);
      gpstatement.bindColumn(15, idx_p_9);
      gpstatement.bindColumn(16, idx_p_10);
      gpstatement.bindColumn(17, idx_p_11);
      gpstatement.bindColumn(18, idx_p_12);
      gpstatement.bindColumn(19, idx_p_13);
      gpstatement.bindColumn(20, idx_p_14);
      gpstatement.bindColumn(21, idx_p_15);
      gpstatement.bindColumn(22, idx_p_16);
      gpstatement.bindColumn(23, idx_p_17);
      gpstatement.bindColumn(24, idx_p_18);
      gpstatement.bindColumn(25, idx_p_19);
      gpstatement.bindColumn(26, idx_p_20);
      gpstatement.bindColumn(27, idx_p_21);
      gpstatement.bindColumn(28, idx_p_22);
      gpstatement.bindColumn(29, idx_p_23);
      gpstatement.bindColumn(30, idx_p_24);
      gpstatement.bindColumn(31, idx_p_25);
      gpstatement.bindColumn(32, idx_p_26);
      gpstatement.bindColumn(33, idx_p_27);
      gpstatement.bindColumn(34, idx_p_28);
      gpstatement.bindColumn(35, idx_p_29);
      gpstatement.bindColumn(36, idx_p_30);
      gpstatement.bindColumn(37, idx_p_31);
      gpstatement.bindColumn(38, idx_p_32);
      gpstatement.bindColumn(39, idx_p_33);
      gpstatement.bindColumn(40, idx_p_34);
      gpstatement.bindColumn(41, idx_p_35);
      gpstatement.bindColumn(42, idx_p_36);
      gpstatement.bindColumn(43, idx_p_37);
      gpstatement.bindColumn(44, idx_p_38);
      gpstatement.bindColumn(45, idx_p_39);
      gpstatement.bindColumn(46, idx_p_40);
      gpstatement.bindColumn(47, idx_p_41);
      gpstatement.bindColumn(48, idx_p_42);
      gpstatement.bindColumn(49, idx_p_43);
      gpstatement.bindColumn(50, idx_p_44);
      gpstatement.bindColumn(51, idx_p_45);
      gpstatement.bindColumn(52, idx_p_46);
      gpstatement.bindColumn(53, idx_p_47);
      gpstatement.bindColumn(54, idx_p_48);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(55, idx_work_year);
      gpstatement.bindColumn(56, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_person where work_year=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>