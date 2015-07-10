<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_mssql_portal_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	  String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name_han",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name_eng",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("zip",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("origin_addr1",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("tel",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pcs",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("marriage",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("birth",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("birth_sl",GauceDataColumn.TB_STRING,20));
    String query = "SELECT a.resident_no, 																" +
						 " 		b.code2 as sex,                                                " +
						 "			a.name_han,                                                    " +
						 "			a.name_eng,                                                    " +
						 "			a.zip,                                                         " +
						 "			a.addr1 + a.addr2 + a.addr3 addr1,                             " +
						 "			a.addr4 addr2,                                                 " +
						 "			a.origin_addr1 + a.origin_addr2 + a.origin_addr3 origin_addr1, " +
						 "			a.tel,                                                         " +
						 "			a.pcs,                                                         " +
						 "			a.m_gun,                                                       " +
						 "			a.m_bg,                                                        " +
						 "			c.code2 as marriage,                                           " +
						 "			CONVERT(VARCHAR(8),a.birth,112) birth,                           " +
						 "			d.code2 as birth_sl                                            " +
						 "	 from recruit_resume a left outer join recruit_code_table b          " +
						 "	   on b.code_group = 'SEX'                                           " +
						 "	  and a.sex =  b.code                                                " +
						 "       left outer join recruit_code_table c                           " +
						 "	   on c.code_group = 'MARRIAGE'                                      " +
						 "	  and a.marriage = c.code                                            " +
						 "       left outer join recruit_code_table d                           " +
						 "		on	d.code_group = 'BIRTH_SL'                                      " +
						 "	  and a.birth_sl = d.code                                            " +
						 "	where a.resident_no = '"+ arg_resident_no +"' " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>