<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_year = req.getParameter("arg_year");
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("id",GauceDataColumn.TB_DECIMAL,3));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("lyp_tot",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_01",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_02",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_03",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_04",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_05",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_06",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_07",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_08",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_09",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_10",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_11",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_12",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_tot",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tp_tot",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ly_tot",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_01",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_02",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_03",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_04",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_05",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_06",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_07",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_08",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_09",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_10",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_11",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_12",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("comp_tot",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("tot_tot",GauceDataColumn.TB_DECIMAL,18,1));
    String query = "select a.id," + 
     " 		 a.name," + 
     "  		 to_char(a.ly_tot ,'9,999,999.9') lyp_tot," + 
     "  		 to_char(a.comp_01 ,'9,999,999.9') cp_01," + 
     "  		 to_char(a.comp_02 ,'9,999,999.9') cp_02," + 
     "  		 to_char(a.comp_03 ,'9,999,999.9') cp_03," + 
     "  		 to_char(a.comp_04 ,'9,999,999.9') cp_04," + 
     "  		 to_char(a.comp_05 ,'9,999,999.9') cp_05," + 
     "  		 to_char(a.comp_06 ,'9,999,999.9') cp_06," + 
     "  		 to_char(a.comp_07 ,'9,999,999.9') cp_07," + 
     "  		 to_char(a.comp_08 ,'9,999,999.9') cp_08," + 
     "  		 to_char(a.comp_09 ,'9,999,999.9') cp_09," + 
     "  		 to_char(a.comp_10 ,'9,999,999.9') cp_10," + 
     "  		 to_char(a.comp_11 ,'9,999,999.9') cp_11," + 
     "  		 to_char(a.comp_12 ,'9,999,999.9') cp_12," + 
     "  		 to_char(a.comp_tot ,'9,999,999.9') cp_tot," + 
     "  		 to_char(a.tot_tot ,'9,999,999.9') tp_tot," + 
     "  		 nvl(a.ly_tot,0)  ly_tot ," + 
     "  		 nvl(a.comp_01,0)  comp_01 ," + 
     "  		 nvl(a.comp_02,0)  comp_02 ," + 
     "  		 nvl(a.comp_03,0)  comp_03 ," + 
     "  		 nvl(a.comp_04,0)  comp_04 ," + 
     "  		 nvl(a.comp_05,0)  comp_05 ," + 
     "  		 nvl(a.comp_06,0)  comp_06 ," + 
     "  		 nvl(a.comp_07,0)  comp_07 ," + 
     "  		 nvl(a.comp_08,0)  comp_08 ," + 
     "  		 nvl(a.comp_09,0)  comp_09 ," + 
     "  		 nvl(a.comp_10,0)  comp_10 ," + 
     "  		 nvl(a.comp_11,0)  comp_11 ," + 
     "  		 nvl(a.comp_12,0)  comp_12 ," + 
     "  		 nvl(a.comp_tot,0)  comp_tot," + 
     "  		 nvl(a.tot_tot,0)  tot_tot" + 
     " from (" + 
     "  select 18 id,  " + 
     "  		'���ο�' name,  " + 
     "  		AVG(nvl(c.person,0))   ly_tot, " + 
     "  		to_number(sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.person,0),0),0)),'9,999,999.9') comp_01, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.person,0),0),0)) comp_02, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.person,0),0),0)) comp_03, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.person,0),0),0)) comp_04, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.person,0),0),0)) comp_05, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.person,0),0),0)) comp_06, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.person,0),0),0)) comp_07, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.person,0),0),0)) comp_08, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.person,0),0),0)) comp_09, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.person,0),0),0)) comp_10, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.person,0),0),0)) comp_11, " + 
     "  		sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.person,0),0),0)) comp_12, " + 
     "  		sum(nvl(a.person,0))   comp_tot, " + 
     "  		sum(nvl(a.person,0)) + AVG(nvl(c.person,0)) tot_tot " + 
     "  from c_person a, " + 
     "  	  z_code_dept b," + 
     "  	  ( select sum(nvl(a.person,0)) person " + 
     "  			  from c_person a, " + 
     "  					 z_code_dept b " + 
     "  			 where to_char(a.yymm,'YYYY') <  " + "'" + arg_year + "'" + 
     "  			 and b.dept_code = a.dept_code (+) " + 
     "  			 and b.chg_const_start_date is not null " + 
     "  			 and to_char(b.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "  			 and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + "  ) c " + 
     "  where to_char(a.yymm,'YYYY') =  " + "'" + arg_year + "'" + 
     "  	 and b.dept_code = a.dept_code (+) " + 
     "  	 and b.chg_const_start_date is not null " + 
     "  	 and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "  	 and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" +
     " ) a   order by a.id asc  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>