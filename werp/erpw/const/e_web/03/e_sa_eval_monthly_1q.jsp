<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
//     String arg_search = req.getParameter("arg_search");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("key_yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("reform_part",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("reform_order",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("reform_order_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("reform_measures",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("reform_measures_check",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("reform_measures_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("reform_result",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("reform_result_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("checker_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sum_all",GauceDataColumn.TB_DECIMAL,5,2));
    String query = "  SELECT a.dept_code,   " +
     "                       b.long_name, " + 
     "               to_char(a.yymm,'yyyymm') yymm,   " + 
     "               to_char(a.yymm,'yyyymmdd') key_yymm,   " +
     "               to_char(a.start_date,'yyyymmdd') start_date,   " + 
     "               to_char(a.end_date,'yyyymmdd') end_date,   " + 
     "                       a.reform_part,   " + 
     "                       a.reform_order,   " + 
     "               to_char(a.reform_order_date,'yyyy.mm.dd') reform_order_date,   " + 
     "                       a.reform_measures,   " + 
     "               to_char(a.reform_measures_date,'yyyy.mm.dd') reform_measures_date,   " + 
     "                       a.reform_measures_check,   " + 
     "                       a.reform_result,   " + 
     "               to_char(a.reform_result_date,'yyyy.mm.dd') reform_result_date,   " + 
     "                       a.checker_name,   " + 
     "                       a.remark,  " +      
     "      nvl  " +
     "	   (((select sum(decode(n_a,'F',or_point)) from  e_opinion_detail  " +
     "		where  yymm=a.yymm and dept_code = a.dept_code and seq < 12  )		 " +
     "		 /  " +
     "		(select nvl(sum(decode(n_a,'F',l.or_point)),0) from  e_opinion_detail d , e_opinion_list l " +
     "		where  d.yymm=a.yymm and d.dept_code = a.dept_code and d.seq < 12  and " +
     "			   d.yymm = l.yymm and d.dept_code = l.dept_code and l.yymm=a.yymm and d.seq = l.seq " +
     "		) " +
     "		*  20 ),0)  +  " +
     "		nvl " +
     "        (((select sum(decode(n_a,'F',nvl(or_point,0))) from  e_opinion_detail  " +
     "		where  yymm=a.yymm and dept_code = a.dept_code and seq  >= 12  )		 " +
     "		 /  " +
     "		(select nvl(sum(decode(n_a,'F',l.or_point)),0) from  e_opinion_detail d , e_opinion_list l " +
     "		where  d.yymm=a.yymm and d.dept_code = a.dept_code and d.seq  >= 12  and " +
     "			   d.yymm = l.yymm and d.dept_code = l.dept_code and l.yymm=a.yymm and d.seq = l.seq " +
     "		) " +
     "		*  80 ),0) +  " +
	  " 		nvl(( select or_point from e_opinion_minus_detail  " +
	  "	where dept_code = a.dept_code and yymm = a.yymm and seq = 1 ),0) +  " +
	  "      nvl(( select or_point from e_opinion_minus_detail  " +
	  "	where dept_code = a.dept_code and yymm = a.yymm and seq = 2 ),0) " + 
	  "				sum_all " +
     "                   FROM e_opinion a, " + 
     "                        (select dept_code, long_name from z_code_dept) b " +
     "                   WHERE a.dept_code = b.dept_code " +
     "                   ORDER BY a.dept_code ASC,   " + 
     "                            a.yymm DESC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>