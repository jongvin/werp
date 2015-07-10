<%@ page session="true"		   contentType="text/html; charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sort_tag",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sido",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("gugun",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("lease_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("union_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("male_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("female_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("years_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("years_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("years_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("years_5",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("years_6",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("years_othr",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT aa.sort_tag,  " + 
     "            aa.sido,  " + 
     "            aa.gugun,  " + 
     "            SUM(NVL(aa.lease_cnt,0)) lease_cnt,  " + 
     "            SUM(NVL(aa.sale_cnt,0)) sale_cnt,  " + 
     "	         SUM(NVL(aa.union_cnt,0)) union_cnt,  " + 
     "            SUM(NVL(aa.male_cnt,0)) male_cnt,  " + 
     "            SUM(NVL(aa.female_cnt,0)) female_cnt,  " + 
     "            SUM(NVL(aa.years_2,0)) years_2,  " + 
     "            SUM(NVL(aa.years_3,0)) years_3,  " + 
     "            SUM(NVL(aa.years_4,0)) years_4,  " + 
     "            SUM(NVL(aa.years_5,0)) years_5,  " + 
     "            SUM(NVL(aa.years_6,0)) years_6,  " + 
     "            SUM(NVL(aa.years_othr,0)) years_othr" + 
     "" + 
     " FROM( SELECT  DISTINCT c.long_name, " + 
     "        TO_CHAR(a.subs_no) AS dongho, " + 
     "        DECODE(f.sido, '서울', '1', '경기', '2', '제주', '8', NULL, '9', '3') || NVL(f.sido, '기타') || f.gugun  sort_tag, " + 
     "        NVL(f.sido, '기타')  sido,  " + 
     "        NVL(f.gugun, '기타') gugun,  " + 
     "        1  subs_cnt,    " + 
     "        0 lease_cnt,    " + 
     "        0 sale_cnt," + 
     "        0 union_cnt,    " + 
     "        0 male_cnt,  " + 
     "        0 female_cnt,  " + 
     "        0 years_2, " + 
     "        0 years_3, " + 
     "        0 years_4, " + 
     "        0 years_5," + 
     "        0 years_6,  " + 
     "        0 years_othr  " + 
     "	FROM H_SUBS_MASTER  a," + 
     "	          H_CODE_CUST	 	b," + 
     "	          H_CODE_DEPT 	c," + 
     "	          Z_CODE_ZIP     f" + 
     "	WHERE a.cust_code  = b.cust_code 	 " + 
     "	  AND a.dept_code     =  c.dept_code 	 " + 
     "	  AND b.cur_zip_code = 	f.zipcode (+)	 " + 
     "	  AND a.dept_code  = '"+arg_dept_code		+"'" + 
     "	  AND a.sell_code   = '"+arg_sell_code+"'" + 
     " UNION ALL" + 
     " SELECT  DISTINCT c.long_name, " + 
     "        a.dongho AS dongho, " + 
     "        DECODE(f.sido, '서울', '1', '경기', '2', '제주', '8', NULL, '9', '3') || NVL(f.sido, '기타') || f.gugun  sort_tag, " + 
     "        NVL(f.sido, '기타')  sido,  " + 
     "        NVL(f.gugun, '기타') gugun,  " + 
     "        0  subs_cnt,    " + 
     "        DECODE(a.contract_code, '03', 1, 0) lease_cnt,    " + 
     "        DECODE(a.contract_code, '01', 1, 0) sale_cnt," + 
     "        DECODE(a.contract_code, '02', 1, 0) union_cnt,    " + 
     "        DECODE(SUBSTR(REPLACE(b.cust_code,'-',''),7,1), '1', 1, 0) male_cnt,  " + 
     "        DECODE(SUBSTR(REPLACE(b.cust_code,'-',''),7,1), '1', 0, 1) female_cnt,  " + 
     "        DECODE(TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'yy')) + 100 - TO_NUMBER(SUBSTR(b.cust_code, 1, 2))) / 10, 0), 2, 1, 0)  years_2, " + 
     "        DECODE(TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'yy')) + 100 - TO_NUMBER(SUBSTR(b.cust_code, 1, 2))) / 10, 0), 3, 1, 0)  years_3, " + 
     "        DECODE(TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'yy')) + 100 - TO_NUMBER(SUBSTR(b.cust_code, 1, 2))) / 10, 0), 4, 1, 0)  years_4, " + 
     "        DECODE(TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'yy')) + 100 - TO_NUMBER(SUBSTR(b.cust_code, 1, 2))) / 10, 0), 5, 1, 0)  years_5," + 
     "        DECODE(TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'yy')) + 100 - TO_NUMBER(SUBSTR(b.cust_code, 1, 2))) / 10, 0), 6, 1, 0)  years_6,  " + 
     "        DECODE(TRUNC((TO_NUMBER(TO_CHAR(SYSDATE, 'yy')) + 100 - TO_NUMBER(SUBSTR(b.cust_code, 1, 2))) / 10, 0), 2, 0, 3, 0, 4, 0, 5, 0, 6, 0, 1)  years_othr  " + 
     "	FROM H_SALE_MASTER   a," + 
     "	     H_CODE_CUST	 	b," + 
     "	     H_CODE_DEPT     c," + 
     "	     Z_CODE_ZIP      f" + 
     "	WHERE a.cust_code = b.cust_code 	 " + 
     "	  AND a.dept_code = c.dept_code 	 " + 
     "	  AND b.cur_zip_code = f.zipcode (+)	 " + 
     "	  AND a.contract_yn = 'Y' " + 
     "	  AND a.dept_code = '"+arg_dept_code+"'" + 
     "	  AND a.sell_code = '"+arg_sell_code+"') AA" + 
     " GROUP BY aa.sort_tag,  " + 
     "            aa.sido,  " + 
     "            aa.gugun          "+
	  "   order by aa.sort_tag";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>