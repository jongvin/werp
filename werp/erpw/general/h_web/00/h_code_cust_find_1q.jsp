<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_gubun = req.getParameter("arg_gubun");
     String arg_cust_name_1 = req.getParameter("arg_cust_name_1");
     String arg_cust_name_2 = req.getParameter("arg_cust_name_2");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("office_phone",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
	 dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("cust_div2",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("div2_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT h_code_cust.cust_code,   " + 
     "         h_code_cust.cust_name,   " + 
     "         h_code_cust.cust_div,   " + 
     "         h_code_cust.home_phone,   " + 
     "         h_code_cust.cell_phone,   " +
	  "         h_code_cust.office_phone,   " + 
	  "         h_code_cust.e_mail,   " + 
	 "         h_code_cust.cur_zip_code,   " + 
	 "         h_code_cust.cur_addr1,   " +
	 "         h_code_cust.cur_addr2,   " +
     "         h_code_common.code_name,  " + 
	  "         h_code_cust.cust_div2, "+
	  "         c.code_name div2_name " +
     "    FROM h_code_cust,   " + 
     "         h_code_common,  " + 
	  "         h_code_common c "+
     "   WHERE (( h_code_cust.cust_div = h_code_common.code(+)) and  " + 
     "         ( h_code_common.code_div(+) = '07' )) and  "+
	  "          h_code_cust.cust_div2 = c.code(+) and "+
	  "          c.code_div(+) = '35' and ";
     if(arg_gubun.equals("1")) {   //�ֹι�ȣ ã�� 
         query = query + " ( h_code_cust.cust_code like " + "'" + arg_cust_name_1 + "%'" + "  ) " ; 
     }     
     if(arg_gubun.equals("2")) {   //���� ã��  
         query = query + " ( h_code_cust.cust_name like '" + arg_cust_name_1 + "%' ) " ; 
     }     
     if(arg_gubun.equals("3")) {   // tab�� ��ȸ  
         query = query + 
                "         ( h_code_cust.cust_name >= '" + arg_cust_name_1 + "') AND  " + 
                "         ( h_code_cust.cust_name < '" + arg_cust_name_2 + "' )          ";
     }     
     if(arg_gubun.equals("4")) {   // �ѱۿ� ��ȸ 
         query = query + 
                "         ( h_code_cust.cust_name < '" + arg_cust_name_1 + "' )          ";
     }  
	  query = query +  "order by h_code_cust.cust_name"; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>