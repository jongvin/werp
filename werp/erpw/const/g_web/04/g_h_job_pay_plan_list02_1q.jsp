<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
   
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_from_date = req.getParameter("arg_from_date");
 String arg_to_date = req.getParameter("arg_to_date");
 String arg_process_tag = req.getParameter("arg_process_tag");
 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sell_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("jan",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("feb",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("mar",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("arp",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("may",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("jun",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("jul",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("aug",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("sep",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("oct",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("nov",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("dec",GauceDataColumn.TB_DECIMAL,18,0));

     String query = "" + 
     "  SELECT   a.dept_code, a.long_name, a.code_name sell_name ,a.sell_code sell_code,	"+
     "   TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '01', a.remaind, 0) )/1000000,0) AS jan, "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '02', a.remaind, 0) )/1000000,0) AS feb,	"+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '03', a.remaind, 0) )/1000000,0) AS mar,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '04', a.remaind, 0) )/1000000,0) AS arp,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '05', a.remaind, 0) )/1000000,0) AS may,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '06', a.remaind, 0) )/1000000,0) AS jun,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '07', a.remaind, 0) )/1000000,0) AS jul,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '08', a.remaind, 0) )/1000000,0) AS aug,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '09', a.remaind, 0) )/1000000,0) AS sep,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '10', a.remaind, 0) )/1000000,0) AS oct,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '11', a.remaind, 0) )/1000000,0) AS nov,	 "+
     "    TRUNC(SUM (DECODE (TO_CHAR (a.agree_date, 'MM'), '12', a.remaind, 0) )/1000000,0) AS dec	 "+
  "  FROM (SELECT a.dept_code, d.long_name, a.sell_code, g.code_name, a.dongho, "+
   "              a.seq, c.agree_date, c.degree_code, c.sell_amt,  "+
   "              DECODE (e.r_amt, '', 0, e.r_amt) AS r_amt,					"+
   "              c.sell_amt - DECODE (e.r_amt, '', 0, e.r_amt) AS remaind "+
   "         FROM H_SALE_MASTER a,																				"+
   "              H_SALE_AGREE c,																								"+
   "              H_CODE_DEPT d,																								 "+
   "              (SELECT   a.dept_code, a.sell_code, a.dongho, a.seq,		 "+
   "                        a.degree_code, SUM (a.r_amt) AS r_amt							 "+
   "                   FROM H_SALE_INCOME a, H_CODE_DEPT b						 "+
   "                  WHERE a.dept_code = b.dept_code AND b.process_code = '01' "+
   "               GROUP BY a.dept_code,  "+
   "                        a.sell_code,  "+
   "                        a.dongho,	  "+
   "                        a.seq,	  "+
   "                        a.degree_code) e,	"+
   "              H_CODE_DEPT f,		"+
   "              H_CODE_COMMON g	"+
   "        WHERE a.dept_code LIKE '"+arg_dept_code+"' || '%'		 "+
   "          AND a.sell_code LIKE '"+arg_sell_code+"' || '%'			 "+
   "          AND f.process_code LIKE DECODE ('"+arg_process_tag+"','ALL', '%', '"+arg_process_tag+"') "+
   "          AND a.dept_code = d.dept_code								"+
   "          AND a.dept_code = c.dept_code(+)			"+
   "          AND a.sell_code = c.sell_code(+)				 "+
   "          AND a.dongho = c.dongho(+)		  "+
   "          AND a.seq = c.seq(+)			  "+
   "          AND c.dept_code = e.dept_code(+)			  "+
   "          AND c.sell_code = e.sell_code(+)			"+
   "          AND c.dongho = e.dongho(+)			"+
   "          AND c.seq = e.seq(+)			"+
   "          AND c.degree_code = e.degree_code(+)		  "+
	 "         AND  C.AGREE_DATE BETWEEN '"+arg_from_date+"' AND '"+arg_to_date+"'"+
   "          AND a.sell_code = g.code			  "+
   "          AND g.code_div = '03'	  "+
   "          AND a.dept_code = f.dept_code			 "+
   "          AND f.process_code = '01'		 "+
   "          AND a.chg_div <> '00'			 "+
   "          AND (a.contract_date <= '"+arg_to_date+"' AND a.chg_date >= '"+arg_to_date+"')) a	 "+
" GROUP BY a.dept_code, a.long_name, a.code_name, a.sell_code	 "+
" ORDER BY a.long_name, a.sell_code ";																															 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>